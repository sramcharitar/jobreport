import ch.qos.logback.classic.PatternLayout
import grails.util.BuildSettings
import grails.util.Environment
import org.springframework.boot.logging.logback.ColorConverter
import org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter

import java.nio.charset.Charset

conversionRule 'clr', ColorConverter
conversionRule 'wex', WhitespaceThrowableProxyConverter

def targetDir = BuildSettings.TARGET_DIR

// See http://logback.qos.ch/manual/groovy.html for details on configuration
appender('STDOUT', ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        charset = Charset.forName('UTF-8')

        pattern =
                '%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} ' + // Date
                        '%clr(%5p) ' + // Log level
                        '%clr(---){faint} %clr([%15.15t]){faint} ' + // Thread
                        '%clr(%-40.40logger{39}){cyan} %clr(:){faint} ' + // Logger
                        '%m%n%wex' // Message
    }
}

appender("EMAIL", SMTPAppender) {
    subject = "ERROR: %logger{20} - %m"
    smtpHost = "smtp.1and1.com"
    username = "shyam@jsheet.com"
    password = "Sh!iv2an3A"
    to = "shyam@jsheet.com"
    from = "jobreport@chbapps.com"
    layout(PatternLayout) {
        pattern = "%date %-5level %logger{35} - %message %n%ex"
    }
}

if (Environment.isDevelopmentMode() && targetDir != null) {
    appender("FULL_STACKTRACE", FileAppender) {
        file = "${targetDir}/stacktrace.log"
        append = true
        encoder(PatternLayoutEncoder) {
            pattern = "%level %logger - %msg%n"
        }
    }
    logger("StackTrace", ERROR, ['FULL_STACKTRACE'], false)
    //logger 'org.springframework.security', DEBUG, ['STDOUT'], false
    //logger 'grails.plugin.springsecurity', DEBUG, ['STDOUT'], false
}

root(INFO, ['STDOUT'])
root(ERROR, ['EMAIL'])
