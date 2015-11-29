<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pricedElement.label', default: 'PricedElement')}" />
        <title>${pricedElement.pricing.title} - ${pricedElement.name}</title>
    </head>
    <body>
        <sec:ifLoggedIn>
            <permission:hasAccess
                    isOwner="${((g.currentUserID()?.toInteger()) == pricedElement.pricing.place.owner?.id)}"
                    displayNoPermInfo="true"
            >
                <div id="show-pricedElement" class="content scaffold-show" role="main">
                    <h2>
                        <a href="/place/show/${pricedElement.pricing.place.id}">
                            ${pricedElement.pricing.place.name}
                        </a>
                        -
                        <a href="/pricing/show/${pricedElement.pricing.id}">
                            ${pricedElement.pricing.title}
                        </a>
                        -
                        ${pricedElement.name}
                    </h2>
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="text-left row">
                        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                            <div class="panel panel-primary text-left">
                                <div class="panel-heading">
                                    <span class="glyphicon glyphicon-th-large"></span>
                                    ${pricedElement.name}

                                    <g:form resource="${this.pricedElement}" method="DELETE" class="pull-right">
                                        <fieldset class="buttons">
                                            <a href="/pricedElement/edit/${pricedElement.id}">
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
                                    <p>
                                        <span class="glyphicon glyphicon-list-alt"></span>
                                        <strong>
                                            <g:message code="pricing.element.menu"/>
                                        </strong>
                                        <a href="/pricing/show/${pricedElement.pricing.id}">
                                            ${pricedElement.pricing.title}
                                        </a>
                                    </p>
                                    <p>
                                        <span class="glyphicon glyphicon-th-large"></span>
                                        <strong>
                                            <g:message code="pricing.element.name"/>
                                        </strong>
                                        ${pricedElement.name}
                                    </p>
                                    <p>
                                        <span class="glyphicon glyphicon-euro"></span>
                                        <strong>
                                            <g:message code="pricing.element.price"/>
                                        </strong>
                                        ${pricedElement.price}
                                    </p>
                                    <p>
                                        <span class="glyphicon glyphicon-pencil"></span>
                                        <strong>
                                            <g:message code="pricing.element.description"/>
                                        </strong>
                                    </p>
                                    <div class="well well-sm">
                                        <p>${pricedElement.description}</p>
                                    </div>
                                </div>

                                <div class="panel-footer buttons">
                                    <g:link controller="place" action="show" id="${pricedElement.pricing.place?.id}" class="save btn btn-default">
                                        <span class="glyphicon glyphicon-step-backward"></span>
                                        <g:message code="pricing.backToPlace"/>
                                    </g:link>
                                    <g:link controller="pricing" action="show" id="${pricedElement.pricing?.id}" class="save btn btn-default">
                                        <span class="glyphicon glyphicon-step-backward"></span>
                                        <g:message code="pricing.elements.backToPricing"/>
                                    </g:link>
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
