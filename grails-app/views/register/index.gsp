<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title><g:message code="register.title"/></title>
</head>
<body>
    <div class="row page-section ">
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-2 col-sm-2 col-lg-2 hidden-xs">
            <g:img class="img-responsive" file="home_community.png"/>
        </div>
        <div class="col-md-6 col-sm-6 col-lg-6 col-xs-10 text-left">
            <h2>
                <span class="glyphicon glyphicon glyphicon-user pull-left"></span>
                <g:message code="register.header"/>
            </h2>
            <p><g:message code="register.welcomeText"/></p>
            <p><g:message code="register.startInfo" args="[message(code: 'register.startRegistration')]"/></p>
            <g:form>
                <label for="start-registration" class="btn btn-default pull-right">
                    <span class="glyphicon glyphicon-triangle-right"></span>
                    <span><g:message code="register.startRegistration"/></span>
                </label>
                <g:actionSubmit id="start-registration" class="hidden" action="showRequiredInfo" value="${message(code: 'register.startRegistration')}" />
            </g:form>
        </div>
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    </div>

    <div class="row page-section blue-section ">
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-lg-8 col-xs-10 text-left">
        <h2>
            <span class="glyphicon glyphicon-question-sign pull-left"></span>
            <g:message code="register.whyCreate.header"/>
        </h2>
        <p><g:message code="register.whyCreate.info"/></p>
        <g:message code="register.whyCreate.list"/>
        <p><g:message code="register.whyCreate.endInfo"/></p>
    </div>
    <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
</div>
</body>
</html>