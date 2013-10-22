<%@ page import="grails.plugins.crm.contact.CrmContact" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmContact.label', default: 'CrmContact')}"/>
    <title><g:message code="crmContact.list.title" args="[entityName]"/></title>
</head>

<body>

<crm:header title="crmContact.list.title" subtitle="crmContact.totalCount.label"
            args="[entityName, crmContactTotal]"/>

<table class="table table-striped">
    <thead>
    <tr>

        <crm:sortableColumn property="name"
                            title="${message(code: 'crmContact.name.label', default: 'Name')}"/>

        <th><g:message code="crmContact.address.label" default="Address"/></th>

        <th><g:message code="crmContact.telephone.label" default="Telephone"/></th>

        <th><g:message code="crmContact.email.label" default="Email"/></th>

        <crm:sortableColumn property="title"
                            title="${message(code: 'crmContact.title.label', default: 'Title')}"/>
        <crm:sortableColumn property="number"
                            title="${message(code: 'crmContact.number.label', default: '#')}"/>
    </tr>
    </thead>
    <tbody>
    <g:each in="${crmContactList}" status="i" var="crmContact">
        <g:set var="parentContact" value="${crmContact.parent}"/>
        <g:set var="preferredPhone" value="${crmContact.preferredPhone}"/>
        <tr>
            <td>
                <select:link action="show" id="${crmContact.id}" selection="${selection}">
                    ${fieldValue(bean: crmContact, field: "name")}<g:if
                        test="${parentContact}">, ${parentContact.encodeAsHTML()}</g:if>
                </select:link>
            </td>

            <td>${fieldValue(bean: crmContact, field: "address")}</td>

            <td>
                <g:if test="${preferredPhone}">
                    <a href="tel:${crmContact.telephone}">${preferredPhone.encodeAsHTML()}</a>
                </g:if>
            </td>

            <td>
                <g:if test="${crmContact.email}">
                    <a href="mailto:${crmContact.email}"><g:decorate include="abbreviate" max="30"><g:fieldValue
                        bean="${crmContact}" field="email"/></g:decorate>
                </g:if>
            </td>

            <td>${fieldValue(bean: crmContact, field: "title")}</td>

            <td>${fieldValue(bean: crmContact, field: "number")}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<crm:paginate total="${crmContactTotal}"/>

<g:form>

    <div class="form-actions btn-toolbar">
        <input type="hidden" name="offset" value="${params.offset ?: ''}"/>
        <input type="hidden" name="max" value="${params.max ?: ''}"/>
        <input type="hidden" name="sort" value="${params.sort ?: ''}"/>
        <input type="hidden" name="order" value="${params.order ?: ''}"/>

        <g:each in="${selection.selectionMap}" var="entry">
            <input type="hidden" name="${entry.key}" value="${entry.value}"/>
        </g:each>

        <crm:selectionMenu visual="primary"/>

        <g:if test="${crmContactTotal}">
            <div class="btn-group">
                <button class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                    <i class="icon-print icon-white"></i>
                    <g:message code="crmContact.button.print.label" default="Print"/>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <crm:hasPermission permission="crmContact:print">
                        <li>
                            <select:link action="print" accesskey="p" target="pdf" selection="${selection}">
                                <g:message code="crmContact.button.print.pdf.label" default="Print to PDF"/>
                            </select:link>
                        </li>
                    </crm:hasPermission>
                    <crm:hasPermission permission="crmContact:export">
                        <li>
                            <select:link action="export" accesskey="e" selection="${selection}">
                                <g:message code="crmContact.button.export.calc.label" default="Print to spreadsheet"/>
                            </select:link>
                        </li>
                    </crm:hasPermission>
                </ul>
            </div>
        </g:if>

        <crm:hasPermission permission="crmContact:create">
            <crm:button type="link" group="true" action="create" visual="success"
                        icon="icon-file icon-white"
                        label="crmContact.button.create.label" permission="crmContact:create">
                <button class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li>
                        <g:link controller="crmContact" action="company"><g:message
                                code="crmContact.button.create.company.label" default="Company"/></g:link>
                    </li>
                    <li>
                        <g:link controller="crmContact" action="contact"><g:message
                                code="crmContact.button.create.contact.label" default="Contact"/></g:link>
                    </li>
                    <li>
                        <g:link controller="crmContact" action="person"><g:message
                                code="crmContact.button.create.person.label" default="Individual"/></g:link>
                    </li>
                </ul>
            </crm:button>
        </crm:hasPermission>

    </div>
</g:form>

</body>
</html>
