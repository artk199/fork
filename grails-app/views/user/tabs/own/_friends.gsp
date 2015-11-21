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
                        <img width="75px" height="73px" ng-if="friend.profilePicture" ng-src="/image/{{friend.profilePicture}}/mini">
                        <img width="75px" height="73px" ng-hide="{{friend.profilePicture}}" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                    </div>
                    <div>
                        <a ng-href="/user/show/{{friend.id}}">
                            {{friend.username}}
                        </a>
                        <span reject-friend array="friends" class="glyphicon glyphicon-minus-sign fork-friend-icon-add pull-right"></span>
                        <span send-message class="glyphicon glyphicon-send fork-friend-icon-add pull-right"></span>
                    </div>

                </div>
            </div>
        </div>
        <div ng-show="tab==2">
            <div class="row">
                <div class="col-md-6" style="text-align:left;">
                    <h2><span class="label label-primary" style="margin-left: 15px;">Zaprosili Ciebie <span class="badge" style="background:#d9534f"> {{requests.length}}</span></span></h2>
                    <div ng-repeat="request in requests">
                        <div class="fork-friend">
                            <div>
                                <img width="75px" height="73px" ng-if="request.profilePicture" ng-src="/image/{{request.profilePicture}}/mini">
                                <img width="75px" height="73px" ng-hide="{{request.profilePicture}}" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                            </div>
                            <div>
                                <a ng-href="/user/show/{{request.id}}">
                                    {{request.username}}
                                </a>
                                <span reject-friend array="requests" class="glyphicon glyphicon-minus-sign fork-friend-icon-add pull-right"></span>
                                <span accept-friend array="requests" class="glyphicon glyphicon-plus-sign fork-friend-icon-add pull-right"></span>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-6" style="text-align:left;">
                    <h2><span class="label label-primary active" style="margin-left: 15px;">Twoje zaproszenia <span class="badge" style="background:#d9534f"> {{invitations.length}}</span></span></h2>
                    <div ng-repeat="invitation in invitations">
                        <div class="fork-friend">
                            <div>
                                <img width="75px" height="73px" ng-if="invitation.profilePicture" ng-src="/image/{{invitation.profilePicture}}/mini">
                                <img width="75px" height="73px" ng-hide="{{invitation.profilePicture}}" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                            </div>
                            <div>
                                <a ng-href="/user/show/{{invitation.id}}">
                                    {{invitation.username}}
                                </a>
                                <span reject-friend array="invitations" class="glyphicon glyphicon-minus-sign fork-friend-icon-add pull-right"></span>
                            </div>

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
                                <img width="75px" height="73px" ng-if="user.profilePicture" ng-src="/image/{{user.profilePicture}}/mini">
                                <img width="75px" height="73px" ng-hide="{{user.profilePicture}}" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
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