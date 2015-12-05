<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row" role="main">
            <div  class="col-md-8 col-md-offset-2">
                <h1><g:message code="add.new.event" args="[entityName]" /></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.event}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.event}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
                </g:hasErrors>
                <g:form action="save" class="form-horizontal">
                    <fieldset class="form">

                        <div class="form-group">
                            <label for="title" class="col-sm-4 control-label">
                    <g:message code="event.title" />
                    </label>
                    <div class="col-sm-8">
                        <input class="form-control" name="title" id="title" value="${event.title}"/>
                    </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">
                            <g:message code="place.description" />
                        </label>
                        <div class="col-sm-8">
                            <textarea class="form-control" name="description" id="description" value="${event.description}"> </textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-4 control-label">
                            <g:message code="user.event.place" />
                        </label>
                        <div class="col-sm-8">
                            <select search-select id="place" name="place">
                                <g:each var="place" in="${places}">
                                    <option value="${place.id}"> ${place.name} </option>
                                </g:each>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-4 control-label">
                            <g:message code="event.startDate" />
                        </label>
                        <div class="col-sm-8">
                            <input filter-date-and-time type="text" name="startDate" value="${event.startDate}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-4 control-label">
                            <g:message code="event.endDate" />
                        </label>
                        <div class="col-sm-8">
                            <input filter-date-and-time type="text" name="endDate" value="${event.endDate}">
                        </div>
                    </div>


                    <fieldset>
                        <g:submitButton name="create" class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Dodaj!')}" />
                    </fieldset>
                </g:form>
            </div>
        </div>
    </body>
</html>
