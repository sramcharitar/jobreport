import jobreport.ChbUsersPasswordEncoderListener
import jobreport.JobReportSecurityEventListener

// Place your Spring DSL code here
beans = {
    chbUsersPasswordEncoderListener(ChbUsersPasswordEncoderListener)
    jobReportSecurityEventListener(JobReportSecurityEventListener)
}
