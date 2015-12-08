<!-- BUTTONS !-->
<div class="buttons page-section">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
            <div class="btn-group" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-place" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        <span class="glyphicon glyphicon-share-alt"></span>
                        <g:message code="admin.goToSection"/>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdown-place">
                        <li><a href="#users-all"><g:message code="admin.tabs.users.all"/></a></li>
                        <li><a href="#users-search-user"><g:message code="admin.tabs.users.find"/></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>

<!-- SEARCH FOR AN USER !-->
<div class="page-section blue-section" id="users-search-user">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11 text-right">
            <h3 class="text-center"><g:message code="admin.tabs.users.find"/></h3>

            <g:form action="findUser" controller="admin" class="form-horizontal admin-findUser-form" >
                <g:set var="ajaxFunction" value="getUsersFromController('${g.createLink(controller:'admin',action:'findUser')}', 'all-users-table')" />
                <div class="form-group row">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <input id="username" type="text" name="username" class="form-control" placeholder="${g.message(code:'admin.tabs.users.find.username')}"
                               oninput="${ajaxFunction}">
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <input id="email" type="text" name="email" class="form-control" placeholder="${g.message(code:'admin.tabs.users.find.email')}"
                               oninput="${ajaxFunction}">
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <div class="buttons">
                            <a class="btn btn-primary form-control" onclick="${ajaxFunction}">
                                <span class="glyphicon glyphicon-search"></span>
                                <g:message code="admin.search"/>
                            </a>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>

<!-- LIST OF ALL USERS !-->
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
                <table class="table table-striped text-left sortable" id = "all-users-table">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <span><g:message code="default.count" args="[pl.fork.auth.User.list().size()]" /></span>
                        </span>
                    </caption>
                    <thead>
                    <tr>
                        <th class='col-md-4 col-sm-4 col-xs-4' data-defaultsort="asc" data-firstsort="desc">
                            <span class="glyphicon glyphicon-user"></span>
                            <span><g:message code="admin.tabs.users.username"/></span>
                        </th>
                        <th class='col-md-4 col-sm-4 col-xs-4'>
                            <span class="glyphicon glyphicon-envelope"></span>
                            <span><g:message code="admin.tabs.users.email"/></span>
                        </th>
                        <th class='col-md-4 col-sm-4 col-xs-4'>
                            <span class="glyphicon glyphicon-star-empty"></span>
                            <span><g:message code="admin.tabs.users.role"/></span>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.auth.User.list()}" var="user" >
                        <tr>
                            <td class='col-md-4 col-sm-4 col-xs-4'>
                                <a href="/user/show/${user.id}">
                                    ${user.username}
                                </a>

                                <div class="pull-right">
                                    <a href="/user/adminEdit/${user.id}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        <g:message code="default.link.edit"/>
                                    </a>
                                </div>
                            </td>
                            <td class='col-md-4 col-sm-4 col-xs-4'>
                                <a href="mailto:${user.email}">
                                    ${user.email}
                                </a>
                            </td>
                            <td class='col-md-4 col-sm-4 col-xs-4'>
                                <g:if test="${user.authorities?.size() > 0}">
                                    <g:each in="${user.authorities}" var="role" >
                                        ${role.authority}${role != user.authorities.last()? ',' : ""}
                                    </g:each>
                                </g:if>
                                <g:else>
                                   <span><g:message code="default.input.empty"/></span>
                                </g:else>
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