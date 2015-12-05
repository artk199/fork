<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-event" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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
            <g:form resource="${this.event}" method="PUT">
                <g:hiddenField name="version" value="${this.event?.version}" />
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
                        <textarea class="form-control" name="description" id="description">${event.description}</textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description" class="col-sm-4 control-label">
                        <g:message code="user.event.place" />
                    </label>
                    <div class="col-sm-8">
                        <select search-select id="place" name="place">
                            <g:each var="place" in="${places}">
                                <g:if test="${event != null && event.place != null && place.id == event.place.id}">
                                    <option selected="selected" value="${place.id}"> ${place.name} </option>
                                </g:if>
                                <g:else>
                                    <option value="${place.id}"> ${place.name} </option>
                                </g:else>
                            </g:each>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <g:message code="event.startDate" />
                    </label>
                    <div class="col-sm-8">
                        <input filter-date-and-time type="text" name="startDate" value="${event.startDate != null ? event.startDate.format('yyyy/MM/dd HH:mm') : ''}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <g:message code="event.endDate" />
                    </label>
                    <div class="col-sm-8">
                        <input filter-date-and-time type="text" name="endDate" value="${event.endDate != null ? event.endDate.format('yyyy/MM/dd HH:mm') : ''}">
                    </div>
                </div>

                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
