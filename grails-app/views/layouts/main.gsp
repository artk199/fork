<!doctype html>
<html lang="en" ng-app="forkApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><g:layoutTitle default="Fork"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <asset:stylesheet src="application.css"/>
        <asset:stylesheet src="bootstrap.min.css"/>
        <asset:stylesheet src="foundation-icons.css"/>
        <asset:stylesheet src="bootstrap-theme.min.css"/>
        <asset:stylesheet src="bootstrap-sortable.css"/>
        <asset:stylesheet src="bootstrap-multiselect.css"/>
        <asset:stylesheet src="jquery.datetimepicker.css"/>
        <asset:stylesheet src="select2.css"/>

        <asset:javascript src="application.js"/>
        <asset:javascript src="select2.js"/>

        <asset:javascript src="jquery.datetimepicker.full.min.js"/>
        <g:layoutHead/>
    </head>
    <body>
        <sec:ifLoggedIn>
            <g:render template="/layouts/userpanel"/>
        </sec:ifLoggedIn>
        <g:render template="/layouts/header"/>
        <div class="container-fluid fork-content">
            <g:layoutBody/>
            <g:render template="/layouts/footer"/>
        </div>
        <!-- Sorting bootstrap's tables mechanics !-->
        <asset:javascript src="jquery-2.1.3.js"/>
        <asset:javascript src="bootstrap-sortable.js"/>

        <asset:javascript src="bootstrap-multiselect.js"/>

        <asset:javascript src="bootstrap.js"/>
        <asset:javascript src="angular.js"/>
        <asset:javascript src="angular-animate.js"/>
        <asset:javascript src="fork.js"/>
        <asset:javascript src="quicksearch/directives.js"/>
        <asset:javascript src="score/scoreController.js"/>
    </body>
</html>
