hibernate {
    format_sql = true
    use_sql_comments = true
    cache.use_second_level_cache = false
    cache.use_query_cache = false
    cache.region.factory_class='org.hibernate.cache.ehcache.EhCacheRegionFactory'
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.SingletonEhCacheRegionFactory'
    singleSession = true
    c3p0 {
        min_size=20
        max_size=200
        timeout=1800
        max_statements=300
    }
}

// environment specific settings
environments {
    development {
        println "setting environment for development"
        //grails.plugin.greenmail.disabled=true
        grails.mail.port = com.icegreen.greenmail.util.ServerSetupTest.SMTP.port

        // Gmail
        //grails.mail.port = 587
        //grails.mail.host = 'smtp.gmail.com'
        //grails.mail.username = 'sramcharitar@gmail.com'
        //grails.mail.password = '12NorLnRonk!17'
        //grails.mail.from = 'sramcharitar@gmail.com'
        //grails.mail.props = ["mail.smtp.starttls.enable":"true", "mail.smtp.port":"587"]
        //grails.mail.smtp['auth'] = "false"
        //grails.mail.smtp['starttls']['enable'] = true

        // 1and1
        grails.mail.host = "smtp.1and1.com"
        //grails.mail.port = 587
        grails.mail.username = "shivana@jsheet.com"
        grails.mail.password = "\${iisc99!!SC}\$"
        grails.mail.props = ["mail.smtp.auth":"true", "mail.smtp.starttls.enable":"true"]
        grails.mail.debug=true

        grails.serverUrl = "http://localhost:8080"
    }
    production {
        println "setting environment for production"
        grails.plugin.greenmail.disabled=true
        //grails.mail.port = com.icegreen.greenmail.util.ServerSetupTest.SMTP.port

        // 1and1
        grails.mail.host = "smtp.1and1.com"
        grails.mail.port = 587
        grails.mail.username = "shivana@jsheet.com"
        grails.mail.password = "\${iisc99!!SC}\$"
        grails.mail.props = ["mail.smtp.auth":"true", "mail.smtp.starttls.enable":"true"]
        grails.mail.debug=true
    }
}
