<div class="row">
    <ul class="nav nav-tabs profile-tabs">
       <li class="active"><a data-toggle="tab" href="#profile">
           <span class="glyphicon glyphicon-home"></span>
           <span class="hidden-xs title"><g:message code="user.show.profile"/></span>
       </a></li>
       <li><a data-toggle="tab" href="#images">
           <span class="glyphicon glyphicon-picture"></span>
           <span class=" hidden-xs title"><g:message code="user.show.images"/></span>
       </a></li>
       <li><a data-toggle="tab" href="#friends">
           <i class="fi-address-book"></i>
           <span class="hidden-xs title"><g:message code="user.show.friends"/></span>
       </a></li>
       <li><a data-toggle="tab" href="#events">
           <i class="fi-map"></i>
           <span class="hidden-xs title" style="margin-left:25px;"> <g:message code="user.show.events"/></span>
       </a></li>
    </ul>

</div>
<div class="row">
    <div class="tab-content" style="min-height:500px; background:white;border: 1px solid #DDD; border-top:none;">
        <div id="profile" class="tab-pane fade in active">
            <sec:ifLoggedIn>
                <g:if test="${g.currentUserID().toInteger() == this.user.id}">
                    <g:render template="tabs/own/profile"/>
                </g:if>
                <g:else>
                    <g:render template="tabs/public/profile"/>
                </g:else>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <g:render template="tabs/public/profile"/>
            </sec:ifNotLoggedIn>
        </div>

        <div id="images" class="tab-pane fade">
            <g:render template="tabs/images"/>
        </div>

        <div id="friends" class="tab-pane fade">
            <sec:ifLoggedIn>
                <g:if test="${g.currentUserID().toInteger() == this.user.id}">
                    <g:render template="tabs/own/friends"/>
                </g:if>
                <g:else>
                    <g:render template="tabs/public/friends"/>
                </g:else>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <g:render template="tabs/public/friends"/>
            </sec:ifNotLoggedIn>
        </div>

        <div id="events" class="tab-pane fade">
            <g:render template="tabs/events"/>
        </div>
    </div>
</div>


