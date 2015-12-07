<div class="row">
    <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="margin-bottom:10px;">
        <div class="row">
            <div class="col-md-2 col-sm-3 col-xs-3" style="height: 125px;">
                <div class="pull-left">
                        <a ng-href="/user/show/{{instance.owner.id}}">
                            <img ng-if="instance.owner.profile" ng-src="/image/{{instance.owner.profile}}/mini" width="75px" height="75px">
                            <img ng-if="!instance.owner.profile" src="/assets/no-profile.jpg" width="75px" height="75px">
                            <div style="text-aling:left" ng-app>
                                {{ instance.owner.username }}
                            </div>
                        </a>
                </div>
            </div>
            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9" style="color:white;background:#498FFF;border: 3px solid #fff;box-shadow: 0 0 0 3px #eceae2;border-radius: 10px;">
                <div class="row" style="margin: 5px;">
                    <div class="col-md-12 col-sm-12 col-xs-12" style="border-bottom: 1px solid black;">
                        <div class="pull-left" style="margin: 5px 0px;;font-size: 16px;font-weight: bold;font-style: italic;">
                            {{ instance.title }}
                        </div>
                        <div class="pull-right" style="color:black;font-size: 20px;text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">
                            <stars amount="{{instance.score}}" active="{{true}}"></stars>
                            <stars amount="{{5-instance.score}}" active="{{false}}"></stars>
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" style="margin: 10px 0px;">
                        <div class="pull-left" style="text-align: left;">
                            {{ instance.review }}
                        </div>
                    </div>
                    <div class="pull-right">
                        <sec:ifLoggedIn>
                            <a ng-if="!instance.isOwner && !instance.alreadyReported" ng-href="/place/reportScore/{{instance.id}}" style="color:#fff">
                                <span class="glyphicon glyphicon-flag"></span>
                                <g:message code="default.link.report"/>
                            </a>
                            <a ng-if="instance.isOwner" ng-href="/score/edit/{{instance.id}}" style="color:#fff">
                                <span class="glyphicon glyphicon-cog"></span>
                                <g:message code="default.link.edit"/>
                            </a>
                        </sec:ifLoggedIn>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>