<div class="row" ng-controller="ScoreController" ng-init="init('${place.id}')" style="margin-bottom:30px;">
    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
        <h1 style="float:left;"><g:message code="place.scores.title"/>
    </div>
    <div ng-show="empty">
        <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
        <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="color:white;margin-top:20px; border: 3px solid #fff; box-shadow: 0 0 0 3px #eceae2;; padding: 15px; font-size:16px; background:#498FFF">
            <g:message code="place.scores.empty"/>
        </div>
    </div>
    <sec:ifLoggedIn>
        <form ng-show="!submitted" ng-submit="addScore()">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 fork-place-score-add" >
                <div class="row" style="margin-top: 20px;">
                    <div class="col-lg-1 col-md-1 hidden-sm hidden-xs pull-right"></div>
                    <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 score-selector pull-right" style="font-size:20px; cursor:pointer; text-align:right;">
                        <span star="1" class="glyphicon glyphicon-star" style="margin:-2px;"></span>
                        <span star="2" class="glyphicon glyphicon-star" style="margin:-2px;"></span>
                        <span star="3" class="glyphicon glyphicon-star" style="margin:-2px;"></span>
                        <span star="4" class="glyphicon glyphicon-star" style="margin:-2px;"></span>
                        <span star="5" class="glyphicon glyphicon-star" style="margin:-2px;"></span>
                    </div>
                    <div class="col-lg-1 col-md-1 hidden-md hidden-xs"></div>
                    <div class="col-lg-6 col-md-6 col-sm-8 col-xs-12">
                        <input type="text" ng-model="data.title" placeholder="${g.message(code:'score.summary')}"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                        <textarea ng-model="data.review"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                        <input type="submit" value="Dodaj" class="pull-right" style="width:100px !important;"/>
                    </div>
                </div>
            </div>
        </form>
        <div ng-show="submitted">
            <g:render template="show/score"/>
        </div>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;margin-bottom:20px;" >
            <g:message code="place.scores.add.logged.in.required"/> <a href="${createLink(controller:'login',action:'auth')}"><span><g:message code="layout.header.link.login"/></span></a>
        </div>
    </sec:ifNotLoggedIn>
    <hr class="divider">
    <infinite-list link="/place/${place.id}/score" amount="1">
        <g:render template="show/score"/>
    </infinite-list>
</div>