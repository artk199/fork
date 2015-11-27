<h3 class="text-center"><g:message code="place.list.pricing"/></h3>

<g:if test="${place.pricing.size() > 0}">
    <table class="table table-striped text-left sortable">
        <thead>
        <tr>
            <th class='col-md-6 col-sm-6 col-xs-6' data-defaultsort="asc" data-firstsort="desc">
                <span class="glyphicon glyphicon-list-alt"></span>
                <g:message code="pricing.title"/>
            </th>
            <th class='col-md-6 col-sm-6 col-xs-6'>
                <span class="glyphicon glyphicon-comment"></span>
                <g:message code="pricing.description"/>
            </th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${place.pricing}" var="pricing" >
            <tr>
                <td class='col-md-6 col-sm-6 col-xs-6'>
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
                <td class='col-md-6 col-sm-6 col-xs-6'>${pricing.description}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>

<div class="buttons text-center">
    <a href="/pricing/create?place.id=${this.place.id}" class="save btn btn-default">
        <span class="glyphicon glyphicon-plus"></span>
        <g:message code="pricing.add.new"/>
    </a>
</div>