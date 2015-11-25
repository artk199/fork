<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="register.title"/> - <g:message code="register.steps.summary"/></title>
</head>
<body>
<div class="row page-section ">
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-lg-8 col-xs-10 text-left">
        <h2>
            <span class="glyphicon glyphicon-ok-sign pull-left"></span>
            <g:message code="register.title"/> - <g:message code="register.steps.summary"/>
        </h2>

        <g:hasErrors bean="${this.user}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.user}" var="error">
                    <div class="alert alert-danger" role="alert"><g:message error="${error}"/></div>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <p><g:message code="register.steps.summary.info"/></p>
        <p><g:message code="register.steps.summary.checkDataInfo"
                      args="[message(code: 'register.steps.summary.createAccount'), message(code: 'register.fieldRequiredSymbol')]"/></p>
        <table class="table table-striped text-left">
            <tbody>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6 text-">
                        <span class="glyphicon glyphicon-user"></span>
                        <g:message code="user.username"/>
                        <g:message code="register.fieldRequiredSymbol"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">${user?.username}</td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-envelope"></span>
                        <g:message code="user.email"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">${user?.email}</td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-object-align-left"></span>
                        <g:message code="user.firstName"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        ${user?.firstName ? user?.firstName : message(code:'default.input.empty')}
                    </td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-object-align-left"></span>
                        <g:message code="user.lastName"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        ${user?.lastName ? user?.lastName : message(code:'default.input.empty')}
                    </td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-map-marker"></span>
                        <g:message code="user.town"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        ${user?.town ? user?.town : message(code:'default.input.empty')}
                    </td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-road"></span>
                        <g:message code="user.address"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        ${user?.address ? user?.address : message(code:'default.input.empty')}
                    </td>
                </tr>
                <tr>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <span class="glyphicon glyphicon-comment"></span>
                        <g:message code="user.about"/>
                    </td>
                    <td class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        ${user?.about ? user?.about : message(code:'default.input.empty')}
                    </td>
                </tr>
                <tr>
            </tbody>
        </table>
        <div class="buttons">
            <g:form>
                <fieldset>
                    <label for="previous-step" class="btn btn-default pull-left">
                        <span class="glyphicon glyphicon-triangle-left"></span>
                        <span><g:message code="register.steps.summary.backToAdditionalInfo"/></span>
                    </label>

                    <label for="next-step" class="btn btn-default pull-right">
                        <span class="glyphicon glyphicon-star"></span>
                        <span><g:message code="register.steps.summary.createAccount"/></span>
                    </label>

                    <g:actionSubmit id="previous-step" class="hidden" action="backToAdditionalInfo" value="${message(code: "register.steps.summary.backToAdditionalInfo")}" />
                    <g:actionSubmit id="next-step" class="hidden" action="finalizeRegistration" value="${message(code: "register.steps.summary.createAccount")}" />
                </fieldset>
            </g:form>
        </div>
    </div>
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
</div>
</body>
</html>