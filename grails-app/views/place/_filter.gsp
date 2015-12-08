<script type="text/javascript">
    $(document).ready(function() {
        $('#types2').multiselect({
            enableFiltering: true,
            enableCaseInsensitiveFiltering: true,
            buttonWidth: '100%',
            buttonClass: 'text-left btn btn-default',
            includeSelectAllOption: true,
            maxHeight: 400,
            nonSelectedText: '${g.message(code:'placeList.type', default:'Type')}',
            nSelectedText: '${g.message(code:'default.input.multiselect.tooMany')}',
            allSelectedText: '${g.message(code:'default.input.multiselect.all')}',
            selectAllText: '${g.message(code:'default.input.multiselect.selectAll')}',
            filterPlaceholder: '${g.message(code:'default.input.multiselect.search')}'
         });
    });
</script>

<div class="fork-filter-input-container panel text-left" style="background: none">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-search"></span>
        <g:message code="place.search.filter.header"/>
    </div>
    <div class="panel-body">
        <form action="index" method="get" dynamic-filtering>
            <div class="form-group">
                <input id="name" type="text" name="name" class="form-control" placeholder="${g.message(code:'placeList.name', default:'Name')}">
            </div>
            <div class="form-group" id="place-type">
                <g:select name="types" id="types" from="${pl.fork.place.PlaceType.list()}"
                          optionValue="tag" class="form-control" multiple="multiple"
                          optionKey="id"
                />
                <span style="font-size:9px;"><em><g:message code="default.multiselect.info"/></em></span>
            </div>
            <div class="form-group">
                <input id="town" type="text" name="town" class="form-control" placeholder="${g.message(code:'placeList.town', default:'Town')}">
            </div>

            <div class="buttons">
                <label for="index" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span>
                    <g:message code="custom.filter"/>
                </label>
                <g:submitButton id="index" name="index" class="save" class="hidden"/>
            </div>
        </form>
    </div>
</div>

<sec:ifLoggedIn>
<div class="fork-filter-input-container panel text-left" style="background: none">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-info-sign"></span>
        <g:message code="place.search.options.header"/>
    </div>
    <div class="panel-body">
        <g:link action="create" class="btn btn-default btn-block" >
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="place.add" />
        </g:link>

        <sec:ifAllGranted roles="ROLE_ADMIN">
        <a href="placeType/create" class="btn btn-default btn-block" >
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="placeType.add.new" />
        </a>
        </sec:ifAllGranted>
    </div>
</div>
</sec:ifLoggedIn>