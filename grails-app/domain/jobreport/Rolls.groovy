package jobreport

class Rolls {
    Date dateCreated
    Date lastUpdated
    String rollNumber
    Integer quantity
    Integer width
    Integer length
    String description
    boolean toBeRemoved = false

    static transients = ['toBeRemoved']
    static belongsTo = [productInfo:ProductInfo]
    static constraints = {
        toBeRemoved bindable: true
        rollNumber blank:true, nullable:true
        quantity blank:false, nullable: false
        width blank:false, nullable: false
        length blank:false, nullable: false
        description type:'text', blank:true, nullable: true
    }
}
