<div>
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