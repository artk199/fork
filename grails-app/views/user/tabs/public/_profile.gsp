<div class="row" >
    <div ng-controller="profileController" class="col-md-12 profile-container">
        <div profile-image style="border: 1px #DDD solid">
            <div style="width:198.4px;float:left;height:200px;padding:0px;border-bottom: 1px #DDD solid;">
                <g:if test="${this.user.profilePicture}">
                    <img src="/image/${this.user.profilePicture.id}" width="100%" height="100%" />
                </g:if>
                <g:else>
                    <img src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="100%" height="100%" />
                </g:else>
            </div>
            <div style="min-width:200px;float:left;height: 100%;">
                <div class="fork-profile-button">Edytuj informacje </div>
                <div class="fork-profile-button">Edytuj konto </div>
                <div class="fork-profile-button">Edytuj prywatbisc </div>
            </div>
        </div>
        <div profile-details style="padding-right:20px;">
            <g:each in="${this.user.activities}" var="activity">
                <g:if test="${activity.activityType == pl.fork.activity.ActivityType.REVIEW}">
                    <g:render template="/user/tabs/activity/review" model="[activity:activity]"/>
                </g:if>
                <g:if test="${activity.activityType == pl.fork.activity.ActivityType.IMAGE}">
                    <g:render template="/user/tabs/activity/image" model="[activity:activity]"/>
                </g:if>
                <g:if test="${activity.activityType == pl.fork.activity.ActivityType.FRIEND}">
                    <g:render template="/user/tabs/activity/friend" model="[activity:activity]"/>
                </g:if>
            </g:each>

        </div>

    </div>
</div>
