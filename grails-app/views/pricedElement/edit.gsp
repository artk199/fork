<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>${pricedElement.pricing.title} - ${pricedElement.name}</title>
    </head>
    <body>
        <sec:ifLoggedIn>
            <permission:hasAccess
                    isOwner="${((g.currentUserID()?.toInteger()) == pricedElement.pricing.place.owner?.id)}"
                    displayNoPermInfo="true"
            >
                <div id="edit-pricedElement" class="content scaffold-edit" role="main">
                    <h2>
                        <a href="/place/show/${pricedElement.pricing.place.id}">
                            ${pricedElement.pricing.place.name}
                        </a>
                        -
                        <a href="/pricing/show/${pricedElement.pricing.id}">
                            ${pricedElement.pricing.title}
                        </a>
                        -
                        ${pricedElement.name}
                    </h2>
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
                        <div class="text-left row">
                            <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                            <div class="col-md-8 col-sm-8 col-xs-11 text-left">
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
                                            <textarea class="form-control" name="description" id="description" value="${pricedElement.description}">${pricedElement.description}</textarea>
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
                                    <permission:hasAccess>
                                        <div class="form-group">
                                            <label for="pricing" class="col-sm-4 control-label">
                                                <g:message code="pricing.element.menu" />
                                            </label>
                                            <div class="col-sm-8">
                                                <g:select name="pricing" id="pricing" from="${pl.fork.place.other.Pricing.list()}"
                                                          optionValue="title" class="form-control" value="${pricedElement.pricing.id}"
                                                          optionKey="id"
                                                />
                                            </div>
                                        </div>
                                    </permission:hasAccess>
                                </fieldset>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                        </div>
                        <fieldset class="buttons">
                            <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                            <g:link controller="place" action="show" id="${pricedElement.pricing.place?.id}" class="save btn btn-default">
                                <span class="glyphicon glyphicon-step-backward"></span>
                                <g:message code="pricing.backToPlace"/>
                            </g:link>
                            <g:link controller="pricing" action="show" id="${pricedElement.pricing?.id}" class="save btn btn-default">
                                <span class="glyphicon glyphicon-step-backward"></span>
                                <g:message code="pricing.elements.backToPricing"/>
                            </g:link>
                        </fieldset>
                    </g:form>
                </div>
            </permission:hasAccess>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <g:render template="../noPermissions"/>
        </sec:ifNotLoggedIn>
    </body>
</html>
