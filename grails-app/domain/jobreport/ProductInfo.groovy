package jobreport

class ProductInfo {
    Date dateCreated
    Date lastUpdated
    String manufacturer
    String description
    ProductDeliveryMethod productDeliveryMethod
    Date deliveryDate
    List<Rolls> rolls
    boolean toBeRemoved = false

    static transients = ['toBeRemoved']
    //static belongsTo = [jobReport:JobReport]
    static hasMany = [rolls:Rolls]
    static mapping = {
        rolls index: 'productinfo_roll_idx'
    }
    static constraints = {
        //jobReport nullable: true
        manufacturer nullable: false, blank: false
        description type:'text', nullable: false, blank: false
        productDeliveryMethod nullable: false
        deliveryDate blank:true
        rolls cascade:'all-delete-orphan'
        toBeRemoved bindable: true
    }

    def getRollsQty(){
        return rolls.quantity.sum()
    }
}
