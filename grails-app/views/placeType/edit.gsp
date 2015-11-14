<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'placeType.label', default: 'PlaceType')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-placeType" class="content scaffold-edit" role="main">
            <h2>${placeType.tag}</h2>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.placeType}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.placeType}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.placeType}" method="PUT" class="form-horizontal">
                <g:hiddenField name="version" value="${this.placeType?.version}" />
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <fieldset class="form">
                            <div class="form-group">
                                <label for="title" class="col-sm-4 control-label">
                                    <g:message code="placeType.tag" />
                                </label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="tag" id="tag" value="${placeType.tag}"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="description" class="col-sm-4 control-label">
                                    <g:message code="placeType.description" />
                                </label>
                                <div class="col-sm-8">
                                    <textarea class="form-control" name="description"
                                              id="description" value="${placeType.description}">${placeType.description}</textarea>
                                </div>
                            </div>

                            <%--
                            <div class="form-group">
                                <label for="places" class="col-sm-4 control-label">
                                    <g:message code="placeType.show.places" />
                                </label>
                                <div class="col-sm-8">
                                    <g:select name="places" id="places" from="${pl.fork.place.Place.list()}"
                                              optionValue="name" class="form-control" value="${placeType.places}"
                                              optionKey="id" multiple="mutliple"
                                    />
                                </div>
                            </div>
                            --%>

                        </fieldset>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>

                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    <a href="/placeType/" class="save btn btn-default">
                        <span class="glyphicon glyphicon-step-backward"></span>
                        <g:message code="placeType.show.all"/>
                    </a>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
