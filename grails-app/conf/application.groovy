
// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'pl.fork.auth.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'pl.fork.auth.UserRole'
grails.plugin.springsecurity.authority.className = 'pl.fork.auth.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
		'/place/getPlace':	  ['isAuthenticated()'],
		'/**':                ['permitAll']
]
