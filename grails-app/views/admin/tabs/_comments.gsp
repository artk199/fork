<%@ page import="pl.fork.place.Score" %>

<!-- BUTTONS !-->
<div class="buttons page-section">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
            <div class="btn-group" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdown-comments" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        <span class="glyphicon glyphicon-share-alt"></span>
                        <g:message code="admin.goToSection"/>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdown-comments">
                        <li><a href="#comments-flagged"><g:message code="admin.tabs.comments.flagged"/></a></li>
                        <li><a href="#comments-newest"><g:message code="admin.tabs.comments.newest"/></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    </div>
</div>

<!-- LIST OF COMMENTS FLAGGED BY USERS !-->
<div class="page-section dark-section" id="comments-flagged">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.comments.flagged"/></h3>

            <g:if test="${flaggedScores?.size() == 0}">
                <p>
                    <g:message code="admin.tabs.comments.noFlagged"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable" id = "admin-flagged-comments-table">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <g:message code="default.count" args="[flaggedScores?.size()]" />
                        </span>
                    </caption>
                    <thead>
                    <tr>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-user"></span>
                            <g:message code="admin.tabs.comments.author"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-pencil"></span>
                            <g:message code="admin.tabs.comments.title"/>
                        </th>
                        <th class='col-md-4 col-sm-4 col-xs-4'>
                            <span class="glyphicon glyphicon-comment"></span>
                            <g:message code="admin.tabs.comments.content"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2' data-defaultsort="desc" data-firstsort="asc">
                            <span class="glyphicon glyphicon-flag"></span>
                            <g:message code="admin.tabs.comments.flags"/>
                        </th>
                        <th class='col-md-1 col-sm-1 col-xs-1' data-defaultsort='disabled'>
                            <span class="glyphicon glyphicon-cog"></span>
                            <g:message code="admin.tabs.comments.options"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${flaggedScores}" var="score">
                        <tr>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <g:link controller="user" action="show" id="${score.owner.id}">
                                    ${score.owner.username}
                                </g:link>
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                               <g:link controller="score" action="edit" id="${score.id}">
                                   ${score.title}
                               </g:link>
                            </td>
                            <td class='col-md-4 col-sm-4 col-xs-4'>
                               ${score.review}
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                ${score.reports.size()}
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <a class="btn btn-default btn-block"
                                   onclick="updateComments('${g.createLink(controller:'admin',action:'closeReports')}',
                                           'admin-flagged-comments-table', '${score.id}')">
                                    <span class='glyphicon glyphicon-remove-sign'></span>
                                    <span><g:message code="admin.tabs.comments.closeReport"/></span>
                                </a>
                                <a href="/score/edit/${score.id}" class="btn btn-default btn-block">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <g:message code="default.link.edit"/>
                                </a>
                                <a class="btn btn-default btn-block"
                                   onclick="updateComments('${g.createLink(controller:'admin',action:'removeScore')}',
                                           'admin-flagged-comments-table', '${score.id}')">
                                    <span class='glyphicon glyphicon-remove-sign'></span>
                                    <span><g:message code="default.link.delete"/></span>
                                </a>
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

<!-- LIST OF THE NEWEST COMMENTS !-->
<div class="page-section" id="comments-newest">
    <div class="row">
        <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-8 col-sm-8 col-xs-11">
            <h3><g:message code="admin.tabs.comments.newest"/></h3>

            <g:if test="${pl.fork.place.Score.list().size() == 0}">
                <p>
                    <g:message code="admin.tabs.comments.noComments"/>
                </p>
            </g:if>
            <g:else>
                <table class="table table-striped text-left sortable">
                    <caption>
                        <span class="pull-right">
                            <span class="glyphicon glyphicon-th"></span>
                            <g:message code="default.count" args="[pl.fork.place.Score.list().size()]" />
                        </span>
                    </caption>
                    <thead>
                    <tr>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-user"></span>
                            <g:message code="admin.tabs.comments.author"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-pencil"></span>
                            <g:message code="admin.tabs.comments.title"/>
                        </th>
                        <th class='col-md-4 col-sm-4 col-xs-4'>
                            <span class="glyphicon glyphicon-comment"></span>
                            <g:message code="admin.tabs.comments.content"/>
                        </th>
                        <th class='col-md-2 col-sm-2 col-xs-2'>
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <g:message code="admin.tabs.comments.place"/>
                        </th>
                        <th class='col-md-1 col-sm-1 col-xs-1' data-defaultsort="desc" data-firstsort="asc">
                            <span class="glyphicon glyphicon-calendar"></span>
                            <g:message code="admin.tabs.comments.date"/>
                        </th>
                        <th class='col-md-1 col-sm-1 col-xs-1' data-defaultsort='disabled'>
                            <span class="glyphicon glyphicon-cog"></span>
                            <g:message code="admin.tabs.comments.options"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pl.fork.place.Score.list()}" var="score" >
                        <tr>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <a href="/user/show/${score.owner.id}">
                                    ${score.owner.username}
                                </a>
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <a href="/score/edit/${score.id}">
                                    <g:if test="${score.title}">
                                        ${score.title}
                                    </g:if>
                                    <g:else>
                                        <g:message code="default.input.empty"/>
                                    </g:else>
                                </a>
                            </td>
                            <td class='col-md-6 col-sm-6 col-xs-6'>
                                ${score.review}
                            </td>
                            <td class='col-md-2 col-sm-2 col-xs-2'>
                                <a href="/place/show/${score.place.id}">
                                    ${score.place.name}
                                </a>
                            </td>
                            <td class='col-md-1 col-sm-1 col-xs-1'>
                                ${score.dateCreated}
                            </td>
                            <td class='col-md-1 col-sm-1 col-xs-1'>
                                <g:form resource="${score}" method="DELETE">
                                    <g:hiddenField name="version" value="${score?.version}" />
                                    <g:hiddenField name="id" value="${score?.id}" />
                                    <fieldset class="buttons">
                                        <a href="/score/edit/${score.id}" class="btn btn-default btn-block">
                                            <span class="glyphicon glyphicon-edit"></span>
                                            <g:message code="default.link.edit"/>
                                        </a>
                                        <label for="delete-score-${score.id}" class="btn btn-default btn-block">
                                            <span class="glyphicon glyphicon-remove"></span>
                                            <g:message code="default.link.delete"/>
                                        </label>
                                        <input id="delete-score-${score.id}" class="hidden" type="submit"
                                               value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                               onclick="return confirm('${message(code: 'default.button.delete.confirm.message',
                                               default: 'Are you sure?')}');" />
                                    </fieldset>
                                </g:form>
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