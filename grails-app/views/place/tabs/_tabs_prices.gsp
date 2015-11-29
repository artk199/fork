<div class="row" id="place-prices">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.prices.header"/>
        </h2>

        <g:if test="${this.place.pricing.size() == 0}">
            <p><g:message code="place.show.pricing.noPricing"/></p>
            <sec:ifLoggedIn>
                <permission:hasAccess isOwner="${((g.currentUserID()?.toInteger()) == this.place.owner?.id)}">
                    <p><g:message code="place.show.pricing.addMenu" args="['/pricing/create?place.id='+this.place.id]"/></p>
                </permission:hasAccess>
            </sec:ifLoggedIn>
        </g:if>
        <g:else>

            <!-- SHOW ALL PRICINGS FOR PLACE !-->
            <g:each in="${this.place.pricing}" var="pricing" >
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-list-alt"></span>
                        ${pricing.title}
                        <sec:ifLoggedIn>
                            <permission:hasAccess isOwner="${((g.currentUserID()?.toInteger()) == this.place.owner?.id)}">
                                <div class="pull-right">
                                    <a href="/pricing/edit/${pricing.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                </div>
                            </permission:hasAccess>
                        </sec:ifLoggedIn>
                    </div>
                    <div class="panel-body">
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
                                        <g:message code="place.show.pricing.elements.name"/>
                                    </th>
                                    <th class='col-md-6 col-sm-6 col-xs-6'>
                                        <span class="glyphicon glyphicon-comment"></span>
                                        <g:message code="place.show.pricing.elements.description"/>
                                    </th>
                                    <th class='col-md-2 col-sm-2 col-xs-2'>
                                        <span class="glyphicon glyphicon-euro"></span>
                                        <g:message code="place.show.pricing.elements.price"/>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${pricing.elements}" var="element" >
                                    <tr>
                                        <td class='col-md-4 col-sm-4 col-xs-4'>${element.name}</td>
                                        <td class='col-md-6 col-sm-6 col-xs-6'>${element.description}</td>
                                        <td class='col-md-2 col-sm-2 col-xs-2'>${element.price}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </g:if>
                </div>
            </g:each>
            <sec:ifLoggedIn>
                <permission:hasAccess isOwner="${((g.currentUserID()?.toInteger()) == this.place.owner?.id)}">
                    <div class="buttons">
                        <a href="/pricing/create?place.id=${this.place.id}" class="save btn btn-orange">
                            <span class="glyphicon glyphicon-plus"></span>
                            <g:message code="pricing.add.new"/>
                        </a>
                    </div>
                </permission:hasAccess>
            </sec:ifLoggedIn>
        </g:else>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>