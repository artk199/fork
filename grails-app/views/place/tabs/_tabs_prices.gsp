<div class="row" id="place-prices">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        <h2>
            <span class="glyphicon glyphicon glyphicon-chevron-right pull-left"></span>
            <g:message code="place.show.prices.header"/>
        </h2>

        <g:if test="${this.place.pricing.size() == 0}">
            <p><g:message code="place.show.pricing.noPricing"/></p>
            <p><g:message code="place.show.pricing.addMenu" args="['/pricing/create']"/></p>
        </g:if>
        <g:else>

            <!-- SHOW ALL PRICINGS FOR PLACE !-->
            <g:each in="${this.place.pricing}" var="pricing" >
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-list-alt"></span>
                        ${pricing.title}
                        <div class="pull-right">
                            <a href="/pricing/edit/${pricing.id}">
                                <span class="glyphicon glyphicon-edit"></span>
                                Edytuj
                            </a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="well well-sm">
                            <p>${pricing.description}</p>
                        </div>
                    </div>

                    <g:if test="${pricing.elements.size() > 0}">
                        <!-- SHOW ELEMENTS FOR THIS PRICING !-->
                        <table class="table table-striped">
                            <caption><g:message code="place.show.pricing.elements"/></caption>
                            <thead>
                                <tr>
                                    <th class='col-md-4 col-sm-4 col-xs-4'><g:message code="place.show.pricing.elements.name"/></th>
                                    <th class='col-md-6 col-sm-6 col-xs-6'><g:message code="place.show.pricing.elements.description"/></th>
                                    <th class='col-md-2 col-sm-2 col-xs-2'><g:message code="place.show.pricing.elements.price"/></th>
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
        </g:else>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>