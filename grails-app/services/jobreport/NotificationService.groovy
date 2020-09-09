package jobreport

import grails.gorm.transactions.Transactional
import grails.gsp.PageRenderer

@Transactional
class NotificationService {

    def springSecurityService
    def grailsLinkGenerator
    PageRenderer groovyPageRenderer
    def mailService

    def sendPasswordResetLink(ChbUsers user){
        user.resetPassword = generatePassword(user.username, user.firstName, user.lastName)
        user.save()
        def link = grailsLinkGenerator.link(controller:'login', action:'changePassword', params:[upid:user.resetPassword], absolute:true)
        mailService.sendMail{
            to("${user?.emailAddress}")
            from("CHB Admin<admin@chbwindowfilm.com>")
            subject("CHB Job Report Password Reset")
            html("${groovyPageRenderer.render(template: '/login/password', model:[user: user, resourceLink:link])}")
        }
    }

    def updatePassword(ChbUsers user, String password){
        user.password = password
        user.resetPassword = null
        user.save()
    }

    Object generatePassword(String userName, String first, String last) {
        int rand = Math.random() * 1000
        def pass = (first + "2").substring(0,1).toUpperCase() + (last + "X").substring(0, 1).toUpperCase() +
                (last + "asdfg").substring(1, 4).toLowerCase() + "!#" + rand + userName + "sdakljfhla"
        pass.substring(0, 12)
    }

    def pGenerator(){
        def generator = { String alphabet, int n ->
            new Random().with {
                (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
            }
        }
        def pwd
        def validPassword = false
        String regex = "(?=.*?\\d)(?=.*?[a-zA-Z])(?=.*?[^\\w]).{12,}"
        while(!validPassword) {
            pwd = generator((('A'..'Z') + ('0'..'9') + ('a'..'z') + ('~`!@#%^&*()-_=+[{]}\\|;:\'\",<.>/?')).join(), 12)
            if(pwd.matches(regex)){
                validPassword = true
            }
        }
        return pwd
    }
}
