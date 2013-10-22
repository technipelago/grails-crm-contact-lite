<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmContact.label', default: 'Contact')}"/>
    <title><g:message code="crmContact.create.title" args="[entityName]"/></title>
</head>

<body>

<crm:header title="crmContact.create.title" args="[entityName]"/>

<h2>Vilken typ av kontakt vill du registrera?</h2>

<div class="row-fluid">
    <div class="span6">
        <dl>
            <dt>Företag</dt>
            <dd>Företag och organisationer kan ha kontaktpersoner knutna till sig, men även enskilda firmor bör registreras som företag.
            I denna bild kan du inte registrera uppgifter om någon person, endast företagsuppgifter.</dd>
            <dt>Kontaktperson</dt>
            <dd>En kontaktperson är knuten till ett företag/organisation. I denna bild får du möjlighet att registrera både företaget om det inte redan är registrerat, och en kontaktperson.</dd>
            <dt>Privatperson</dt>
            <dd>En privatperson är en individ som inte har någon koppling till ett företag. I denna bild kan du inte registrera några företagsuppgifter, endast uppgifter om en person.</dd>
        </dl>
    </div>

    <div class="span6">
    </div>
</div>

<g:form>

    <div class="form-actions">
        <crm:button type="link" action="company" icon="icon-home icon-white" visual="success"
                    label="crmContact.button.create.company.label" params="${linkParams}"/>
        <crm:button type="link" action="contact" icon="icon-user icon-white" visual="success"
                    label="crmContact.button.create.contact.label" params="${linkParams}"/>
        <crm:button type="link" action="person" icon="icon-user icon-white" visual="success"
                    label="crmContact.button.create.person.label" params="${linkParams}"/>
    </div>

</g:form>

</body>
</html>
