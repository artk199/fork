<div class="row" ng-controller="ScoreController" ng-init="init('${place.id}')" style="margin-bottom:30px;">
    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
        <h1 style="float:left;"><g:message code="place.scores.title"/>
    </div>
    <div ng-show="noScores()">
        <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
        <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="margin-top:20px; border: 3px solid #fff; box-shadow: 0 0 0 3px #eceae2;; padding: 15px; font-size:16px; background:#D6E6C3">
            <g:message code="place.scores.empty"/>
        </div>
    </div>
    <sec:ifLoggedIn>
        <g:if test="${score == null}">
            <form ng-show="notSubmitted()" ng-submit="addScore()">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 fork-place-score-add" >
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-lg-1 col-md-1 hidden-sm hidden-xs pull-right"></div>
                        <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 score-selector pull-right" style="font-size:20px; cursor:pointer; text-align:right;">
                            <%--<input type="text" ng-model="data.score" placeholder="${g.message(code:'score.score')}"/>--%>
                            <span star="1" class="glyphicon glyphicon-star"></span>
                            <span star="2" class="glyphicon glyphicon-star"></span>
                            <span star="3" class="glyphicon glyphicon-star"></span>
                            <span star="4" class="glyphicon glyphicon-star"></span>
                            <span star="5" class="glyphicon glyphicon-star"></span>
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
        </g:if>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;margin-bottom:20px;" >
            <g:message code="place.scores.add.logged.in.required"/> <a href="${createLink(controller:'login',action:'auth')}"><span><g:message code="layout.header.link.login"/></span></a>
        </div>
    </sec:ifNotLoggedIn>
    <div ng-repeat="score in scores">
        <div class="row">
            <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="margin-bottom:10px;">
                <div class="row">
                    <div class="col-md-2 col-sm-3 col-xs-3" style="height: 125px;">
                        <div class="pull-left">
                                <a ng-href="/user/show/{{score.owner.id}}">
                                    <img ng-src="{{ getPicture(score) }}" width="75px" height="75px"/>
                                    <div style="text-aling:left" ng-app>
                                        {{ score.owner.username }}
                                    </div>
                                </a>
                        </div>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9" style="background:#D6E6C3;border: 3px solid #fff;box-shadow: 0 0 0 3px #eceae2;border-radius: 10px;">
                        <div class="row" style="margin: 5px;">
                            <div class="col-md-12 col-sm-12 col-xs-12" style="border-bottom: 1px solid black;">
                                <div class="pull-left" style="margin: 5px 0px;;font-size: 16px;color: #4D8365;font-weight: bold;font-style: italic;">
                                    {{ score.title }}
                                </div>
                                <div class="pull-right" style="font-size: 20px;text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">
                                    <span ng-repeat="score in scoreCount(score.score) track by $index" class="glyphicon glyphicon-star" style="color: #F9FF00;"></span>
                                    <span ng-repeat="score in scoreCount(5-score.score) track by $index" class="glyphicon glyphicon-star" style="left:-4px;"></span>
                                </div>
                            </div>
                            <div class="col-md-12 col-sm-12 col-xs-12" style="margin: 10px 0px;">
                                <div class="pull-left" style="text-align: left;">
                                    {{ score.review }}
                                </div>
                            </div>
                            <div class="pull-right">
                                <a ng-href="/place/reportScore/{{score.id}}">
                                    <span class="glyphicon glyphicon-flag"></span>
                                    <g:message code="default.link.report"/>
                                </a>
                                <a ng-href="/score/edit/{{score.id}}">
                                    <span class="glyphicon glyphicon-cog"></span>
                                    <g:message code="default.link.edit"/>
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>