<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#places">
                <span class="glyphicon glyphicon-map-marker"></span>
                <span class="title"><g:message code="admin.tabs.places"/></span>
                <span class="label label-primary">1</span>
            </a></li>
            <li><a data-toggle="tab" href="#comments">
                <span class="glyphicon glyphicon-comment"></span>
                <span class="title"><g:message code="admin.tabs.comments"/></span>
                <span class="label label-warning">1</span>
            </a></li>
            <li><a data-toggle="tab" href="#users">
                <span class="glyphicon glyphicon-user"></span>
                <span class="title"><g:message code="admin.tabs.users"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#photos">
                <span class="glyphicon glyphicon-picture"></span>
                <span class="title"><g:message code="admin.tabs.photos"/></span>
                <span class="label label-primary">1</span>
            </a></li>
            <li><a data-toggle="tab" href="#events">
                <span class="glyphicon glyphicon-plane"></span>
                <span class="title"><g:message code="admin.tabs.events"/></span>
                <span class="label label-primary">1</span>
            </a></li>
            <li><a data-toggle="tab" href="#errors">
                <span class="glyphicon glyphicon-fire"></span>
                <span class="title"><g:message code="admin.tabs.errors"/></span>
                <span class="label label-warning">2</span>
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

            <!-- ERRORS ADMINISTRATION TAB !-->
            <div id="errors" class="tab-pane fade">
                <g:render template="tabs/errors"/>
            </div>
        </div>
     </div>
</div>