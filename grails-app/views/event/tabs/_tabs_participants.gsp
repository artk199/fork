<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        Lista zapisanych uczestników wydarzenia
        <br>
        <g:each var="participant" in="${event.participants}">
            ${participant.username} <br>
        </g:each>
        <sec:ifLoggedIn>
            <g:link action="join" resource="${event}" class="btn btn-default btn-block" ><g:message code="event.join" /></g:link>
        </sec:ifLoggedIn>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>