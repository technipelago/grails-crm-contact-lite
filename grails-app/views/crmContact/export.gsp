<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmContact.label', default: 'CrmContact')}"/>
    <title><g:message code="crmContact.export.title" args="[entityName]"/></title>
    <r:script>
    $(document).ready(function() {
        $('h3 a').click(function(ev) {
            ev.preventDefault();
            $(this).closest('form').submit();
        });
    });
    </r:script>
</head>

<body>

<crm:header title="crmContact.export.title" subtitle="crmContact.export.subtitle" args="[entityName]"/>

<g:each in="${layouts?.sort{it.name}}" var="l">
    <g:form action="export" class="well">
        <input type="hidden" name="id" value="${id}"/>
        <input type="hidden" name="q" value="${select.encode(selection: selection)}"/>
        <g:each in="${l}" var="ly">
            <input type="hidden" name="${ly.key}" value="${ly.value}"/>
        </g:each>

        <div class="row-fluid">
            <div class="span7">
                <h3><a href="#">${l.name?.encodeAsHTML()}</a></h3>

                <p class="lead">
                    ${l.description?.encodeAsHTML()}
                </p>

                <button type="submit" class="btn btn-info">
                    <i class="icon-ok icon-white"></i>
                    <g:message code="crmContact.button.select.label" default="Select"/>
                </button>
            </div>

            <div class="span5">
                <g:if test="${l.thumbnail}">
                    <img src="${l.thumbnail}" class="pull-right"/>
                </g:if>
            </div>
        </div>

    </g:form>
</g:each>

<div class="form-actions">
    <select:link action="list" selection="${selection}" class="btn">
        <i class="icon-remove"></i>
        <g:message code="crmContact.button.back.label" default="Back"/>
    </select:link>
</div>

</body>
</html>