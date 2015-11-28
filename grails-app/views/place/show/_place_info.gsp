<div class="row">
    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
        <h1 class='text-left place-title'>
            <span class="glyphicon glyphicon-tags"></span>
            <g:if test="${this.place.town}">${this.place.town} - </g:if> ${this.place.name}

            <sec:ifLoggedIn>
                <g:if test="${(g.currentUserID().toInteger() == this.place.owner?.id)}">
                    <div class="edit-options">
                        <a href="/place/edit/${place.id}">
                            <span class="glyphicon glyphicon-edit"></span>
                            <span><g:message code="default.link.edit"/></span>
                        </a>
                    </div>
                </g:if>
            </sec:ifLoggedIn>
        </h1>
        <div class="row">
            <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 20px;">
                <g:if test="${this.place.mainImage }">
                    <img src="${g.createLink(absolute:true,uri:'/image/'+this.place.mainImage.id)}" class="img-responsive">
                </g:if>
                <g:else>
                    <img src="/assets/no-image.jpg" class="img-responsive">
                </g:else>
            </div>

            <div class="col-md-8 col-sm-6 col-xs-12">
                <p class="place-rating">
                    <span class="glyphicon glyphicon-star" title="${g.message(code:'place.show.scores')}"></span>
                    <span title="${g.message(code:'place.show.scores')}">
                        ${Math.round((this.place.avgScore >=0 ? this.place.avgScore : 0.0) * 10) / 10}/5
                    </span>
                    <span class="summary-count">
                        <g:message code="place.show.scoresNumber" args="[this.place.scores ? this.place.scores.size() : 0]"/>
                    </span>
                </p>
                <p class="text-left">
                    ${this.place.description}
                </p>
                <p class="text-left">
                    <strong><g:message code="place.show.types"/></strong>
                    <g:if test="${(place.types?.size()) > 0}">
                        <g:each in="${place.types}" var="type">
                            <%--<a href="/place/index?types=${type.id}">${type.tag}</a> // list is not displaying those types, idk why---%>
                            ${type.tag}${type.id != place.types.last().id ? ',' : ""}
                        </g:each>
                    </g:if>
                    <g:else>
                        <span><g:message code="place.show.noType"/></span>
                    </g:else>
                </p>
            </div>
        </div>
    </div>
</div>