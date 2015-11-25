<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="register.title"/> - <g:message code="register.steps.requiredInfo"/></title>
</head>
<body>
    <div class="row page-section ">
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-lg-8 col-xs-10 text-left">
            <h2>
                <span class="glyphicon glyphicon glyphicon-user pull-left"></span>
                <g:message code="register.steps.requiredInfo"/>
            </h2>

            <g:hasErrors bean="${this.user}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.user}" var="error">
                        <div class="alert alert-danger" role="alert"><g:message error="${error}"/></div>
                    </g:eachError>
                </ul>
            </g:hasErrors>

            <p><g:message code="register.steps.requiredInfo.info"/></p>
            <g:form class="form-horizontal">
                <fieldset class="form">
                    <div class="form-group">
                        <label for="username" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                            <g:message code="user.username" />
                            <g:message code="register.fieldRequiredSymbol"/>
                        </label>
                        <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                            <g:textField class="form-control" name="username" value="${user.username}" />
                        </div>
                        <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                            <g:message code="user.password" />
                            <g:message code="register.fieldRequiredSymbol"/>
                        </label>
                        <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                            <g:passwordField class="form-control" name="password" />
                        </div>
                        <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                    </div>

                    <div class="form-group">
                        <label for="password_confirm" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                            <g:message code="user.password_confirm" />
                            <g:message code="register.fieldRequiredSymbol"/>
                        </label>
                        <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                            <g:passwordField class="form-control" name="password_confirm" />
                        </div>
                        <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                            <g:message code="user.email" />
                            <g:message code="register.fieldRequiredSymbol"/>
                        </label>
                        <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                            <g:textField class="form-control" name="email" value="${user.email}" />
                        </div>
                        <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                    </div>
                </fieldset>
                <div class='buttons'>
                    <fieldset>
                        <label for="next-step" class="btn btn-default pull-right">
                            <span class="glyphicon glyphicon-triangle-right"></span>
                            <span><g:message code="register.steps.requiredInfo.next"/></span>
                        </label>
                        <g:actionSubmit id="next-step" class="hidden" action="validateRequiredInfo" value="${message(code: "register.steps.requiredInfo.next")}" />
                    </fieldset>
                </div>
            </g:form>
        </div>
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    </div>
</body>
</html>