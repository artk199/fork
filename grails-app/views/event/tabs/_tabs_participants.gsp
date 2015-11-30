<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        Lista zapisanych uczestników wydarzenia
        <br>
        <g:each var="participant" in="${event.participants}">
            <p>
                <span class="glyphicon glyphicon-user"></span>
                <g:link controller="user" action="show" id="${participant.id}">
                    ${participant.username}
                </g:link>
            </p>
        </g:each>
        <sec:ifLoggedIn>
            <g:if test="${!signedUser}">
                <g:link action="join" resource="${event}" class="btn btn-default btn-block" ><g:message code="event.join" /></g:link>
            </g:if>
            <g:if test="${signedUser}">
                <g:link action="unjoin" resource="${event}" class="btn btn-default btn-block" ><g:message code="event.unjoin" /></g:link>
            </g:if>
        </sec:ifLoggedIn>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>