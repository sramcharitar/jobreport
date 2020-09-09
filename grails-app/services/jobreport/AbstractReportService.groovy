package jobreport

import grails.gorm.transactions.Transactional
import org.apache.poi.ss.usermodel.HorizontalAlignment
import org.springframework.context.NoSuchMessageException

import java.math.MathContext
import java.math.RoundingMode
import java.text.NumberFormat
import java.text.SimpleDateFormat

@Transactional
abstract class AbstractReportService {
    static int MAX_ROWS_PER_PAGE = 45
    static int HEADER_ROWS = 14

    def reportMessageService

    NumberFormat f2d
    NumberFormat f3d
    NumberFormat f2p
    NumberFormat f3p
    Locale locale
    SimpleDateFormat formatter

    static void initializeFormatter(String format, Locale locale) {
        ThreadLocalFormatter.initialize(format, locale)
    }

    def msg(String key, List objs = null) {
        if (key) {
            try {
                reportMessageService.message(key.contains('.') ? key : "reports.label.${key}", objs)
                        .replace((char) 160, (char) 32)
            } catch (NoSuchMessageException nsm) {
                log.error("Exception: " + nsm)
                "** reports.label.${key} - does not exist"
            }
        } else {
            " "
        }
    }

    def getFont() {
        [font: [family: 'Times-Roman', size: 7.pt], margin: [top: 0.25.inches, bottom: 0.25.inches]]
    }

    def f2_100(Number number, Locale locale) {
        if (number != null) {
            f2(number * 100, locale)
        } else {
            " "
        }
    }

    def af2(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure(f2(value, locale), pos)
    }

    def getClosure(def value, boolean pos) {
        def clos = {
            text ((pos ? '' : '(') + value + (pos ? '' : ')'), font: [color: pos ? '#000000' : '#FF0000'])
        }
        clos
    }

    def getClosure2(def value, boolean pos) {
        def clos = {
            text ((pos ? '' : '(') + value + (pos ? '' : ')'), font: [color: pos ? '#0000FF' : '#FF0000'])
        }
        clos
    }

    def af0(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure(f0(value, locale), pos)
    }

    def af3(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure(f3(value, locale), pos)
    }

    def ap2(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure(p2(value, locale), pos)
    }

    def ap4(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure2(p2(value, locale), pos)
    }

    def ap3(Number value, def locale) {
        def pos = true
        if (value < 0) {
            pos = false
            value *= -1
        }
        getClosure(p3(value, locale), pos)
    }

    Map xlNumberFormat() {
        [alignment: HorizontalAlignment.RIGHT]
    }

    def yearRowXl(start, end, skip = 2) {
        def clos = {
            skipCells(skip)
            (start..end).each {
                cell(msg("year") + " ${it}", [font: [bold: true, size: 10]])
            }
        }
        clos
    }

    def yearRow(start, end) {
        def clos = {
            cell("  ")
            cell("  ")
            (start..end).each {
                cell(msg("year") + " ${it + 1}", font: [bold: true], align: 'right')
            }
        }
        clos
    }

    def heading(Locale locale,
                def scenario,
                def showBoardRate = false, def facility = null, def facilityInfo = null, def bOption = null) {
        def clos = {
            row {
                cell(msg("primeRate"))
                if (showBoardRate) {
                    cell(p3(scenario.primeRate, locale), colspan: 2)
                    cell(msg("usdBoardRate"));
                    cell(f3(scenario.USBoardRate, locale))
                } else {
                    cell(p3(scenario.primeRate, locale), colspan: 4)
                }
            }
            row {
                cell(msg("snClientName"))
                cell(cleanTxt(scenario.clientName), colspan: 4)
            }
            if (facility) {
                row {
                    cell("")
                    cell(msg("borrowerSrf"))
                    cell(facilityInfo.borrowerSrf)
                    cell(msg("borrowerBrr"))
                    cell(cleanTxt(facilityInfo.borrowerBrr))
                }
                row {
                    cell("")
                    cell(msg("gbrrBusSeg"))
                    cell(msg(facilityInfo.gbrrBusinessSegmentMessageCode), colspan: 3)
                }
            } else {
                row {
                    cell(" ")
                    cell(msg("snsrf"))
                    cell(scenario.srf)
                    cell(msg("snrr"))
                    cell(scenario.brr)
                }
                row {
                    cell(" ")
                    cell(msg("businessSegment"))
                    cell(msg(scenario.businessSegmentMessageCode), colspan: 3)
                }

            }
            row {
                cell(msg("accountManager"))
                cell(cleanTxt(scenario.accountManager), colspan: 4)
            }
            row{
                cell (" ")
                cell(msg("amNumber"))
                cell(scenario.number)
                cell(msg("responsibilityTransit"))
                cell(scenario.responsibilityTransit)
            }
            if (facility) {
                row {
                    cell(msg("facility"))
                    cell(cleanTxt(CalculatorUtils.removeId(facility)))
                    cell(msg("type"))
                    cell(msg(facilityInfo.typeMessageCode))
                }
                row {
                    cell(msg("gbrr"))
                    cell(facilityInfo.gbrr)
                    cell(msg("termToMaturity"))
                    cell(facilityInfo.termToMaturity)
                }
                row {
                    cell(msg("commitmentStatus"))
                    cell(facilityInfo.commitmentStatus ? msg("committed") : msg("uncommitted"))
                    cell(msg("abf"))
                    cell(facilityInfo.abf ? msg("reports.label.yes") : msg("reports.label.no"))
                }
                row {
                    cell(msg("collateralSecurity"))
                    cell(msg(facilityInfo.collateralSecurityMessageCode) + " " + p3(facilityInfo.lgdRate, locale), colspan: 3)
                }
            }
            if (bOption) {
                row {
                    cell(msg("borrowingOption"))
                    cell(getNameFromBO(bOption), colspan: 2)
                }
            }
        }
        clos
    }

