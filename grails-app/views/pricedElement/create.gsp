<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="pricing.elements.header"/> ${pricedElement.pricing?.id ? pricedElement.pricing.title : ""}</title>
    </head>
    <body>
        <div id="create-pricedElement" class="content scaffold-create" role="main">
            <h1><g:message code="pricing.elements.header"/> ${pricedElement.pricing?.id ? pricedElement.pricing.title : ""}</h1>
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
            <g:form action="save" class="form-horizontal">
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <p><g:message code="pricing.element.info"/></p>

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

                            <g:if test="${!pricedElement.pricing?.id}">
                                <div class="form-group">
                                    <label for="pricing" class="col-sm-4 control-label">
                                        <g:message code="pricing.element.menu" />
                                    </label>
                                    <div class="col-sm-8">
                                        <g:select name="pricing" id="pricing" from="${pl.fork.place.other.Pricing.list()}"
                                                  optionValue="title" class="form-control" value="${this.params?.pricing?.id?:1}"
                                                  optionKey="id"
                                        />
                                    </div>
                                </div>
                            </g:if>
                            <g:else>
                                <g:hiddenField name = "pricing" value="${pricedElement.pricing?.id}"/>
                            </g:else>
                        </fieldset>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    <g:if test="${pricedElement.pricing?.id}">
                        <g:link controller="pricing" action="show" id="${pricedElement.pricing?.id}" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.elements.backToPricing"/>
                        </g:link>
                        <g:link controller="place" action="show" id="${pricedElement.pricing.place?.id}" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.backToPlace"/>
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="pricedElement" action="index" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.element.showAll"/>
                        </g:link>
                    </g:else>
              </fieldset>
            </g:form>
        </div>
    </body>
</html>
