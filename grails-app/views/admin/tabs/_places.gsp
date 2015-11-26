<%@ page import="pl.fork.place.Place" %>

<!-- BUTTONS !-->
<div class="buttons page-section">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
            <div class="btn-group" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-place" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        <span class="glyphicon glyphicon-share-alt"></span>
                        <g:message code="admin.goToSection"/>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdown-place">
                        <li><a href="#places-added-by-users"><g:message code="admin.tabs.places.addedByUser"/></a></li>
                        <li><a href="#places-search-place"><g:message code="admin.tabs.places.find"/></a></li>
                        <li><a href="#places-all-places"><g:message code="admin.tabs.places.allPlaces"/></a></li>
                    </ul>
                </div>

                <button class="btn btn-default" type="button">
                    <a href="/place/create">
                        <span class="glyphicon glyphicon-plus"></span>
                        <g:message code="place.add" />
                    </a>
                </button>
                <button class="btn btn-default" type="button">
                    <a href="/placeType/create">
                        <span class="glyphicon glyphicon-plus"></span>
                        <g:message code="placeType.add.new" />
                    </a>
                </button>
            </div>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>

<!-- LIST OF ADDED PLACES BY USERS !-->
<div class="page-section" id="places-added-by-users">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.places.addedByUser"/></h3>

            <g:if test="${pendingPlaces.size() == 0}">
                <p>
                    <g:message code="admin.tabs.places.noAddedByUser"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <g:message code="default.count" args="[pendingPlaces.size()]" />
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
                        <g:each in="${pendingPlaces}" var="place" >
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
                                        <g:message code="default.input.empty"/>
                                    </g:else>
                                </td>
                                <td class='col-md-2 col-sm-2 col-xs-2'>
                                    <g:if test="${place.address}">
                                        ${place.address}
                                    </g:if>
                                    <g:else>
                                        <g:message code="default.input.empty"/>
                                    </g:else>
                                </td>
                                <td>
                                    <g:set var="sendPlace" value="[placeId: place.id]" />
                                    <a class="btn btn-default"
                                       href="${g.createLink(controller:'admin',action:'rejectPlace', params:sendPlace)}">
                                        <span class='glyphicon glyphicon-remove-sign'></span>
                                        <span><g:message code="admin.tabs.photos.reject"/></span>
                                    </a>
                                    <a class="btn btn-default"
                                       href="${g.createLink(controller:'admin',action:'acceptPlace', params:sendPlace)}">
                                        <span class='glyphicon glyphicon-ok-sign'></span>
                                        <span><g:message code="admin.tabs.photos.accept"/></span>
                                    </a>
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

<!-- SEARCH FOR A PLACE !-->
<script type="text/javascript">
    $(document).ready(function() {
        $('#types').multiselect({
            enableFiltering: true,
            enableCaseInsensitiveFiltering: true,
            buttonWidth: '100%',
            buttonClass: 'text-left btn btn-default',
            includeSelectAllOption: true,
            maxHeight: 400,
            nonSelectedText: '${g.message(code:'placeList.type', default:'Type')}',
            nSelectedText: '${g.message(code:'default.input.multiselect.tooMany')}',
            allSelectedText: '${g.message(code:'default.input.multiselect.all')}',
            selectAllText: '${g.message(code:'default.input.multiselect.selectAll')}',
            filterPlaceholder: '${g.message(code:'default.input.multiselect.search')}'
        });
    });
</script>

<div class="page-section blue-section" id="places-search-place">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11 text-right">
            <h3 class="text-center"><g:message code="admin.tabs.places.find"/></h3>

            <g:form id="findPlace" action="findPlace" controller="admin" class="form-horizontal admin-findPlace-form" enctype="multipart/form-data" >
                <g:set var="ajaxFunction" value="getPlacesFromController('${g.createLink(controller:'admin',action:'findPlace')}', 'all-places-table')" />
                <div class="form-group row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <input id="name" type="text" name="name" class="form-control" placeholder="${g.message(code:'placeList.name', default:'Name')}"
                          oninput="${ajaxFunction}">
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <input id="town" type="text" name="town" class="form-control" placeholder="${g.message(code:'placeList.town', default:'Town')}"
                        oninput="${ajaxFunction}">
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <input id="address" type="text" name="address" class="form-control" placeholder="${g.message(code:'placeList.address', default:'Address')}"
                         oninput="${ajaxFunction}">
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <g:select name="types" id="types" from="${pl.fork.place.PlaceType.list()}"
                                  optionValue="tag" class="form-control" multiple="multiple"
                                  optionKey="id"
                        />
                    </div>
                </div>

                <div class="buttons">
                    <a class="btn btn-primary" onclick="${ajaxFunction}">
                        <span class="glyphicon glyphicon-search"></span>
                        <g:message code="admin.search"/>
                    </a>
                </div>
            </g:form>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>

<!-- LIST OF ALL ADDED PLACES !-->
<div class="page-section" id="places-all-places">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.places.allPlaces"/></h3>
            <g:if test="${pl.fork.place.Place.list().size == 0}">
                <p>
                    <g:message code="admin.tabs.places.noPlaces"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable" id="all-places-table">
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
                                    <g:message code="default.input.empty"/>
                                </g:else>
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <g:if test="${place.address}">
                                    ${place.address}
                                </g:if>
                                <g:else>
                                    <g:message code="default.input.empty"/>
                                </g:else>
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