<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="admin.title"/></title>
    <asset:javascript src="jquery-2.1.3.js"/>
    <script>
        setEditLabel('${g.message(code:'default.link.edit')}');
        setEmptyLabel('${g.message(code:'default.input.empty')}');
    </script>
</head>
<body>
    <h1><g:message code="admin.header"/></h1>

    <g:render template="tabs"/>
</body>
</html>