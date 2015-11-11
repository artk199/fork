<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>



            <div class="row" role="main">
                    <div class="col-md-8 col-md-offset-2">
                        <h1><g:message code="default.registration" args="[entityName]" /></h1>
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>

                        <g:hasErrors bean="${this.user}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.user}" var="error">
                                    <div class="alert alert-danger" role="alert"><g:message error="${error}"/></div>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>

                        <g:form action="save" class="form-horizontal">
                            <fieldset class="form">

                                <div class="form-group">
                                    <label for="username" class="col-sm-4 control-label">
                                        <g:message code="user.username" />
                                    </label>
                                    <div class="col-sm-8">
                                        <g:textField class="form-control" name="username" value="${user.username}" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="password" class="col-sm-4 control-label">
                                        <g:message code="user.password" />
                                    </label>
                                    <div class="col-sm-8">
                                        <g:passwordField class="form-control" name="password" value="${user.password}" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="password_confirm" class="col-sm-4 control-label">
                                        <g:message code="user.password_confirm" />
                                    </label>
                                    <div class="col-sm-8">
                                        <g:passwordField class="form-control" name="password_confirm" value="${user.password_confirm}" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="col-sm-4 control-label">
                                        <g:message code="user.email" />
                                    </label>
                                    <div class="col-sm-8">
                                        <g:textField class="form-control" name="email" value="${user.email}" />
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset>
                                <g:submitButton name="create" class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                            </fieldset>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
