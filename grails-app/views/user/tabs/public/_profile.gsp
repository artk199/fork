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
                <g:if test="${this.user.firstName && this.user.lastName}">
                    <span class="fork-profile-info">
                        ${this.user.firstName} ${this.user.lastName.substring(0,1)}
                    </span>
                </g:if>
                <g:else>
                    <span class="fork-profile-info"> ${this.user.username}</span>
                </g:else>
                <g:if test="${this.user.town}">
                    <span class="fork-profile-info">Mieszka w ${this.user.town}</span>
                </g:if>
                <span class="fork-profile-info">Ma ${this.user.friends.size()} znajomych</span>
                <span class="fork-profile-info">Napisał ${this.user.scores.size()} recenzji</span>
                <g:if test="${this.user.about}">
                    <hr class="divider" style="margin-top:10px; margin-bottom:10px;">
                    <span class="fork-profile-info">${this.user.about}</span>
                </g:if>
            </div>
        </div>
        <div profile-details style="padding-right:20px;">
            <g:if test="${this.user.activities.size() == 0 }">
                <div class='col-md-12' style="height:100%; border: 1px #DDD solid; padding-bottom: 15px; line-height: 40px;color:#AAA;cursor:default;font-size:20px;padding-top:20px;">
                    Ten użytkownik nie ma żadnej aktywności do wyświetlenia.
                </div>
            </g:if>

            <infinite-list link="${'/user/'+this.user.id+'/activities'}" amount="1">
                <div class='col-md-12 fork-profile-activity'>
                    <g:render template="/user/tabs/activity/common"/>
                    <div ng-if="instance.type == 'IMAGE'">
                        <g:render template="/user/tabs/activity/image"/>
                    </div>
                    <div ng-if="instance.type == 'REVIEW'">
                        <g:render template="/user/tabs/activity/review"/>
                    </div>
                    <div ng-if="instance.type == 'FRIEND'">
                        <g:render template="/user/tabs/activity/friend"/>
                    </div>
                </div>
            </infinite-list>

        </div>

    </div>
</div>
