<%@ page import="pl.fork.place.PlaceType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'placeType.label', default: 'PlaceType')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-placeType" class="content scaffold-list" role="main">
            <h1><g:message code="placeType.header.all"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:if test="${pl.fork.place.PlaceType.list().size() == 0}">
                <p>
                    <g:message code="placeType.noTypes"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable">
                    <thead>
                    <tr>
                        <th class='col-md-3 col-sm-3 col-xs-3' data-defaultsort="asc" data-firstsort="desc">
                            <span class="glyphicon glyphicon-certificate"></span>
                            <g:message code="placeType.tag"/>
                        </th>
                        <th class='col-md-5 col-sm-5 col-xs-5'>
                            <span class="glyphicon glyphicon-comment"></span>
                            <g:message code="placeType.description"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <g:message code="placeType.places"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.place.PlaceType.list()}" var="type" >
                        <tr>
                            <td class='col-md-3 col-sm-3 col-xs-3'>
                                <a href="/placeType/show/${type.id}">
                                    ${type.tag}
                                </a>

                                <div class="pull-right">
                                    <a href="/placeType/edit/${type.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                </div>
                            </td>
                            <td class='col-md-5 col-sm-5 col-xs-5'>${type.description}</td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                ${type.places == null ? '0' : type.places.size()}
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:else>
            <div class="buttons">
                <a href="/placeType/create" class="save btn btn-default">
                    <span class="glyphicon glyphicon-plus"></span>
                    <g:message code="placeType.add.new"/>
                </a>
            </div>

            <div class="pagination">
                <g:paginate total="${placeTypeCount ?: 0}" />
            </div>
        </div>
    </body>
</html>