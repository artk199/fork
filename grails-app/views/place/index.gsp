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
        <g:render template="filter"/>
        <br>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>

        <div class="row">
            <div class="col-md-3 col-sm-2 hidden-xs"></div>
            <div class="col-md-6 col-sm-8 col-xs-12">
                <g:each var="place" in="${placeList}">
                    <g:render template="tile" model="[place:place]"/>
                </g:each>
            </div>
            <div class="col-md-3 col-sm-2 hidden-xs"></div>
        </div>

        <div style="height:50px"></div>

    </body>
</html>