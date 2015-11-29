<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.contact.contactData"/>
        </h2>
        <p>
            <span class="glyphicon glyphicon-phone"></span>
            <span>
                <strong><g:message code="place.show.contact.phone"/></strong>
                ${this.place.phone ? this.place.phone : message(code:"default.input.empty")}
            </span>
        </p>
        <p>
            <span class="glyphicon glyphicon-envelope"></span>
            <span>
                <strong><g:message code="place.show.contact.email"/></strong>
                ${this.place.email ? this.place.email : message(code:"default.input.empty")}
            </span>
        </p>
        <p>
            <span class="glyphicon glyphicon-home"></span>
            <span>
                <strong><g:message code="place.show.contact.website"/></strong>
                <g:if test="${this.place.website}">
                    <a href="${this.place.website}">${this.place.website}</a>
                </g:if>
                <g:else>
                    <g:message code="default.input.empty"/>
                </g:else>
            </span>
        </p>
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.contact.contactToOwner"/>
        </h2>
        <g:if test="${this.place.owner && this.place.administratorStatus.toString() == 'APPROVED'}">
            <p><g:message code="place.show.contact.owner"/></p>
            <g:set var="place_owner" value="${this.place.owner}"/>
            <p>
                <span class="glyphicon glyphicon-user"></span>
                <g:link controller="user" action="show" id="${place_owner.id}">
                    ${place_owner.username}
                </g:link>
            </p>
            <g:if test="${place_owner.firstName && place_owner.lastName}">
                <p>
                    <span class="glyphicon glyphicon-object-align-left"></span>
                    <span><g:message code="place.show.contact.owner.firstAndLastName"/></span>
                    ${place_owner.firstName} ${place_owner.lastName}
                </p>
            </g:if>
            <g:if test="${place_owner.town && place_owner.address}">
                <p>
                    <span class="glyphicon glyphicon-map-marker"></span>
                    <span><g:message code="place.show.contact.owner.address"/></span>
                    ${place_owner.town}, ${place_owner.address}
                </p>
            </g:if>
        </g:if>
        <g:elseif test="${this.place.owner && this.place.administratorStatus.toString() == 'PENDING'}">
            <p>${g.message(code:"place.show.contact.pending")}</p>
        </g:elseif>
        <g:else>
            <p><g:message code="place.show.contact.noOwner.notLogged"/></p>
            <sec:ifLoggedIn>
                <p>${g.message(code:"place.show.contact.noOwner", args:["/place/registerOwner/"+this.place.id])}</p>
            </sec:ifLoggedIn>
        </g:else>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>