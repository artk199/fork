<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        Lista zapisanych uczestników wydarzenia:
        <g:if test="${event.participants?.size() == 0}">
            <g:message code="event.participants.empty"/>
        </g:if>
        <br/>
        <g:each var="participant" in="${event.participants}">
            <p>
                <span class="glyphicon glyphicon-user"></span>
                <g:link controller="user" action="show" id="${participant.id}">
                    ${participant.username}
                </g:link>
            </p>
        </g:each>
        <sec:ifLoggedIn>
            <div class="buttons">
                <g:if test="${!signedUser}">
                    <g:link action="join" resource="${event}" class="btn btn-default" >
                        <span class="glyphicon glyphicon-plus-sign"></span>
                        <g:message code="event.join.text" />
                    </g:link>
                </g:if>
                <g:if test="${signedUser}">
                    <g:link action="unjoin" resource="${event}" class="btn btn-default" >
                        <span class="glyphicon glyphicon-minus-sign"></span>
                        <g:message code="event.leave.text" />
                    </g:link>
                </g:if>
            </div>
        </sec:ifLoggedIn>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>