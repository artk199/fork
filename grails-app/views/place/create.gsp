<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'placeSingle.label', default: 'Place')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <sec:ifLoggedIn>
        <div class="row" role="main">
            <div  class="col-md-8 col-md-offset-2">
                <h1><g:message code="add.new.place" args="[entityName]" /></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.place}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.place}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form action="save" class="form-horizontal">
                    <fieldset class="form">
                        <div class="form-group">
                            <label for="name" class="col-sm-4 control-label">
                                <g:message code="place.name" />
                            </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="name" id="name" value="${place.name}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">
                            <g:message code="place.description" />
                        </label>
                        <div class="col-sm-8">
                            <textarea class="form-control" name="description" id="description" value="${place.description}"> </textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="town" class="col-sm-4 control-label">
                            <g:message code="place.town" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="town" id="town" value="${place.town}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address" class="col-sm-4 control-label">
                            <g:message code="place.address" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="address" id="address" value="${place.address}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="col-sm-4 control-label">
                            <g:message code="place.email" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="email" id="email" value="${place.email}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="col-sm-4 control-label">
                            <g:message code="place.phone" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="phone" id="phone" value="${place.phone}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="website" class="col-sm-4 control-label">
                            <g:message code="place.website" />
                        </label>
                        <div class="col-sm-8">
                            <input class="form-control" name="website" id="website" value="${place.website}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="types" class="col-sm-4 control-label">
                            <g:message code="pricing.place" />
                        </label>
                        <div class="col-sm-8">
                            <g:select name="types" id="types" from="${pl.fork.place.PlaceType.list()}"
                                      optionValue="tag" class="form-control"
                                      optionKey="id" multiple="multiple"
                            />
                        </div>
                    </div>

                    <fieldset>
                        <g:submitButton name="create" class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Dodaj!')}" />
                    </fieldset>
                </g:form>
            </div>
        </div>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <g:render template="../noPermissions"/>
    </sec:ifNotLoggedIn>
    </body>
</html>
