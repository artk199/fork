<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>${placeType.tag}</title>
    </head>
    <body>
        <sec:ifLoggedIn>
            <permission:hasAccess displayNoPermInfo="true">
            <div id="show-placeType" class="content scaffold-show" role="main">
                <h2>${placeType.tag}</h2>
                <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
                </g:if>

                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <div class="panel panel-primary text-left">
                            <div class="panel-heading">
                                <span class="glyphicon glyphicon-certificate"></span>
                                ${placeType.tag}

                                <g:form resource="${this.placeType}" method="DELETE" class="pull-right">
                                    <fieldset class="buttons">
                                        <a href="/placeType/edit/${placeType.id}">
                                            <span class="glyphicon glyphicon-edit"></span>
                                            <g:message code="default.link.edit"/>
                                        </a>
                                        <label for="delete-placeType">
                                            <span class="glyphicon glyphicon-remove"></span>
                                            <g:message code="default.link.delete"/>
                                        </label>
                                        <input id="delete-placeType" class="hidden" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                    </fieldset>
                                </g:form>
                            </div>
                            <div class="panel-body">
                                <div class="well well-sm">
                                    <p>${placeType.description}</p>
                                </div>
                            </div>

                            <g:if test="${placeType.places?.size() > 0}">
                                <!-- SHOW ELEMENTS FOR THIS PRICING !-->
                                <table class="table table-striped sortable">
                                    <caption>
                                        <g:message code="placeType.show.places"/>
                                        <span class="pull-right">
                                            <span class="glyphicon glyphicon-th"></span>
                                            <g:message code="default.count" args="[placeType.places?.size()]" />
                                        </span>
                                    </caption>
                                    <thead>
                                    <tr>
                                        <th class='col-md-4 col-sm-4 col-xs-4' data-defaultsort="asc" data-firstsort="desc">
                                            <span class="glyphicon glyphicon-map-marker"></span>
                                            <g:message code="placeType.show.place"/>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${placeType.places}" var="place" >
                                        <tr>
                                            <td class='col-md-4 col-sm-4 col-xs-4'>
                                                <a href="/place/show/${place.id}">${place.name}</a>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                            <g:else>
                                <p style="margin-left:20px;">
                                    <g:message code="placeType.show.noPlaces"/>
                                </p>
                            </g:else>

                            <div class="panel-footer buttons">
                                <a href="/placeType/" class="save btn btn-default">
                                    <span class="glyphicon glyphicon-step-backward"></span>
                                    <g:message code="placeType.show.all"/>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>
            </div>
        </permission:hasAccess>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <g:render template="../noPermissions"/>
    </sec:ifNotLoggedIn>
    </body>
</html>
