<div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
<div class="col-md-8 col-sm-8 col-xs-11 text-left">
    <h2>
        <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
        <g:message code="place.show.events.header"/>
    </h2>
    <g:if test="${!place.events || place.events.size() == 0}">
        <p><g:message code="place.show.events.noEvents" args="['/event/create']"/></p>
    </g:if>
    <g:else>
        <div class="row">
            <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                <div class="col-md-8 col-sm-8 col-xs-11">
                    <g:if test="${place && place.events}">
                        <table class="table table-striped text-left sortable">
                            <caption>
                                <span class="pull-right">
                                    <span class="glyphicon glyphicon-th"></span>
                                    <g:message code="default.count" args="[place.events.size()]" />
                                </span>
                            </caption>
                            <thead>
                            <tr>
                                <th class='col-md-2 col-sm-2 col-xs-2'>
                                    <g:message code="event.title"/>
                                </th>
                                <th class='col-md-2 col-sm-2 col-xs-2' data-defaultsort="asc" data-firstsort="desc">
                                    <g:message code="custom.description"/>
                                </th>
                                <th class='col-md-5 col-sm-5 col-xs-5'>
                                    <g:message code="event.startDate"/>
                                </th>
                                <th class='col-md-2 col-sm-2 col-xs-2'>
                                    <g:message code="event.endDate"/>
                                </th>
                                <th class='col-md-2 col-sm-2 col-xs-2'>
                                    <g:message code="event.participants.counter"/>
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${place.events}" var="event" >
                                <tr>
                                    <td class='col-md-2 col-sm-2 col-xs-2'>
                                        <a href="/event/show/${event.id}">
                                            ${event.title}
                                        </a>
                                    </td>
                                    <td class='col-md-2 col-sm-2 col-xs-2'>
                                        ${event.description}
                                    </td>
                                    <td class='col-md-2 col-sm-2 col-xs-2'>
                                        ${event.startDate}
                                    </td>
                                    <td class='col-md-1 col-sm-1 col-xs-1'>
                                        ${event.endDate}
                                    </td>
                                    <td class='col-md-1 col-sm-1 col-xs-1'>
                                        ${event.participants.size()}
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                </div>
            </div>
        </g:else>
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.events.createNew"/>
        </h2>
    </div>
</div>
<div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>