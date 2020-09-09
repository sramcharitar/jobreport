package jobreport

class InventoryDetails {
    Date dateCreated
    Date lastUpdated
    String rollNumber
    BigDecimal usedProduct
    BigDecimal remainingProduct
    ProductInfo productInfo
    InventoryStatusEnum inventoryStatusEnum

    static belongsTo = [siteReport:SiteReport]
    static constraints = {
        rollNumber nullable: true
        usedProduct nullable: true
        remainingProduct nullable: true
        productInfo nullable: true
        inventoryStatusEnum nullable: true
    }
}
