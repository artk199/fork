<div class="header">
    <div>
        <img ng-if="instance.profile" ng-src="/image/{{instance.profile}}/mini" width="40px" height="40px" style="border: 1px solid #DDD;">
        <img ng-if="!instance.profile" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="40px" height="40px" style="border: 1px solid #DDD;">
    </div>
    <div>
        <a ng-href="/user/show/{{instance.user}}"><span style="font-weight:bold">{{instance.user_name}}</span></a>
        <br/>
        <small><time-difference date="{{instance.date}}"></time-difference></small>
    </div>
</div>