<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:javascript src="jquery-2.1.3.js"/>
    </head>
    <body>
    <br/>
        <div class="row" style="-webkit-touch-callout: none;-webkit-user-select: none;-khtml-user-select: none;-moz-user-select: none;-ms-user-select: none; user-select: none;">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-4">
                        <g:render template="filter"/>
                    </div>
                    <div class="col-lg-9 col-md-8 col-sm-8 col-xs-8">
                        <div class="pull-left">
                            <infinite-list link="/place/all" amount="1">
                                <g:render template="tile"/>
                            </infinite-list>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>

        <div style="height:50px"></div>
        <div style="height:50px"></div>


    </body>
</html>