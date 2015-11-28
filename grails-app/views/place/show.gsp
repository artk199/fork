<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>${this.place.town ? this.place.town + " - " : ""}${this.place.name}</title>
</head>
<body>
    <g:set var="isOwner"
           value = "${(g.currentUserID().toInteger() == this.place.owner?.id)}"
    />
    <g:set var="isAdmin" value = "${false}"/>
    <g:set var="hasPlaceEditPermissions" value = "${isOwner || isAdmin}"/>
    <div id="show-place">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="show/place_info" model="[place:place]"/>
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
                <g:render template="show/scores" model="[place:place, score:score]"/>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </div>
</body>
</html>