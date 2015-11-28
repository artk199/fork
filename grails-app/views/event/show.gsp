<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="show-event">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                        <h1>${event.title}</h1>
                        <div class="row">
                            <div class="col-md-4">
                                image
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div class="row page-section blue-section">
            <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                <g:render template="tabs" model="[event:event]"/>
            </div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="comments" model="[event:event, comment:comment, comments:comments]"/>
            </div>
        </div>
    </div>
    </body>
</html>
