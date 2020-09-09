package jobreport

class Documents {
    Date dateCreated
    Date lastUpdated
    String name
    String contentType
    byte[] doc

    static belongsTo = [jobReport:JobReport, siteReport:SiteReport]
    static mapping = {
        dateCreated index: 'date_created_index'
        doc sqlType: 'longblob'
        jobReport index: 'jobReport_idx'
        siteReport index: 'siteReport_idx'
    }

    static constraints = {
        name blank: false
        contentType blank: false
        doc nullable: false
        jobReport nullable: true
        siteReport nullable: true
    }

    String toString(){
        def dot = name.lastIndexOf(".")
        def sep = name.lastIndexOf("\\")
        return name.substring(sep + 1, dot)
    }

    String filename(){
        def sep = name.lastIndexOf("\\")
        return name.substring(sep + 1)
    }

    String fileExtension(){
        def dot = name.lastIndexOf(".")
        return name.substring(dot + 1)
    }
}