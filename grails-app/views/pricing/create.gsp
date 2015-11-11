<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
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
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
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
                                    <textarea class="form-control" name="description" id="description" value="${pricing.description}"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="place" class="col-sm-4 control-label">
                                    <g:message code="pricing.place" />
                                </label>
                                <div class="col-sm-8">
                                    <g:select name="place" id="place" from="${pl.fork.place.Place.list()}"
                                        optionValue="name" class="form-control" value="${this.params?.place?.id?:1}"
                                        optionKey="id"
                                    />
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>
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
                        <a href="/pricing/" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.showAll"/>
                        </a>
                    </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
