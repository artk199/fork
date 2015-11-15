<div ng-controller="friendsController" ng-init="getFriends()">

    <div class="fork-friends-header">
        <div class="pull-left">
            <input ng-click="tab = 1" type="button" class="btn btn-primary" value="Znajomi"/>
            <input ng-click="tab = 2" type="button" class="btn btn-primary" value="Zaproszenia do znajomych"/>
            <input ng-click="tab = 3" type="button" class="btn btn-primary" value="Znajdź znajomych"/>
        </div>
    </div>
    <div>
        <div ng-show="tab==1">
            <div ng-repeat="friend in friends">
                <div class="fork-friend">
                    <div>
                        <img width="75px" height="73px" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                    </div>
                    <div>
                        <a ng-href="/user/show/{{friend.id}}">
                            {{friend.username}}
                        </a>
                        <span reject-friend class="glyphicon glyphicon-minus-sign fork-friend-icon-add pull-right"></span>
                    </div>

                </div>
            </div>
        </div>
        <div ng-show="tab==2">
            <div>
                <div ng-repeat="request in requests">
                    <div class="fork-friend">
                        <div>
                            <img width="75px" height="73px" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                        </div>
                        <div>
                            <a ng-href="/user/show/{{request.id}}">
                                {{request.username}}
                            </a>
                            <span reject-friend class="glyphicon glyphicon-minus-sign fork-friend-icon-add pull-right"></span>
                            <span accept-friend class="glyphicon glyphicon-plus-sign fork-friend-icon-add pull-right"></span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div ng-show="tab==3">
            <div class="fork-friends-search">
                <input ng-change="findUsers()" ng-model="query"/>
                <div>
                    <div ng-repeat="user in users">
                        <div class="fork-friend">
                            <div>
                                <img width="75px" height="73px" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                            </div>
                            <div>
                                <a ng-href="/user/show/{{user.id}}">
                                    {{user.username}}
                                </a>
                                <span add-friend class="glyphicon glyphicon-plus-sign fork-friend-icon-add pull-right"></span>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>



</div>