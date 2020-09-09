package jobreport

class WorkDetails {
    Date dateCreated
    Date lastUpdated
    Date dateCompleted
    ChbUsers worker
    WorkTypes workTypes
    Integer quantity
    Integer qtyCompleted
    Integer width
    Integer widthCompleted
    Integer length
    Integer lengthCompleted
    boolean wetGlaze
    boolean gullWing
    boolean frameGuard
    boolean highScaffold
    boolean arpal
    String notes
    boolean toBeRemoved = false

    static transients = ['toBeRemoved']
    static belongsTo = [jobReport:JobReport]
    static constraints = {
        dateCompleted nullable: true, blank: true
        worker nullable: true, blank:true
        toBeRemoved bindable: true
        jobReport nullable: true
        workTypes nullable: false, blank: false
        quantity blank: false
        qtyCompleted blank: true, nullable: true
        width blank: false
        widthCompleted blank:true, nullable: true
        length blank: false
        lengthCompleted blank:true, nullable: true
        wetGlaze nullable: true
        gullWing nullable: true
        frameGuard nullable: true
        highScaffold nullable: true
        arpal nullable: true
        notes type: 'text', blank: true, nullable: true
    }

    BigDecimal linearFeet(){
        def widthInFt = width/12
        Math.max(widthInFt, length.toBigDecimal())
    }

    BigDecimal totalLinearFt(){
        linearFeet()?.multiply(quantity)
    }

    Integer qtyCompleted(){
        WorkDetailsCompleted.findAllByWorkDetails(this)?.qtyCompleted?.sum() ?:0
    }

    BigDecimal totalCompletedLnFt(){
        linearFeet()?.multiply(qtyCompleted())
    }
}
