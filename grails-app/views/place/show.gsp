<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<div>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div id="show-place" class="row content scaffold-show" role="main">
        <div class="center">
            <div class="row">
                <div class=" col-sm-12 col-xs-12 col-lg-12 col-md-12">
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
        <div class="blue-section">
            <div class="bar center blue-section">
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Lokalizacja</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Kontakt</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Cennik</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Organizuj wycieczkę</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Zdjęcia użytkowników</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="bar-section">
                    <g:img  file="logo.png"/>
                    <span>Coś jeszcze</span>
                    <a href="#">&nbsp;</a>
                </div>
                <div class="row">
                    <div class=" col-sm-12 col-xs-12 col-lg-12 col-md-12">
                        <div class="localisation-info">
                            <g:img  file="logo.png"/>
                            <span><strong> Miasto: </strong> ${this.place.town}</span>
                        </div>
                        <div class="localisation-info">
                            <g:img  file="logo.png"/>
                            <span><strong> Adres: </strong> ${this.place.address}</span>
                        </div>
                        <div class="map">
                            <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCQcP1mIycA9POYLolLblZeqc3dLG9iVjQ&q=${this.place.town}+${this.place.address}"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="center">
            <div class="row">
                <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                    <h1>Opinie użytkowników</h1>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%--
<!DOCTYPE html>
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