<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>${this.user.username}</title>
</head>
<body>
    <sec:ifLoggedIn>
        <permission:hasAccess displayNoPermInfo="true">
            <div id="edit-user" class="content scaffold-edit" role="main">

                <h2>${this.user.username}</h2>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.user}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.user}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <g:form resource="${this.user}" method="PUT" class="form-horizontal">
                            <g:hiddenField name="version" value="${this.user?.version}" />
                            <fieldset class="form">
                                <g:render template="adminEdits/mainFields" model="[user:user]"/>
                                <hr/>
                                <g:render template="adminEdits/selectionPart" model="[user:user]"/>
                            </fieldset>
                            <fieldset class="buttons">
                                <input class="btn btn-default" class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                <g:link class='btn btn-default' controller="admin" action="index">
                                    <span class="glyphicon glyphicon-arrow-left"></span>
                                    <g:message code="admin.backToPanel"/>
                                </g:link>
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </permission:hasAccess>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <g:render template="../noPermissions"/>
    </sec:ifNotLoggedIn>
</body>
</html>