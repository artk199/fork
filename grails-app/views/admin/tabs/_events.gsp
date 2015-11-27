<!-- LIST OF ALL ADDED EVENTS !-->
<div class="page-section" id="events-all-events">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.events.header"/></h3>
            <g:if test="${pl.fork.event.Event.list()?.size() == 0}">
                <p>
                    <g:message code="admin.tabs.events.noEvents"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable" id="all-places-table">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <g:message code="default.count" args="[pl.fork.event.Event.list()?.size()]" />
                        </span>
                    </caption>
                    <thead>
                    <tr>
                        <th class='col-md-2 col-sm-2 col-xs-2' data-defaultsort="asc" data-firstsort="desc">
                            <span class="glyphicon glyphicon-list-alt"></span>
                            <g:message code="admin.tabs.events.title"/>
                        </th>
                        <th class='col-md-4 col-sm-4 col-xs-4'>
                            <span class="glyphicon glyphicon-comment"></span>
                            <g:message code="admin.tabs.events.description"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <g:message code="admin.tabs.events.place"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-calendar"></span>
                            <g:message code="admin.tabs.events.startDate"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-calendar"></span>
                            <g:message code="admin.tabs.events.endDate"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.event.Event.list()}" var="event" >
                        <tr>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <g:link controller="event" action="show" id="${event.id}">
                                    ${event.title}
                                </g:link>
                                <g:link controller="event" action="edit" id="${event.id}">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <g:message code="default.link.edit"/>
                                </g:link>
                            </td>
                            <td class='col-md-4 col-sm-4 col-xs-4'>
                                ${event.description}
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <g:link controller="place" action="show" id="${event.place.id}">
                                    ${event.place.name}
                                </g:link>
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                ${event.startDate}
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                ${event.endDate}
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:else>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>