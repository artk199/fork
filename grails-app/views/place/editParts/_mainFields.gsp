<div class="form-group">
    <label for="name" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.name" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="name" id="name" value="${place.name}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="town" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.town" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="town" id="town" value="${place.town}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="address" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.address" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="address" id="address" value="${place.address}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="phone" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.phone" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="phone" id="phone" value="${place.phone}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="email" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.email" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="email" id="email" value="${place.email}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="website" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.website" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input class="form-control" name="website" id="website" value="${place.website}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<%-- CHECK WHY GRAILS CANT PARSE THOSE DOUBLES
<div class="form-group">
    <label for="latidude" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.latitude" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input type="number" class="form-control" name="x" id="latidude" value="${place.x}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="longitude" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.longitude" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input type="number" class="form-control" name="y" id="longitude" value="${place.y}"/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>
--%>

<div class="form-group">
    <label for="description" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.description" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <textarea class="form-control" name="description" id="description" value="${place.description}">${place.description}</textarea>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>