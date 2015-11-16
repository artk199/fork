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
       <li><a data-toggle="tab" href="#visited">
           <i class="fi-map icon-small"></i>
           <span class="hidden-xs title"><g:message code="user.show.visited"/></span>
       </a></li>
       <li><a data-toggle="tab" href="#events">
           <i class="fi-web"></i>
           <span class="hidden-xs title"><g:message code="user.show.events"/></span>
       </a></li>
    </ul>

</div>
<div class="row">
    <div class="tab-content" style="min-height:500px; background:white;border: 1px solid #DDD; border-top:none;">
    <!-- LOCALISATION OF THE OBJECT  !-->
        <div id="profile" class="tab-pane fade in active">
            <g:render template="tabs/profile"/>
        </div>

        <!-- CONTACT WITH THE OWNER OF OBJECT  !-->
        <div id="images" class="tab-pane fade">
            <g:render template="tabs/images"/>
        </div>

        <!-- PRICES (MENU) OF THE ATTRACTIONS  !-->
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

        <!-- EVENTS BOUNDED WITH THE OBJECT !-->
        <div id="visited" class="tab-pane fade">

        </div>

        <!-- USERS PHOTOS WITH THE OBJECT !-->
        <div id="events" class="tab-pane fade">

        </div>
    </div>
</div>


