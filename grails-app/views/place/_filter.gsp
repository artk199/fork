
    <g:form action="index" controller="place">

        <div class="row fork-filter-input-container">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input id="name" type="text" name="name"  placeholder="${g.message(code:'placeList.name', default:'Name')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <g:select name="types" id="types" from="${pl.fork.place.PlaceType.list()}"
                          optionValue="tag" class="form-control" multiple="multiple"
                          optionKey="id"
                />
                <%--<input id="type" type="text" name="type" placeholder="${g.message(code:'placeList.type', default:'Type')}">--%>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input id="town" type="text" name="town" placeholder="${g.message(code:'placeList.town', default:'Town')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input filter-date type="text" name="timeAfter" placeholder="${g.message(code:'placeList.created.after', default:'Created after')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input filter-date type="text" name="timeBefore" placeholder="${g.message(code:'placeList.created.before', default:'Created before')}">
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <input id="distance" type="text" name="distance" placeholder="${g.message(code:'placeList.distance', default:'Distance')}">
            </div>
        </div>

        <g:submitButton name="index" class="save" value="${message(code: 'custom.filter', default: 'Filter')}" />


        <%--
             <g:message code="placeList.created.after" default="Created after"/>
            <input id="datetimepicker1" type="text" name="timeAfter">
            <g:message code="placeList.created.before" default="before"/>
            <input id="datetimepicker2" type="text" name="timeBefore">
            <g:message code="placeList.distance" default="Distance"/>
            <input id="distance" type="text" name="distance">

                    <script>
            $('#datetimepicker1').datetimepicker();
            $('#datetimepicker2').datetimepicker();
        </script>

        --%>
    </g:form>