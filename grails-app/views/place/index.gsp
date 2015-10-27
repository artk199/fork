<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:javascript src="jquery-2.1.3.js"/>
        <asset:javascript src="jquery.datetimepicker.full.min.js"/>
        <asset:stylesheet src="jquery.datetimepicker.css"/>
    </head>
    <body>
        <button type="button" data-toggle="collapse" data-target="#filterCollapse" aria-expanded="false">
            <g:message code="custom.filter" default="Filter"/>
        </button>
        <div class="collapse" id="filterCollapse">
            <g:form action="index" controller="place">
                <g:message code="placeList.created.after" default="Created after"/>
                <input id="datetimepicker1" type="text" name="timeBefore">
                <g:message code="placeList.created.before" default="before"/>
                <input id="datetimepicker2" type="text" name="timeBefore">
                <g:message code="placeList.name" default="Name"/>
                <input id="name" type="text" name="name">
                <g:message code="placeList.type" default="Type"/>
                <input id="type" type="text" name="type">
                <g:message code="placeList.town" default="Town"/>
                <input id="town" type="text" name="town">
                <g:message code="placeList.distance" default="Distance"/>
                <input id="distance" type="text" name="distance">
                <script>
                    $('#datetimepicker1').datetimepicker();
                    $('#datetimepicker2').datetimepicker();
                </script>
                <g:submitButton name="index" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </g:form>

        </div>
        <a href="#list-place" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-place" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${placeList}" />

            <div class="pagination">
                <g:paginate total="${placeCount ?: 0}" />
            </div>
        </div>
    </body>
</html>