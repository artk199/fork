<div class="row" >
    <div ng-controller="profileController" class="col-md-12 profile-container">
        <div profile-image>
            <div style="width:200px;float:left;height:200px;padding:0px;border: 1px #DDD solid;">
                <g:if test="${this.user.profilePicture}">
                    <img src="/image/${this.user.profilePicture.id}" width="100%" height="100%"/>
                </g:if>
                <g:else>
                    <img src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="100%" height="100%" />
                </g:else>
            </div>

            <div style="min-width:200px;float:left;height: 100%;margin-top:50px;border: 1px #DDD solid;padding-bottom:20px;padding-top:20px;">
                <span style="width:100%;text-align:left;display:block;font-size:20px; margin-bottom:10px;margin-left:20px;">Informacje</span>
                <span style="display:block;width:100%;font-size:12px; text-align:left; margin-left:30px;">${this.user.username}</span>
                <span style="display:block;width:100%;font-size:12px; text-align:left; margin-left:30px;">Mieszka w Warszawa</span>
                <span style="display:block;width:100%;font-size:12px; text-align:left; margin-left:30px;">Urodzony 20 maja 1992 roku</span>
                <span style="display:block;width:100%;font-size:12px; text-align:left; margin-left:30px;">Ma 12 znajomych</span>
                <span style="display:block;width:100%;font-size:12px; text-align:left; margin-left:30px;">Napisał 4 recenzje</span>
            </div>
        </div>
        <div profile-details style="padding-right:20px;">
            <g:if test="${this.user.activities.size() == 0 }">
                <div class='col-md-12' style="height:100%; border: 1px #DDD solid; padding-bottom: 15px; line-height: 40px;color:#AAA;cursor:default;font-size:20px;padding-top:20px;">
                    Ten użytkownik nie ma żadnej aktywności do wyświetlenia.
                </div>
            </g:if>
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
