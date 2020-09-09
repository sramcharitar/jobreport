package jobreport

import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('IS_AUTHENTICATED_FULLY')
@Transactional(readOnly = true)
class UtilsController {
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {}

    def formatToLocale() {
        def n = params.num
        if(n.isNumber()){
            render formatNumber(type: 'number', number: n, groupingUsed: true,  maxFractionDigits: 0, minFractionDigits: 0)
        }
        else {
            render URLEncoder.encode(n)
        }
    }

    def formatPercentage(){
        //println "format percentage"
        def n = params.num?.toBigDecimal()
        //println n
        if(n){
            //println "formatted number : ${formatNumber(type: 'number', number: n, groupingUsed: false,  maxFractionDigits: 2, minFractionDigits: 2)}"
            render formatNumber(type: 'number', number: n, groupingUsed: false,  maxFractionDigits: 2, minFractionDigits: 2)
        }
        else {
            render n
        }
    }

    def formatCurrency(){
        def n = params.num
        if(n.isNumber()) {
            render formatNumber(type: 'number', number: n, groupingUsed: true, maxFractionDigits: 2, minFractionDigits: 2)
        }
        else {
            render URLEncoder.encode(n)
        }
    }
}
