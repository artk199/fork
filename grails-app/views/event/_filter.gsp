
    <g:form action="index" controller="event">

        <div class="row fork-filter-input-container">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input id="title" type="text" name="title"  placeholder="${g.message(code:'event.title', default:'Title')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input filter-date type="text" name="timeAfter" placeholder="${g.message(code:'placeList.created.after', default:'Is being after')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input filter-date type="text" name="timeBefore" placeholder="${g.message(code:'placeList.created.before', default:'Is being before')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input id="distance" type="text" name="distance" placeholder="${g.message(code:'placeList.distance', default:'Distance')}">
            </div>
        </div>







        <g:submitButton name="index" class="save" value="${message(code: 'custom.filter', default: 'Filter')}" />

    </g:form>