<div>
    <g:if test="${this.user.friends.size() == 0 }">
        <div class='col-md-2'></div>
        <div class='col-md-8' style="height:100%; border: 1px #DDD solid; padding-bottom: 15px; line-height: 40px;color:#AAA;cursor:default;font-size:20px;padding-top:20px; margin-top:20px;">
           Użytkownik nie ma jeszcze żadnych znajomych.
        </div>
        <div class='col-md-2'></div>
    </g:if>
    <g:each in="${this.user.friends}" var="friend">
        <div class="fork-friend">
            <div>
                <g:if test="${friend.profilePicture}">
                    <img width="75px" height="73px" src="/image/${friend.profilePicture.id}/mini"/>
                </g:if>
                <g:else>
                    <img width="75px" height="73px" src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg"/>
                </g:else>
            </div>
            <div>
                <a ng-href="/user/show/${friend.id}">
                    ${friend.username}
                </a>
            </div>
        </div>
    </g:each>



</div>