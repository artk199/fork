<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'place.label', default: 'atrakcji')}" />
        <asset:javascript src="jquery-2.1.3.js"/>
    </head>
    <body>
        <h3><g:message code="place.noPlace.header"/></h3>
        <p><g:message code="place.noPlace.info"/></p>
        <div class="buttons">
            <g:link controller="place" action="index" class="btn btn-default">
                <span class="glyphicon glyphicon-arrow-left"></span>
                <g:message code="place.backToList"/>
            </g:link>
        </div>
    </body>
</html>