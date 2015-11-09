<!DOCTYPE html>
<html>
<head>
    <title><g:message code="image.edit" /></title>
    <meta name="layout" content="main"/>
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
    <meta name='description' content='' />
    <meta name='keywords' content='' />
</head>
<body>
    <div class='row fork-gallery-container'>
        <div class='col-md-12' style='padding:0px; margin:10px; margin-bottom:0px;overflow:auto; max-height:500px'>
            <img src="/image/${image.id}"/>
        </div>
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class='col-md-8 col-sm-10 col-xs-12 fork-image-info' style="min-height:250px;">

                <div style='text-align: left; margin-bottom:20px; margin-top: 20px;'>
                    <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 41px;font-weight: bold; font-style: italic;">
                    &bdquo;<field-edit field-name='title' field-value='${image.title}' id="${image.id}" default="Bez tytułu"></field-edit>&rdquo;
                        <small style='font-size:45%'>09.09.2009</small></h2>
                    <span style="font-size:20px;">
                        <description-edit field-name='description' field-value='${image.description}' id="${image.id}" default="Brak opisu"></description-edit>
                    </span>
                </div>



                <div class="pull-right">
                    <div class="fork-image-edit-buttons">
                        <div><span class="glyphicon glyphicon-trash"></span> <g:message code="image.delete"/></div>
                        <div><span class="glyphicon glyphicon-link"></span> <g:message code="image.link"/></div>
                    </div>
                    <div class="fork-image-edit-buttons-group" ng-controller="visibilityController">
                        <div ng-style="isActive('public')" ng-click="setVisibility('public')"><span class="glyphicon glyphicon-eye-open"></span> <g:message code="image.set.public"/></div>
                        <div ng-style="isActive('hidden')" ng-click="setVisibility('hidden')"><span class="glyphicon glyphicon-eye-close"></span> <g:message code="image.set.hidden"/></div>
                        <div ng-style="isActive('private')"ng-click="setVisibility('private')"><span class="glyphicon glyphicon-lock"></span> <g:message code="image.set.private"/></div>
                    </div>
                    <div class="fork-image-edit-buttons">
                        <div change-url="/user/show/${g.currentUserID()}" ><span class="glyphicon glyphicon-share-alt icon-flipped"></span> <g:message code="application.back"/></div>
                    </div>
                </div>

            </div>

        </div>
        <div class="col-md-2 col-sm-1 hidden-xs"></div>
    </div>
</body>
</html>