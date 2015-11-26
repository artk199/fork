<div class="row">
    <div class="col-md-2 col-sm-2 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-12 text-left">
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.localisation.header"/>
        </h2>
        <p>
            <span class="glyphicon glyphicon-map-marker pull-left"></span>
            <span>
                <strong><g:message code="place.show.localisation.city"/></strong>
                ${this.place.town ? this.place.town : message(code:"default.input.empty")}
            </span>
        </p>
        <p>
            <span class="glyphicon glyphicon-road pull-left"></span>
            <span>
                <strong><g:message code="place.show.localisation.address"/></strong>
                ${this.place.address ? this.place.address : message(code:"default.input.empty")}
            </span>
        </p>
    </div>
    <div class="col-md-2 col-sm-2 hidden-xs"></div>
</div>

<g:if test="${this.place.town && this.place.address}">
    <iframe src='https://www.google.com/maps/embed/v1/place?key=AIzaSyCQcP1mIycA9POYLolLblZeqc3dLG9iVjQ&q=${this.place.town},${this.place.address}'></iframe>
</g:if>