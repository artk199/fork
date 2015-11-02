<div class="row">
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-10 col-xs-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#localisation">
                <g:img  file="logo.png"/>
                <span><g:message code="place.show.tabs.localisation"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#contact">
                <g:img  file="logo.png"/>
                <span><g:message code="place.show.tabs.contact"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#prices">
                <g:img  file="logo.png"/>
                <span><g:message code="place.show.tabs.prices"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#events">
                <g:img  file="logo.png"/>
                <span><g:message code="place.show.tabs.events"/></span>
            </a></li>
            <li><a data-toggle="tab" href="#photos">
                <g:img  file="logo.png"/>
                <span><g:message code="place.show.tabs.photos"/></span>
            </a></li>
        </ul>
    </div>
    <div class="col-md-2 col-sm-1 hidden-xs"></div>
</div>

<div class="tab-content">
    <!-- LOCALISATION OF THE OBJECT  !-->
    <div id="localisation" class="tab-pane fade in active">
        <div class="row">
            <div class="col-md-1 col-sm-1 hidden-xs"></div>
            <div class="col-md-10 col-sm-10 col-xs-12">
                <div class="localisation-info">
                    <g:img  file="logo.png"/>
                    <span><strong><g:message code="place.show.localisation.city"/>${this.place.town}</span>
                </div>
                <div class="localisation-info">
                    <g:img  file="logo.png"/>
                    <span><strong><g:message code="place.show.localisation.address"/>${this.place.address}</span>
                </div>
            </div>
            <div class="col-md-1 col-sm-1 hidden-xs"></div>
        </div>
        <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCQcP1mIycA9POYLolLblZeqc3dLG9iVjQ&q={${this.place.town},${this.place.address}"></iframe>
    </div>
    <!-- CONTACT WITH THE OWNER OF OBJECT  !-->
    <div id="contact" class="tab-pane fade">
       <p>contact</p>
    </div>

    <!-- PRICES (MENU) OF THE ATTRACTIONS  !-->
    <div id="prices" class="tab-pane fade">
        <p>prices</p>
    </div>

    <!-- EVENTS BOUNDED WITH THE OBJECT !-->
    <div id="events" class="tab-pane fade">
        <p>events</p>
    </div>

    <!-- USERS PHOTOS WITH THE OBJECT !-->
    <div id="photos" class="tab-pane fade">
        <p>photos</p>
    </div>
</div>
