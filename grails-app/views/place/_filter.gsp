<button type="button" data-toggle="collapse" data-target="#filterCollapse" aria-expanded="false">
    <g:message code="custom.filterCollapse" default="Show/hide filter"/>
</button>
<div class="collapse" id="filterCollapse">
    <g:form action="index" controller="place">
        <g:message code="placeList.created.after" default="Created after"/>
        <input id="datetimepicker1" type="text" name="timeAfter">
        <g:message code="placeList.created.before" default="before"/>
        <input id="datetimepicker2" type="text" name="timeBefore">
        <g:message code="placeList.name" default="Name"/>
        <input id="name" type="text" name="name">
        <g:message code="placeList.type" default="Type"/>
        <input id="type" type="text" name="type">
        <g:message code="placeList.town" default="Town"/>
        <input id="town" type="text" name="town">
        <g:message code="placeList.distance" default="Distance"/>
        <input id="distance" type="text" name="distance">
        <script>
            $('#datetimepicker1').datetimepicker();
            $('#datetimepicker2').datetimepicker();
        </script>
        <g:submitButton name="index" class="save" value="${message(code: 'custom.filter', default: 'Filter')}" />
    </g:form>
</div>