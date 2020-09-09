

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'jobreport.ChbUsers'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'jobreport.ChbUsersRole'
grails.plugin.springsecurity.authority.className = 'jobreport.Role'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.useSecurityEventListener = true
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
    [pattern: '/greenmail',      access: ['permitAll']],
    [pattern: '/jobReport',      access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

grails.plugin.springsecurity.interceptUrlMap = [
        '/':                ['permitAll'],
        '/index':           ['permitAll'],
        '/index.gsp':       ['permitAll'],
        '/assets/**':       ['permitAll'],
        '/**/js/**':        ['permitAll'],
        '/**/css/**':       ['permitAll'],
        '/**/images/**':    ['permitAll'],
        '/**/favicon.ico':  ['permitAll'],
        '/login/**':        ['permitAll'],
        '/logout/**':       ['permitAll'],
        '/greenmail/**':    ['permitAll']
]

