package jobreport;

import java.math.RoundingMode;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class ThreadLocalFormatter {
    private static ThreadLocal<ThreadLocalFormatter> tlFormatter = new ThreadLocal<>();
    NumberFormat f0d;
    NumberFormat f2d;
    NumberFormat f3d;
    NumberFormat f2p;
    NumberFormat f3p;
    Locale locale;
    SimpleDateFormat dateFormat;

    private ThreadLocalFormatter() {
    }

    public static ThreadLocalFormatter getFormatter() {
        ThreadLocalFormatter get = tlFormatter.get();
        if (get == null) {
            throw new UnsupportedOperationException("Can't retrieve formatter without first initializing");
        }
        return get;
    }

    public static void initialize(String dateFormat, Locale locale) {
        ThreadLocalFormatter get = tlFormatter.get();
        if (get == null) {
            get = new ThreadLocalFormatter();
            tlFormatter.set(get);
        }
        if (get.locale != locale || get.f2d == null) {
            get.f2p = NumberFormat.getPercentInstance(locale);
            get.f2p.setMinimumFractionDigits(2);
            get.f2p.setMaximumFractionDigits(2);
            get.f2p.setRoundingMode(RoundingMode.HALF_UP);
            get.f3p = NumberFormat.getPercentInstance(locale);
            get.f3p.setMinimumFractionDigits(3);
            get.f3p.setMaximumFractionDigits(3);
            get.f3p.setRoundingMode(RoundingMode.HALF_UP);
            get.f0d = NumberFormat.getNumberInstance(locale);
            get.f0d.setMinimumFractionDigits(0);
            get.f0d.setMaximumFractionDigits(0);
            get.f0d.setRoundingMode(RoundingMode.HALF_UP);
            get.f2d = NumberFormat.getNumberInstance(locale);
            get.f2d.setMinimumFractionDigits(2);
            get.f2d.setMaximumFractionDigits(2);
            get.f2d.setRoundingMode(RoundingMode.HALF_UP);
            get.f3d = NumberFormat.getNumberInstance(locale);
            get.f3d.setMinimumFractionDigits(3);
            get.f3d.setMaximumFractionDigits(3);
            get.f3d.setRoundingMode(RoundingMode.HALF_UP);
            get.dateFormat = new SimpleDateFormat(dateFormat, locale);
            get.locale = locale;
        }
    }
}
