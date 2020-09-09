package jobreport

class SecurityInterceptor {

    def springSecurityService

    SecurityInterceptor() {
        matchAll().excludes([controller:'login'])
    }

    boolean before() {
       if(!springSecurityService.isLoggedIn()){
            //redirect controller: "login", action: "index"
        }
        //ChbUsers chbUser = getAuthenticatedUser()
        //def eLevel = chbUser.getAuthorities().contains(Role.findByAuthority("ROLE_FIELD_AGENT"))
        //def isAuth = springSecurityService.isLoggedIn()
        //if (!isAuth && !actionName.equals('login')) {
        //    redirect(controller:'login', action:'index', params:params)
        //    return false
        //}
        //if(eLevel && !controllerName.equalsIgnoreCase('siteReport') ){
        //    redirect(controller:'siteReport', action:'index', params:params)
        //}
        return true
    }

    boolean after() { true }

    void afterView() {
        //redirect(controller:'login', action:'index', params:params)
    }
}
