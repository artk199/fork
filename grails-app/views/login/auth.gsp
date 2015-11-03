<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="default.login" /></title>
</head>

<body>
<div class="row" role="main">
    <div class="col-md-8 col-md-offset-2">
        <h1><g:message code="default.login" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <g:form action="save" class="form-horizontal">
            <fieldset class="form">

                <div class="form-group">
                    <label for="j_username" class="col-sm-4 control-label">
                        <g:message code="user.username" />
                    </label>
                    <div class="col-sm-8">
                        <input class="form-control" name="j_username" id="j_username"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="j_password" class="col-sm-4 control-label">
                        <g:message code="user.password" />
                    </label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" name="j_password" id="j_password"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input name='${rememberMeParameter}' type="checkbox" id="remember_me" <g:if test='${hasCookie}'>checked='checked'</g:if>/><g:message code="default.remember.me"/>
                        </label>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <g:submitButton name="create" class="save btn btn-default" value="${message(code: 'default.button.create.label', default: 'Zaloguj się!')}" />
            </fieldset>
        </g:form>
    </div>
</body>
</html>