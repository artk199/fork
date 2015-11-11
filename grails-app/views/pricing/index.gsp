<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-pricing" class="content scaffold-list" role="main">
            <h1><g:message code="pricing.all.header" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:if test="${pl.fork.place.other.Pricing.list().size() == 0}">
               <p>
                   <g:message code="pricing.noMenu"/>
               </p>
            </g:if>
            <g:else>
                    <table class="table table-striped text-left">
                        <thead>
                        <tr>
                            <th class='col-md-3 col-sm-3 col-xs-3'><g:message code="pricing.title"/></th>
                            <th class='col-md-5 col-sm-5 col-xs-5'><g:message code="pricing.description"/></th>
                            <th class='col-md-2 col-sm-2 col-xs-2'><g:message code="pricing.place"/></th>
                            <th class='col-md-2 col-sm-2 col-xs-2'><g:message code="pricing.element.count"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${pl.fork.place.other.Pricing.list()}" var="pricing" >
                            <tr>
                                <td class='col-md-3 col-sm-3 col-xs-3'>
                                    <a href="/pricing/show/${pricing.id}">
                                        ${pricing.title}
                                    </a>

                                    <div class="pull-right">
                                        <a href="/pricing/edit/${pricing.id}">
                                            <span class="glyphicon glyphicon-edit"></span>
                                            <g:message code="default.link.edit"/>
                                        </a>
                                    </div>
                                </td>
                                <td class='col-md-5 col-sm-5 col-xs-5'>${pricing.description}</td>
                                <td class='col-md-2 col-sm-2 col-xs-2'>
                                    <a href="/place/show/${pricing.place.id}">${pricing.place.name}</a>
                                </td>
                                <td class='col-md-2 col-sm-2 col-xs-2'>
                                    ${pricing.elements == null ? '0' : pricing.elements.size()}
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
            </g:else>
            <div class="buttons">
                <a href="/pricing/create" class="save btn btn-default">
                    <span class="glyphicon glyphicon-plus"></span>
                    <g:message code="pricing.add.new"/>
                </a>
            </div>
            <div class="pagination">
                <g:paginate total="${pricingCount ?: 0}" />
            </div>
        </div>
    </body>
</html>