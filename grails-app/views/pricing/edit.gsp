<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-pricing" class="content scaffold-edit" role="main">
            <h2>
                <a href="/place/show/${pricing.place.id}">
                    ${pricing.place.name}
                </a>
                -
                ${pricing.title}
            </h2>
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

                        <a href="/pricedElement/create?pricing.id=${pricing.id}" class="save btn btn-default">
                            <span class="glyphicon glyphicon-plus"></span>
                            <g:message code="pricing.element.add.new"/>
                        </a>
                    </div>
                </fieldset>

                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    <a href="/pricing/" class="save btn btn-default">
                        <span class="glyphicon glyphicon-step-backward"></span>
                        <g:message code="pricing.showAll"/>
                    </a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
