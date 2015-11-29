<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#places">
                <span class="glyphicon glyphicon-map-marker"></span>
                <span class="title"><g:message code="admin.tabs.places"/></span>
                <g:if test = "${pendingPlaces?.size()>0}">
                    <span class="label label-primary" id="admin-places-label" title="${g.message(code: 'admin.tabs.places.addedByUser')}">${pendingPlaces.size()}</span>
                </g:if>
                <g:if test = "${pendingObjectAdmins?.size()>0}">
                    <span class="label label-info" id="admin-places-label" title="${g.message(code: 'admin.tabs.places.adminRequest')}">${pendingObjectAdmins.size()}</span>
                </g:if>
            </a></li>
            <li><a data-toggle="tab" href="#comments">
                <span class="glyphicon glyphicon-comment"></span>
                <span class="title"><g:message code="admin.tabs.comments"/></span>
                <g:if test = "${flaggedScores?.size()>0}">
                    <span class="label label-warning" id="admin-comments-label" title="${g.message(code: 'admin.tabs.comments.flagged')}">${flaggedScores.size()}</span>
                </g:if>
            </a></li>
            <li><a data-toggle="tab" href="#users">
                <span class="glyphicon glyphicon-user"></span>
                <span class="title"><g:message code="admin.tabs.users"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#photos">
                <span class="glyphicon glyphicon-picture"></span>
                <span class="title"><g:message code="admin.tabs.photos"/></span>
                <g:if test = "${waitingImages?.size()>0}">
                    <span class="label label-primary" id="admin-photos-label" title="${g.message(code: 'admin.tabs.photos.header')}">${waitingImages.size()}</span>
                </g:if>
            </a></li>
            <li><a data-toggle="tab" href="#events">
                <span class="glyphicon glyphicon-plane"></span>
                <span class="title"><g:message code="admin.tabs.events"/></span>
            </a></li>
        </ul>
    </div>
</div>

<div class='row'>
     <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="tab-content">
            <!-- PLACES ADMINISTRATION TAB !-->
            <div id="places" class="tab-pane fade in active">
                <g:render template="tabs/places"/>
            </div>

            <!-- COMMENTS ADMINISTRATION TAB !-->
            <div id="comments" class="tab-pane fade">
                <g:render template="tabs/comments"/>
            </div>

            <!-- USERS ADMINISTRATION TAB !-->
            <div id="users" class="tab-pane fade">
                <g:render template="tabs/users"/>
            </div>

            <!-- PHOTOS SENDED BY USERS ADMINISTRATION TAB !-->
            <div id="photos" class="tab-pane fade">
                <g:render template="tabs/photos"/>
            </div>

            <!-- EVENTS ADMINISTRATION TAB !-->
            <div id="events" class="tab-pane fade">
                <g:render template="tabs/events"/>
            </div>
        </div>
     </div>
</div>