<div class="row" >
    <div class="col-md-12">
        <div style="margin:20px">
            <table class="table table-striped table-bordered fork-table">
                <thead>
                <tr>
                    <th>
                        <span class="glyphicon glyphicon-th-large"></span>
                        <g:message code="user.event.name"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-user"></span>
                        <g:message code="user.event.place"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-time"></span>
                        <g:message code="user.event.date"/>
                    </th>
                    <th>
                        <span class="glyphicon glyphicon-user"></span>
                        <g:message code="user.event.participants.size"/>
                    </th>
                </tr>
                </thead>
                <tbody>
                    <tr onclick="window.location.href='/event/show/1'">
                        <td class='col-md-4 col-sm-4 col-xs-4'>a</td>
                        <td class='col-md-6 col-sm-6 col-xs-6'>b</td>
                        <td class='col-md-2 col-sm-2 col-xs-2'>c</td>
                        <td class='col-md-2 col-sm-2 col-xs-2'>c</td>
                    </tr>
                    <tr>
                        <td class='col-md-4 col-sm-4 col-xs-4'>a</td>
                        <td class='col-md-6 col-sm-6 col-xs-6'>b</td>
                        <td class='col-md-2 col-sm-2 col-xs-2'>c</td>
                        <td class='col-md-2 col-sm-2 col-xs-2'>c</td>
                    </tr>
                    <tr class="inactive">
                        <td colspan="4" class='col-md-4 col-sm-4 col-xs-4'><g:message code="user.event.table.empty"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>