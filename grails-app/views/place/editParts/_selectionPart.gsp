<div class="form-group">
    <label for="types" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.type" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <g:select name="types" id="types" from="${pl.fork.place.PlaceType.list()}"
                  optionValue="tag" class="form-control" value="${place.types}"
                  optionKey="id" multiple="multiple"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>
<div class="form-group">
    <label for="owner" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.owner" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <g:select name="owner" id="owner" from="${pl.fork.auth.User.list()}"
                  optionValue="username" class="form-control" value="${place.owner?.id}"
                  optionKey="id" noSelection="${['null':message(code:'default.select.noSelection')]}"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="status" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.status" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <g:select name="status" id="status" from="${pl.fork.auth.Status.values()}"
                  class="form-control" value="${place.status}"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="mainImage" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="place.mainImage" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <g:select name="mainImage" id="mainImage" from="${place.images}"
                  optionValue="id" class="form-control" value="${place.mainImage?.id}"
                  optionKey="id" noSelection="${['null':message(code:'default.select.noSelection')]}"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>