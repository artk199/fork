<div class="row" >
    <div class="col-md-12">
        <div style="margin:20px">
            <table class="table table-striped table-bordered fork-table">
                <thead>
                <tr>
                    <th>
                        <span class="glyphicon glyphicon-th-large"></span>
                        <g:message code="user.event.name"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-road"></span>
                        <g:message code="user.event.place"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-time"></span>
                        <g:message code="user.event.date"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-user"></span>
                        <g:message code="user.event.participants.size"/>
                    </th>
                </tr>
                </thead>
                <tbody>
                    <g:each in="${this.user.events}" var="event">
                        <tr onclick="window.location.href='/event/show/${event.id}'">
                            <td class='col-md-4 col-sm-4 col-xs-4'>${event.title}</td>
                            <td class='col-md-6 col-sm-6 col-xs-6'>${event.place.name}</td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>${g.formatDate(date:event.startDate,format:'yyyy-MM-dd')}</td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>${event.participantsAmount}</td>
                        </tr>
                    </g:each>
                    <g:if test="${this.user.events.size() == 0 }">
                        <tr class="inactive">
                            <td colspan="4" class='col-md-4 col-sm-4 col-xs-4'><g:message code="user.event.table.empty"/></td>
                        </tr>
                    </g:if>
                </tbody>
            </table>
        </div>
    </div>
</div>