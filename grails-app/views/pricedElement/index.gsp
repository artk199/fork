<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricedElement.label', default: 'PricedElement')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-pricedElement" class="content scaffold-list" role="main">
            <h2><g:message code="pricing.element.showAll" /></h2>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:if test="${pl.fork.place.other.PricedElement.list().size() == 0}">
                <p>
                    <g:message code="pricing.noElements"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left">
                    <thead>
                    <tr>
                        <th class='col-md-3 col-sm-3 col-xs-3'><g:message code="pricing.element.name"/></th>
                        <th class='col-md-5 col-sm-5 col-xs-5'><g:message code="pricing.element.description"/></th>
                        <th class='col-md-2 col-sm-2 col-xs-2'><g:message code="pricing.element.price"/></th>
                        <th class='col-md-2 col-sm-2 col-xs-2'><g:message code="pricing.element.menu"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.place.other.PricedElement.list()}" var="pricedElement" >
                        <tr>
                            <td class='col-md-3 col-sm-3 col-xs-3'>
                                <a href="/pricedElement/show/${pricedElement.id}">
                                    ${pricedElement.name}
                                </a>

                                <div class="pull-right">
                                    <a href="/pricedElement/edit/${pricedElement.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                </div>
                            </td>
                            <td class='col-md-5 col-sm-5 col-xs-5'>${pricedElement.description}</td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>${pricedElement.price}</td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <a href="/pricing/show/${pricedElement.pricing.id}">${pricedElement.pricing.title}</a>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:else>
            <div class="buttons">
                <a href="/pricedElement/create" class="save btn btn-default">
                    <span class="glyphicon glyphicon-plus"></span>
                    <g:message code="pricing.element.add.new"/>
                </a>
            </div>
            <div class="pagination">
                <g:paginate total="${pricedElementCount ?: 0}" />
            </div>
        </div>
    </body>
</html>