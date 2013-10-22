package grails.plugins.crm.contact

import grails.plugins.crm.core.TenantUtils
import grails.events.Listener

/**
 * Print service for contacts.
 */
class CrmContactPrintService {

    static transactional = false

    def grailsApplication
    def crmSecurityService
    def selectionService
    def pdfRenderingService

    @Listener(namespace = "crmContact", topic = "print")
    def print(params) {

        if(pdfRenderingService == null) {
            log.warn("PDF rendering plugin is not installed")
            return null
        }

        if (!params.tenant) {
            log.error("Parameter [tenant] missing in print event: $params")
            throw new IllegalArgumentException("Mandatory parameter [tenant] was not specified in the print event")
        }
        if (!params.sort) { params.sort = 'name' }
        if (!params.order) { params.order = 'asc' }
        params.offset = 0
        params.remove('max')

        def user = params.user
        def tempFile
        crmSecurityService.runAs(user.username) {
            TenantUtils.withTenant(params.tenant) {

                def baseURI = new URI('bean://crmContactService/list')
                def query = params.getSelectionQuery()
                def uri = params.getSelectionURI() ?: selectionService.addQuery(baseURI, query)
                def result = selectionService.select(uri, params)

                if (result) {
                    def logoPath = crmSecurityService.getTenantInfo(params.tenant)?.options?.logo
                    if (!logoPath) {
                        logoPath = grailsApplication.config.crm.theme.logo.default ?: "/images/grails_logo.png"
                    }
                    def logo = new File(grailsApplication.parentContext.servletContext.getRealPath(logoPath))

                    tempFile = File.createTempFile("crm", ".pdf")
                    tempFile.deleteOnExit()

                    // Render to a file
                    tempFile.withOutputStream { outputStream ->
                        pdfRenderingService.render(template: "print", plugin: "crm-contact-lite", controller: "crmContact",
                                model: [crmContactList: result, crmContactTotal: result.totalCount, selection: uri, user: user, logo: logo.bytes],
                                outputStream)
                        outputStream.flush()
                    }
                }
            }
        }
        return tempFile
    }
}
