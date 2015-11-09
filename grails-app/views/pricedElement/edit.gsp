<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricedElement.label', default: 'PricedElement')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-pricedElement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-pricedElement" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.pricedElement}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.pricedElement}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.pricedElement}" method="PUT">
                <g:hiddenField name="version" value="${this.pricedElement?.version}" />
                <fieldset class="form">
                    <!-- FIELDS ON MENU !-->
                    <div class="form-group">
                        <label for="name" class="col-sm-4 control-label">
                            <g:message code="pricing.element.name" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="name" id="name" value="${pricedElement.name}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">
                            <g:message code="pricing.element.description" />
                        </label>
                        <div class="col-sm-8">
                            <textarea class="form-control" name="description" id="description" value="${pricedElement.description}">
                                ${pricedElement.description}
                            </textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="price" class="col-sm-4 control-label">
                            <g:message code="pricing.element.price" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="price" id="price" value="${pricedElement.price}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pricing" class="col-sm-4 control-label">
                            <g:message code="pricing.element.menu" />
                        </label>
                        <div class="col-sm-8">
                            <g:select name="pricing" id="pricing" from="${pl.fork.place.other.Pricing.list()}"
                                      optionValue="title" class="form-control" value="${pricedElement.pricing}"
                                      optionKey="id"
                            />
                        </div>
                    </div>
                </fieldset>
                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
