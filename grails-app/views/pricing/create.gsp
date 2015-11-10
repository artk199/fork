<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-pricing" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-pricing" class="content scaffold-create" role="main">
            <h2><g:message code="pricing.header" args="[entityName]" /></h2>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.pricing}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.pricing}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <!-- FIELDS ON MENU !-->
                    <div class="form-group">
                        <label for="title" class="col-sm-4 control-label">
                            <g:message code="pricing.title" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="title" id="title" value="${pricing.title}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">
                            <g:message code="pricing.description" />
                        </label>
                        <div class="col-sm-8">
                            <textarea class="form-control" name="description" id="description" value="${pricing.description}"> </textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="place" class="col-sm-4 control-label">
                            <g:message code="pricing.place" />
                        </label>
                        <div class="col-sm-8">
                            <g:select name="place" id="place" from="${pl.fork.place.Place.list()}"
                                optionValue="name" class="form-control" value="${pricing.place}"
                                optionKey="id"
                            />
                        </div>
                    </div>
                </fieldset>


                <fieldset class="buttons">
                    <g:submitButton name="create"  class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>

                <h2><g:message code="pricing.elements.header"/></h2>
                <p>To jeszcze nie działa. Tutaj będzie dodawanie elementów przy pomocy javascriptu - od
                razu przy dodawaniu menu, dla wygody.</p>
                <fieldset class="form-group" id="pricing-elements">
                    <!-- FIELDS ON MENU ELEMENT!-->


                    <div class="buttons">
                        <a href="/pricedElement/create" class="save btn btn-default"><g:message code="pricing.element.add.new"/></a>
                    </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
