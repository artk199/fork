<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="register.title"/> - <g:message code="register.steps.additionalInfo"/></title>
</head>
<body>
<div class="row page-section ">
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-lg-8 col-xs-10 text-left">
        <h2>
            <span class="glyphicon glyphicon-eye-open pull-left"></span>
            <g:message code="register.steps.additionalInfo"/>
        </h2>

        <g:hasErrors bean="${this.user}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.user}" var="error">
                    <div class="alert alert-danger" role="alert"><g:message error="${error}"/></div>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <p><g:message code="register.steps.additionalInfo.info"/></p>
        <p><g:message code="register.steps.additionalInfo.changingDataInfo"/></p>

        <g:form class="form-horizontal">
            <fieldset class="form">
                <div class="form-group">
                    <label for="firstName" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                        <g:message code="user.firstName" />
                    </label>
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                        <g:textField class="form-control" name="firstName" value="${user.firstName}" />
                    </div>
                    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                </div>

                <div class="form-group">
                    <label for="lastName" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                        <g:message code="user.lastName" />
                    </label>
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                        <g:textField class="form-control" name="lastName" value="${user.lastName}" />
                    </div>
                    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                </div>

                <div class="form-group">
                    <label for="town" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                        <g:message code="user.town" />
                    </label>
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                        <g:textField class="form-control" name="town" value="${user.town}" />
                    </div>
                    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                </div>

                <div class="form-group">
                    <label for="address" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                        <g:message code="user.address" />
                    </label>
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                        <g:textField class="form-control" name="address" value="${user.address}" />
                    </div>
                    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                </div>

                <div class="form-group">
                    <label for="about" class="col-xs-4 col-sm-3 col-md-3 col-lg-3 control-label">
                        <g:message code="user.about" />
                    </label>
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                        <textarea class="form-control" name="about"
                                  id="about" value="${user.about}">${user.about}</textarea>
                    </div>
                    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
                </div>
            </fieldset>
            <div class="buttons">
                <fieldset>
                    <label for="previous-step" class="btn btn-default pull-left">
                        <span class="glyphicon glyphicon-triangle-left"></span>
                        <span><g:message code="register.steps.additionalInfo.back"/></span>
                    </label>

                    <label for="next-step" class="btn btn-default pull-right">
                        <span class="glyphicon glyphicon-triangle-right"></span>
                        <span><g:message code="register.steps.additionalInfo.next"/></span>
                    </label>

                    <g:actionSubmit id="previous-step" class="hidden" action="backToRequiredInfo" value="${message(code: "register.steps.additionalInfo.back")}" />
                    <g:actionSubmit id="next-step" class="hidden" action="showSummaryView" value="${message(code: "register.steps.additionalInfo.next")}" />
                </fieldset>
            </div>

        </g:form>
    </div>
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
</div>
</body>
</html>