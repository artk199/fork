<div class="row">
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-10 col-xs-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#info">
                <span class="glyphicon glyphicon-map-marker"></span>
                <span class="title"><g:message code="event.show.tabs.info"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#participants">
                <span class="glyphicon glyphicon-envelope"></span>
                <span class="title"><g:message code="event.show.tabs.participants"/></span>
            </a></li>
        </ul>
    </div>
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
</div>

<div class="tab-content">
    <div id="info" class="tab-pane fade in active">
        <g:render template="tabs/tabs_info" model="[event:event]"/>
    </div>

    <div id="participants" class="tab-pane fade">
        <g:render template="tabs/tabs_participants" model="[event:event]"/>
    </div>
</div>
