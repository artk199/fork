<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title><g:message code="pricing.header"/> ${pricing.place?.id ? pricing.place.name : ""}</title>
    </head>
    <body>
        <div id="create-pricing" class="content scaffold-create" role="main">
            <h2><g:message code="pricing.header"/> ${pricing.place?.id ? pricing.place.name : ""}</h2>
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
                        <p><g:message code="pricing.info"/></p>

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
                            <g:if test="${!pricing.place?.id}">
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
                            </g:if>
                            <g:else>
                                <g:hiddenField name = "place" value="${pricing.place.id}"/>
                            </g:else>
                        </fieldset>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>
                <fieldset class="buttons">
                    <g:submitButton name="create"  class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    <g:if test="${pricing.place?.id}">
                        <g:link controller="place" action="show" id="${pricing.place?.id}" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.backToPlace"/>
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="pricing" action="index" class="save btn btn-default">
                            <span class="glyphicon glyphicon-step-backward"></span>
                            <g:message code="pricing.showAll"/>
                        </g:link>
                    </g:else>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
