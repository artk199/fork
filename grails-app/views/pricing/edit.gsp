<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-pricing" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-pricing" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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
            <g:form resource="${this.pricing}" method="PUT">
                <g:hiddenField name="version" value="${this.pricing?.version}" />
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
                            <textarea class="form-control" name="description"
                                      id="description" value="${pricing.description}">
                                ${pricing.description}
                            </textarea>
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

                <h2><g:message code="pricing.elements.header"/></h2>
                <fieldset class="form-group" id="pricing-elements">
                    <!-- FIELDS ON MENU ELEMENT!-->


                    <div class="buttons">
                        <a href="/pricedElement/create?pricing.id=${pricing.id}" class="save btn btn-default"><g:message code="pricing.element.add.new"/></a>
                    </div>
                </fieldset>

                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
