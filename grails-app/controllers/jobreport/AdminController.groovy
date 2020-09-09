package jobreport

import grails.plugin.springsecurity.annotation.Secured

@Secured("hasRole('ROLE_ADMIN')")
class AdminController {
    def nav

    AdminController(){
        this.nav = "admin"
    }

    def index() {
        [nav:getNav()]
    }

    private def getNav(){
        return this.nav
    }
}
