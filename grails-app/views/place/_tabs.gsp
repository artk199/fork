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
        <div class="row">
            <div class="col-md-2 col-sm-2 hidden-xs"></div>
            <div class="col-md-8 col-sm-8 col-xs-12 text-left">
                <p>
                    <span class="glyphicon glyphicon-map-marker pull-left"></span>
                    <span><strong><g:message code="place.show.localisation.city"/></strong> ${this.place.town}</span>
                </p>
                <p>
                     <span class="glyphicon glyphicon-road pull-left"></span>
                     <span><strong><g:message code="place.show.localisation.address"/></strong> ${this.place.address}</span>
                </p>

            </div>
            <div class="col-md-2 col-sm-2 hidden-xs"></div>
        </div>
        <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCQcP1mIycA9POYLolLblZeqc3dLG9iVjQ&q={${this.place.town},${this.place.address}"></iframe>
    </div>

    <!-- CONTACT WITH THE OWNER OF OBJECT  !-->
    <div id="contact" class="tab-pane fade">
        <div class="row">
            <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                <h2><span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>Dane kontaktowe</h2>
                <p>
                    <span class="glyphicon glyphicon-phone"></span>
                    <span><strong><g:message code="place.show.contact.phone"/></strong> ${this.place.phone}</span>
                </p>
                <p>
                    <span class="glyphicon glyphicon-envelope"></span>
                    <span><strong><g:message code="place.show.contact.email"/></strong> ${this.place.email}</span>
                </p>
                <p>
                    <span class="glyphicon glyphicon-home"></span>
                    <span><strong><g:message code="place.show.contact.website"/></strong> <a href="${this.place.website}">${this.place.website}</a></span>
                </p>

                <h2><span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>Kontakt z właścicielem</h2>
            </div>
            <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        </div>
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
