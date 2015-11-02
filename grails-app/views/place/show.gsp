<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
    <div id="show-place">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                        <h1>${this.place.town} - ${this.place.name}</h1>
                        <div class="row">
                            <div class="col-md-4">
                                image
                            </div>

                            <div class="col-md-8">
                                <p class="desc">
                                    ${this.place.description}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <g:render template="scores" model="[place:place, score:score]"/>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div class="row blue-section">
            <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                <g:render template="tabs" model="[place:place]"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="scores" model="[place:place]"/>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </div>
</body>
</html>
<%--
<!DOCTYPE html>
 col-sm-12 col-xs-12 col-lg-12 col-md-12
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-place" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-place" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:display bean="place" />
            <g:form resource="${this.place}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.place}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
--%>