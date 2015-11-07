<div class="row">
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-10 col-xs-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#localisation">
                <span class="glyphicon glyphicon-map-marker"></span>
                <span class="title"><g:message code="place.show.tabs.localisation"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#contact">
                <span class="glyphicon glyphicon-envelope"></span>
                <span class="title"><g:message code="place.show.tabs.contact"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#prices">
                <span class="glyphicon glyphicon-euro"></span>
                <span class="title"><g:message code="place.show.tabs.prices"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#events">
                <span class="glyphicon glyphicon-plane"></span>
                <span class="title"><g:message code="place.show.tabs.events"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#photos">
                <span class="glyphicon glyphicon-picture"></span>
                <span class="title"><g:message code="place.show.tabs.photos"/></span>
            </a></li>
        </ul>
    </div>
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
</div>

<div class="tab-content">
    <!-- LOCALISATION OF THE OBJECT  !-->
    <div id="localisation" class="tab-pane fade in active">
        <g:render template="tabs/tabs_localisation" model="[place:place]"/>
    </div>

    <!-- CONTACT WITH THE OWNER OF OBJECT  !-->
    <div id="contact" class="tab-pane fade">
        <g:render template="tabs/tabs_contact" model="[place:place]"/>
    </div>

    <!-- PRICES (MENU) OF THE ATTRACTIONS  !-->
    <div id="prices" class="tab-pane fade">
        <g:render template="tabs/tabs_prices" model="[place:place]"/>
    </div>

    <!-- EVENTS BOUNDED WITH THE OBJECT !-->
    <div id="events" class="tab-pane fade">
        <g:render template="tabs/tabs_events" model="[place:place]"/>
    </div>

    <!-- USERS PHOTOS WITH THE OBJECT !-->
    <div id="photos" class="tab-pane fade">
     <g:render template="tabs/tabs_photos" model="[place:place]"/>
    </div>
</div>
