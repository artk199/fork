<!DOCTYPE html>
<html>
<head>
    <title><g:message code="image.edit" /> zdjęcie</title>
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
            <div ng-controller="imageController" ng-init="image=${image.id}; isProfile=${image.owner.profilePicture == image}" class='col-md-8 col-sm-10 col-xs-12 fork-image-info' style="min-height:250px;">

                <g:if test="${image.place != null }">
                    <image-place place-name="${image.place.name}" place-id="${image.place.id}"></image-place>
                </g:if>
                <div style='text-align: left; margin-bottom:20px; margin-top: 20px;'>
                    <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 41px;font-weight: bold; font-style: italic;">
                    &bdquo;<field-edit field-name='title' field-value='${image.title}' id="${image.id}" default="Bez tytułu"></field-edit>&rdquo;
                        <small style='font-size:45%'>${g.formatDate(date:image.dateCreated, format:'yyyy-MM-dd')}</small></h2>
                    <span style="font-size:20px;">
                        <description-edit field-name='description' field-value='${image.description}' id="${image.id}" default="Brak opisu"></description-edit>
                        <small style="color:#777; font-size:60%" class="pull-right"><br/>
                            <a ng-show="showPlace()" ng-href="/place/show/{{place.id}}">{{place.name}} <i class="fi-paw"></i></a>
                            <span ng-hide="showPlace()" style="cursor:default;">Nie powiązano jeszcze z żadnym miejscem</span>
                        </small>
                    </span>
                </div>

                <popup show='show' returned="place">
                    <div link-controller image="${image.id}" class="fork-link-container">
                        <input ng-model="searchValue" ng-change="search()" placeholder="${g.message(code:'image.link.place')}" type="text"/>
                        <div>
                            <div class="row fork-link-search-result" ng-repeat="place in places">
                                <div class="col-md-2 col-sm-1 hidden-xs"></div>
                                <div class="col-md-8 col-sm-10 col-xs-12">
                                    <div place-link>{{place.name}}</div>
                                </div>
                                <div class="col-md-2 col-sm-1 hidden-xs"></div>
                            </div>
                        </div>
                    </div>
                </popup>


                <div ng-show="msg" class="pull-right" style="width:100%">
                    <div class="fork-image-edit-buttons">
                        <div class="fork-image-edit-buttons active">
                            {{msg}}
                        </div>
                    </div>
                </div>

                <div class="pull-right" style="width:100%">
                    <div class="pull-right">
                        <div class="fork-image-edit-buttons">
                            <div ng-click="deleteImage('/image/${image.id}')"><span class="glyphicon glyphicon-trash"></span> <g:message code="image.delete"/></div>
                            <div ng-class="{'active' : isProfile}" ng-click="setProfile('/user/${image.owner.id}/image/${image.id}')"><span class="glyphicon glyphicon glyphicon-pushpin"></span> <g:message code="image.set.profile"/></div>
                            <div ng-click="show = true">
                                <span ng-hide="showPlace()"> <span class="glyphicon glyphicon-link"></span> <g:message code="image.link"/> </span>
                                <span ng-show="showPlace()"> <span class="glyphicon glyphicon-link"></span> <g:message code="image.link.change"/></span>
                            </div>
                        </div>
                        <div class="fork-image-edit-buttons">
                            <div change-url="/user/show/${g.currentUserID()}" ><span class="glyphicon glyphicon-share-alt icon-flipped"></span> <g:message code="application.back"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>