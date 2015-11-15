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

                            <div class="col-md-8">
                                <p class="text-left">
                                    ${event.description}
                                </p>
                            </div>
                        </div>
                        Lista zapisanych uczestników wydarzenia
                        <br>
                        <g:each var="participant" in="${event.participants}">
                            ${participant.username} <br>
                        </g:each>
                        <g:link action="join" resource="${event}" class="btn btn-default btn-block" ><g:message code="event.join" /></g:link>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </div>
    </body>
</html>
