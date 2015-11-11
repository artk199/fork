<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:javascript src="jquery-2.1.3.js"/>
    </head>
    <body>
    <br/>
        <div class="row" style="-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none; user-select: none;">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-4 fork-filter-bar">
                        <g:render template="filter"/>
                    </div>
                    <div class="col-lg-9 col-md-8 col-sm-8 col-xs-8">
                        <div class="pull-left">
                            <g:each var="event" in="${eventList}">
                                <g:render template="tile" model="[event:event]"/>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div style="height:50px"></div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2 ">
                <g:link action="create" class="btn btn-default btn-block" ><g:message code="event.create" /></g:link>
            </div>
            <div style="height:50px"></div>
        </div>
    </body>
</html>