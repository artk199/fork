<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="show-pricing" class="content scaffold-show" role="main">
            <h2>
                <a href="/place/show/${pricing.place.id}">
                    ${pricing.place.name}
                </a>
                -
                ${pricing.title}
            </h2>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <div class="text-left row">
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                    <div class="panel panel-primary text-left">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-list-alt"></span>
                            ${pricing.title}

                            <g:form resource="${this.pricing}" method="DELETE" class="pull-right">
                                <fieldset class="buttons">
                                    <a href="/pricing/edit/${pricing.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                    <label for="delete-pricing">
                                        <span class="glyphicon glyphicon-remove"></span>
                                        <g:message code="default.link.delete"/>
                                    </label>
                                    <input id="delete-pricing" class="hidden" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                </fieldset>
                            </g:form>
                        </div>
                        <div class="panel-body">
                            <p style="margin-left:10px;">
                                <strong>
                                    <span class="glyphicon glyphicon-map-marker"></span>
                                    <g:message code="pricing.place"/>
                                </strong>
                                <a href="/place/show/${pricing.place.id}">
                                    ${pricing.place.name}
                                </a>
                            </p>

                            <div class="well well-sm">
                                <p>${pricing.description}</p>
                            </div>
                        </div>

                        <g:if test="${pricing.elements.size() > 0}">
                            <!-- SHOW ELEMENTS FOR THIS PRICING !-->
                            <table class="table table-striped sortable">
                                <caption><g:message code="place.show.pricing.elements"/></caption>
                                <thead>
                                <tr>
                                    <th class='col-md-4 col-sm-4 col-xs-4' data-defaultsort="asc" data-firstsort="desc">
                                        <span class="glyphicon glyphicon-th-large"></span>
                                        <g:message code="pricing.element.name"/>
                                    </th>
                                    <th class='col-md-4 col-sm-4 col-xs-4'>
                                        <span class="glyphicon glyphicon-comment"></span>
                                        <g:message code="pricing.element.description"/>
                                    </th>
                                    <th class='col-md-1 col-sm-1 col-xs-1'>
                                        <span class="glyphicon glyphicon-euro pull-left"></span>
                                        <g:message code="pricing.element.price"/>
                                    </th>
                                    <th class='col-md-2 col-sm-2 col-xs-2' data-defaultsort='disabled'>
                                        <span class="glyphicon glyphicon-wrench"></span>
                                        <g:message code="pricing.options"/>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${pricing.elements}" var="element" >
                                    <tr>
                                        <td class='col-md-4 col-sm-4 col-xs-4'>
                                            <a href="/pricedElement/show/${element.id}">${element.name}</a>
                                        </td>
                                        <td class='col-md-5 col-sm-5 col-xs-5'>${element.description}</td>
                                        <td class='col-md-1 col-sm-1 col-xs-1'>${element.price}</td>
                                        <td class='col-md-2 col-sm-2 col-xs-2'>
                                            <g:form resource="${element}" method="DELETE" >
                                                <fieldset class="buttons">
                                                    <a href="/pricedElement/edit/${element.id}">
                                                        <span class="glyphicon glyphicon-edit"></span>
                                                        <g:message code="default.link.edit"/>
                                                    </a>
                                                    <label for="delete-element">
                                                        <span class="glyphicon glyphicon-remove"></span>
                                                        <g:message code="default.link.delete"/>
                                                    </label>
                                                    <input id="delete-element" class="hidden" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                                </fieldset>
                                            </g:form>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </g:if>
                        <g:else>
                            <p style="margin-left:20px;">
                                <g:message code="pricing.noElements"/>
                            </p>
                        </g:else>

                        <div class="panel-footer buttons">
                           <a href="/pricedElement/create?pricing.id=${pricing.id}" class="save btn btn-default">
                               <span class="glyphicon glyphicon-plus"></span>
                               <g:message code="pricing.element.add.new"/>
                           </a>
                            <a href="/pricing/" class="save btn btn-default">
                                <span class="glyphicon glyphicon-step-backward"></span>
                                <g:message code="pricing.showAll"/>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
            </div>
        </div>
    </body>
</html>
