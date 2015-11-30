<div style="height:100px;">
    <div style="float:left; width:140px;height:140px;">
         <div style="float:left">
             <img ng-if="instance.friend_profile" ng-src="/image/{{instance.friend_profile}}/mini" width="140px" height="140px" style="border: 1px solid #DDD;">
             <img ng-if="!instance.friend_profile" src="/assets/no-profile.jpg" width="140px" height="140px" style="border: 1px solid #DDD;">
         </div>
    </div>
    <div style="margin-top:35px;float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:35px; overflow:hidden;white-space: nowrap;text-overflow:ellipsis;">
        <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 30px;font-weight: bold;">
            <sec:ifLoggedIn>
                <span ng-if="instance.friend == ${g.currentUserID()}">
                    Został twoim znajomym
                </span>
                <span ng-if="instance.friend != ${g.currentUserID()}">
                    Znalazł nowego znajomego
                </span>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <span>
                    Znalazł nowego znajomego
                </span>
            </sec:ifNotLoggedIn>
        </h2>
    </div>
    <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:60px;overflow:hidden;">
        <sec:ifLoggedIn>
            <span ng-if="instance.friend != ${g.currentUserID()}">
                <a ng-href="/user/show/{{instance.friend}}">{{instance.friend_name}}</a>
            </span>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <span>
                <a ng-href="/user/show/{{instance.friend}}">{{instance.friend_name}}</a>
            </span>
        </sec:ifNotLoggedIn>
    </div>
</div>
