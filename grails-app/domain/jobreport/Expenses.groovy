package jobreport

class Expenses {
    Date dateCreated
    Date lastUpdated
    ChbUsers worker
    ExpenseItemsEnum expenseItemsEnum
    BigDecimal amount
    PaymentMethodEnum paymentMethodEnum
    String note
    boolean toBeRemoved = false

    static transients = ['toBeRemoved']
    static belongsTo = [siteReport:SiteReport]
    static mapping = {
        note type: "text"
    }
    static constraints = {
        worker nullable: false, blank: false
        expenseItemsEnum nullable: false, blank: false
        amount nullable: false, blank: false
        paymentMethodEnum nullable: false, blank: false
        note nullable: true, blank: true
        toBeRemoved bindable: true
    }

}
