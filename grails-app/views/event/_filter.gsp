<div class="fork-filter-input-container panel text-left" style="background: none">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-search"></span>
        <g:message code="place.search.filter.header"/>
    </div>
    <div class="panel-body">
        <g:form action="index" controller="event">
            <div class="form-group">
                <input id="title" type="text" name="title"  class="form-control"  placeholder="${g.message(code:'event.title', default:'Title')}">
            </div>
            <div class="form-group">
                <input filter-date-and-time type="text" name="timeAfter"  class="form-control" placeholder="${g.message(code:'placeList.created.after', default:'Is being after')}">
            </div>
            <div class="form-group">
                <input filter-date-and-time type="text" name="timeBefore" class="form-control"  placeholder="${g.message(code:'placeList.created.before', default:'Is being before')}">
            </div>

            <div class="buttons">
                <label for="index" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span>
                    <g:message code="custom.filter"/>
                </label>
                <g:submitButton id="index" name="index" class="save" class="hidden"/>
            </div>
        </g:form>
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
                <g:message code="event.create" />
            </g:link>
        </div>
    </div>
</sec:ifLoggedIn>

