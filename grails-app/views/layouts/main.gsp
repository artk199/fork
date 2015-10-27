<!doctype html>
<html lang="en" ng-app="forkApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><g:layoutTitle default="Fork"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.js"></script>
        <asset:stylesheet src="application.css"/>
        <asset:stylesheet src="bootstrap.min.css"/>
        <asset:stylesheet src="bootstrap-theme.min.css"/>
        <asset:javascript src="application.js"/>
        <asset:javascript src="bootstrap.min.js"/>
        <asset:javascript src="npm.js"/>

        <g:layoutHead/>
    </head>
    <body>
        <g:render template="/layouts/header"/>
        <div class="container-fluid ">
            <div class="row"><%-- FIRST ROW IS BUGGED FOR SOME REASON? STARTS AT 75% OF PAGE WIDTH--%></div>
            <div class="row fork-content">
                <div class="col-md-2 col-sm-1 hidden-xs"></div>
                <div class="col-md-8 col-sm-10 col-xs-12">
                    <div class="fork-inner-content">
                        <g:layoutBody/>
                        <g:render template="/layouts/footer"/>
                    </div>
                </div>
                <div class="col-md-2 col-sm-1 hidden-xs"></div>
            </div>
        </div>
        <asset:javascript src="fork.js"/>
    </body>
</html>
