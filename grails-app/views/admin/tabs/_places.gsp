<%@ page import="pl.fork.place.Place" %>

<div class="buttons page-section text-left">
    <div class="dropdown pull-left" style="margin:0 10px;">
        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <span class="glyphicon glyphicon-share-alt"></span>
            <g:message code="admin.goToSection"/>
            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <li><a href="#places-added-by-users"><g:message code="admin.tabs.places.addedByUser"/></a></li>
            <li><a href="#places-all-places"><g:message code="admin.tabs.places.allPlaces"/></a></li>
        </ul>
    </div>
    <a href="/place/create" class="btn btn-default" >
        <span class="glyphicon glyphicon-plus"></span>
        <g:message code="place.add" />
    </a>
</div>

<!-- LIST OF ADDED PLACES BY USERS !-->
<div class="page-section dark-section" id="places-added-by-users">
    <h3><g:message code="admin.tabs.places.addedByUser"/></h3>

    <g:if test="${true}">
        <g:message code="admin.tabs.places.noAddedByUser"/>
    </g:if>
    <g:else>
        <table class="table table-striped text-left sortable">
            <caption>
                <span class="pull-right">
                    <span class="glyphicon glyphicon-th"></span>
                    <g:message code="default.count" args="[0]" />
                </span>
            </caption>
            <thead>
            <tr>
                <th class='col-md-3 col-sm-3 col-xs-3' data-defaultsort="asc" data-firstsort="desc">
                    <span class="glyphicon glyphicon-list-alt"></span>
                    <g:message code="admin.tabs.places.name"/>
                </th>
                <th class='col-md-5 col-sm-5 col-xs-5'>
                    <span class="glyphicon glyphicon-comment"></span>
                    <g:message code="admin.tabs.places.description"/>
                </th>
                <th class='col-md-2 col-sm-2 col-xs-2'>
                    <span class="glyphicon glyphicon-map-marker"></span>
                    <g:message code="admin.tabs.places.wholeAddress"/>
                </th>
                <th class='col-md-2 col-sm-2 col-xs-2'>
                    <span class="glyphicon glyphicon-user"></span>
                    <g:message code="admin.tabs.places.user"/>
                </th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </g:else>
</div>

<!-- LIST OF ALL ADDED PLACES !-->
<div class="page-section" id="places-all-places">
    <h3><g:message code="admin.tabs.places.allPlaces"/></h3>

    <g:if test="${pl.fork.place.Place.list().size == 0}">
        <p>
            <g:message code="admin.tabs.places.noPlaces"/>
        </p>
    </g:if>
    <g:else>
        <table class="table table-striped text-left sortable">
            <caption>
                <span class="pull-right">
                    <span class="glyphicon glyphicon-th"></span>
                    <g:message code="default.count" args="[pl.fork.place.Place.list().size]" />
                </span>
            </caption>
            <thead>
            <tr>
                <th class='col-md-3 col-sm-3 col-xs-3' data-defaultsort="asc" data-firstsort="desc">
                    <span class="glyphicon glyphicon-list-alt"></span>
                    <g:message code="admin.tabs.places.name"/>
                </th>
                <th class='col-md-5 col-sm-5 col-xs-5'>
                    <span class="glyphicon glyphicon-comment"></span>
                    <g:message code="admin.tabs.places.description"/>
                </th>
                <th class='col-md-2 col-sm-2 col-xs-2'>
                    <span class="glyphicon glyphicon-map-marker"></span>
                    <g:message code="admin.tabs.places.town"/>
                </th>
                <th class='col-md-2 col-sm-2 col-xs-2'>
                    <span class="glyphicon glyphicon-road"></span>
                    <g:message code="admin.tabs.places.address"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${pl.fork.place.Place.list()}" var="place" >
                <tr>
                    <td class='col-md-3 col-sm-3 col-xs-3'>
                        <a href="/place/show/${place.id}">
                            ${place.name}
                        </a>

                        <div class="pull-right">
                            <a href="/place/edit/${place.id}">
                                <span class="glyphicon glyphicon-edit"></span>
                                <g:message code="default.link.edit"/>
                            </a>
                        </div>
                    </td>
                    <td class='col-md-5 col-sm-5 col-xs-5'>${place.description}</td>
                    <td class='col-md-2 col-sm-2 col-xs-2'>
                        <g:if test="${place.town}">
                            ${place.town}
                        </g:if>
                        <g:else>
                            <g:message code="admin.empty"/>
                        </g:else>
                    </td>
                    <td class='col-md-2 col-sm-2 col-xs-2'>
                        <g:if test="${place.address}">
                            ${place.address}
                        </g:if>
                        <g:else>
                            <g:message code="admin.empty"/>
                        </g:else>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <%--
        <div class="pagination">
            <g:paginate total="${pl.fork.place.Place.list().size() ?: 0}" />
        </div>--%>
    </g:else>
</div>