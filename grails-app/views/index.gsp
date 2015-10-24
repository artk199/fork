<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title><g:message code="frontpage.title" /></title>
    </head>
    <body>

    <sec:ifLoggedIn>
        <g:loggedInUser />
        <form name="logout" method="POST" action="${createLink(controller:'logout') }">
            <input type="submit" value="${g.message(code:'auth.logout')}">
        </form>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <g:link controller='user' action='register'><g:message code="auth.register" /></g:link>
        <g:link controller='login' action='auth'><g:message code="auth.login" /></g:link>
    </sec:ifNotLoggedIn>
    </body>
</html>
