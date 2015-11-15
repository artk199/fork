<div class="page-section" id="users-all">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.users.all"/></h3>

            <g:if test="${pl.fork.auth.User.list().size() == 0}">
                <p>
                  <g:message code="admin.tabs.users.noUsers"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <g:message code="default.count" args="[pl.fork.auth.User.list().size()]" />
                        </span>
                    </caption>
                    <thead>
                    <tr>
                        <th class='col-md-3 col-sm-3 col-xs-3' data-defaultsort="asc" data-firstsort="desc">
                            <span class="glyphicon glyphicon-user"></span>
                            <g:message code="admin.tabs.users.username"/>
                        </th>
                        <th class='col-md-3 col-sm-3 col-xs-3'>
                            <span class="glyphicon glyphicon-envelope"></span>
                            <g:message code="admin.tabs.users.email"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-calendar"></span>
                            <g:message code="admin.tabs.users.registerDate"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-dashboard"></span>
                            <g:message code="admin.tabs.users.lastLogged"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-star-empty"></span>
                            <g:message code="admin.tabs.users.role"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.auth.User.list()}" var="user" >
                        <tr>
                            <td class='col-md-3 col-sm-3 col-xs-3'>
                                <a href="/user/show/${user.id}">
                                    ${user.username}
                                </a>

                                <div class="pull-right">
                                    <a href="/user/edit/${user.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                </div>
                            </td>
                            <td class='col-md-3 col-sm-3 col-xs-3'>
                                <a href="mailto:${user.email}">
                                    ${user.email}
                                </a>
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                Do zrobienia!
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                Do zrobienia!
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <g:each in="${user.authorities}" var="role" >
                                    ${role.authority}
                                </g:each>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:else>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>