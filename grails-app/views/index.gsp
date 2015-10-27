<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta name="layout" content="main"/>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
    <meta name='description' content='' />
    <meta name='keywords' content='' />
    <link rel='shortcut icon' href='img/icon.png' type='image/x-icon' />
</head>
<body>

    <g:render template="/home/main"/>

<sec:ifLoggedIn>
    <g:loggedInUser />
    <form name="logout" method="POST" action="${createLink(controller:'logout') }">
        <input type="submit" value="${g.message(code:'auth.logout')}">
    </form>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
    <g:link controller='user' action='register'><g:message code="auth.register" /></g:link>
</sec:ifNotLoggedIn>

    <g:render template="/home/content"/>

</body>
</html>