    def ending1(Locale locale, def start, def end, def calculator, def rowCounter = new RowCounter()) {
        def clos = {
            row {
                cell(msg("netIncomeBeforeTax"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.netIncomeBeforeTax[index]), locale))
                }
                rowCounter.count++
            }
            row {
                cell(msg("taxes"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.taxes[index]), locale))
                }
                rowCounter.count++
            }
            row {
                cell(msg("netIncomeAfterTax"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.netIncomeAfterTax[index]), locale))
                }
                rowCounter.count++
            }
        }
        clos
    }

    def ending1a(Locale locale, def start, def end, def calculator, def rowCounter = new RowCounter()) {
        def clos =  []
        clos.add {
            row {
                cell(msg("netIncomeBeforeTax"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.netIncomeBeforeTax[index]), locale))
                }
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell(msg("taxes"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.taxes[index]), locale))
                }
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell(msg("netIncomeAfterTax"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.netIncomeAfterTax[index]), locale))
                }
                rowCounter.count++
            }
        }
        clos
    }

    def ending2(Locale locale, def start, def end, def calculator, def rowCounter = new RowCounter()) {
        def clos = {
            row(font: [bold: true, italic: true, color: '#0000FF']) {
                cell(msg("rorc"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', ap4(calculator.rorc[index], locale))
                }
                rowCounter.count++
            }
            row(font: [bold: true, italic: true, color: '#0000FF']) {
                cell(msg("overallRorc"))
                cell(align: 'right', ap4(calculator.overallRorc, locale), )
                rowCounter.count++
            }
            row {
                cell("   ")
                rowCounter.count++
            }
            row {
                cell(msg("economicRoe"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', ap2(calculator.roe[index], locale))
                }
                rowCounter.count++
            }
            row {
                cell(msg("overallEconomicRoe"))
                cell(align: 'right', ap2(calculator.overallRoe, locale))
                rowCounter.count++
            }
            row {
                cell("   ")
                rowCounter.count++
            }
            row {
                cell(msg("economicProfitNiacc"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.niacc[index]), locale))
                }
                rowCounter.count++
            }
            row {
                cell("   ")
                rowCounter.count++
            }
            row {
                cell(msg("npvEconomicProfitNiacc"))
                cell(align: 'right', af2(toThousands(calculator.npvNiacc), locale))
                rowCounter.count++
            }
        }
        clos
    }

    def ending2a(Locale locale, def start, def end, def calculator, def rowCounter = new RowCounter()) {
        def clos = []
        clos.add {
            row(font: [bold: true, italic: true, color: '#0000FF']) {
                cell(msg("rorc"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', ap4(calculator.rorc[index], locale))
                }
                rowCounter.count++
            }
        }
        clos.add {
            row(font: [bold: true, italic: true, color: '#0000FF']) {
                cell(msg("overallRorc"))
                cell(align: 'right', ap4(calculator.overallRorc, locale),)
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell("   ")
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell(msg("economicRoe"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', ap2(calculator.roe[index], locale))
                }
            }
            rowCounter.count++
        }
        clos.add {
            row {
                cell(msg("overallEconomicRoe"))
                cell(align: 'right', ap2(calculator.overallRoe, locale))
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell("   ")
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell(msg("economicProfitNiacc"))
                cell("  ")
                (start..end).each { index ->
                    cell(align: 'right', af2(toThousands(calculator.niacc[index]), locale))
                }
                rowCounter.count++
            }
        }
        clos.add {
            row {
                cell(msg("npvEconomicProfitNiacc"))
                cell(align: 'right', af2(toThousands(calculator.npvNiacc), locale))
                rowCounter.count++
            }
        }
        clos
    }

    int getPages(def analyseOver) {
        new BigDecimal(analyseOver).divide(5, MathContext.DECIMAL128).setScale(0, RoundingMode.UP)
    }

    static class RowCounter {
        int count = 0
    }

    def yearRowTableClosure(def start, def end) {
        def clos = {
            row(yearRow(start, end))
        }
        clos
    }

    static String nbs = "\u00A0"

    String cleanTxt(String text) {
        if (text?.contains(nbs)) {
            log.error("String '${text}' contains illegal character")
        }
        text?.replace((char)160, (char)32)
    }

}
