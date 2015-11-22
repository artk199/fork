<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'place.label', default: 'Place')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
    <div id="show-place">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">
                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12" style="min-height:300px;">
                        <h1>${this.place.town} - ${this.place.name}</h1>
                        <div class="row">
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <g:if test="${this.place.images.size() > 0 }">
                                    <img src="${g.createLink(absolute:true,uri:'/image/'+this.place.images[0].id)}" class="img-responsive">
                                </g:if>
                                <g:else>
                                    <img src="http://www.parentcenterhub.org/wp-content/uploads/2014/03/No-Image-.jpg">
                                </g:else>
                            </div>

                            <div class="col-md-8 col-sm-6 col-xs-12">
                                <p class="text-left">
                                    ${this.place.description}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div class="row page-section blue-section">
            <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                <g:render template="tabs" model="[place:place]"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="scores" model="[place:place, score:score]"/>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </div>
</body>
</html>