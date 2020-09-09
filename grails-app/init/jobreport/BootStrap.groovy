package jobreport

class BootStrap {

    def init = { servletContext ->
        iniitializeDB()
        //addJobInfo()
    }

    def destroy = {
    }

    def iniitializeDB() {
        new DBLoader().loadAll()

    }

    def addJobInfo(){
        Date today = new Date()
        List jobInfo = []
        for (def i=0; i<10; i++) {
            jobInfo.add(
            [owner         : ChbUsers.findByEmailAddress("mferrizz@chbwindowfilm.com"),
             client        : [name           : i + ' ABC Corp.',
                              address        : [street: '123 Main St.', city: 'New York', state: 'NY', zipcode: '10011'],
                              contact        : [company: '', firstName: 'Ben', lastName: 'Franklin', phone: '5555555555', email: 'ben_'+i+'@test123.com']],
             workOrderNumber: 'A12345_' + i,
             jobName        : 'Test Job ' + i,
             salesRep       : ChbUsers.findByEmailAddress("dvenet@chbwindowfilm.com"),
             jobLocation    : [street: '123 Main St.', city: 'New York', state: 'NY', zipcode: '10011'],
             jobDescription : i + ' Test job information',

             workDetails: [[toBeRemoved: false, workTypes: [id: 1], quantity: 10, width: 48, length: 4, _wetGlaze: '', _gullWing: '', _frameGuard: ''],
                           [toBeRemoved: false, workTypes: [id: 1], quantity: 8, width: 36, length: 4, _wetGlaze: '', _gullWing: '', _frameGuard: ''],
                           [toBeRemoved: false, workTypes: [id: 1], quantity: 6, width: 24, length: 4, _wetGlaze: '', _gullWing: '', _frameGuard: ''],
                           [toBeRemoved: false, workTypes: [id: 1], quantity: 4, width: 12, length: 4, _wetGlaze: '', _gullWing: '', _frameGuard: ''],
                           [toBeRemoved: false, workTypes: [id: 1], quantity: 2, width: 24, length: 5, _wetGlaze: '', _gullWing: '', _frameGuard: '']],

             productInfo: [[toBeRemoved: false, manufacturer: 'Madico', description: 'Frosted Crystal', productDeliveryMethod: [id: 5], deliveryDate: today.plus(i),
                              rolls   : [[toBeRemoved: false, rollNumber: '', quantity: 3, width: 48, length: 50, description: i + ' hopefully enough film']]]],
             rateCategory: WageTypeEnum.STANDARD_RATE.name(),
             rateClass: StandardRateTypeEnum.REGULAR.name(),
             rider         : [measuredBy: 'Dave Farrugia', measurementDate: today.plus(i), installationDate: today.plus(i), specialInstructions: i + ' Test instruction for iteration']]
            )
        }

        jobInfo.eachWithIndex {info, idx ->
            Client client = Client.findByName(info.client.name)
            if (!client){
                JobReport jobReport = new JobReport(info)
                if (!jobReport.hasErrors() && jobReport.save(flush:true)){
                    println "job report created " + (idx+1)
                }
                else{
                    println jobReport.errors.toString()
                }
            }
        }
    }
}
