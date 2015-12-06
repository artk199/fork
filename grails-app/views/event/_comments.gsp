<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
        <h1 style="float:left;"><g:message code="event.comments"/></h1>
    <sec:ifLoggedIn>
        <g:if test="${comment == null}">
            <g:hasErrors bean="${this.comment}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.comment}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="addComment" class="form-horizontal" resource="${this.event}">
                <fieldset class="form" style="width: 100%;" >

                    <div class="form-group">
                        <label for="commentTitle" class="col-sm-4 control-label" style="text-align: left;">
                            <g:message code="custom.title" />
                        </label>
                        <div class="col-sm-8" style="width: 100%;">
                            <input class="form-control" name="commentTitle" id="commentTitle" value="${comment != null ? comment.title : ''}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="commentDescription" class="col-sm-4 control-label" style="text-align: left;">
                            <g:message code="custom.text" />
                        </label>
                        <div class="col-sm-8" style="width: 100%;">
                            <textarea class="form-control" name="commentDescription" id="commentDescription" value="${comment != null ? comment.description : ''}"> </textarea>
                        </div>
                    </div>
                    <div style="text-align: right;">
                        <g:submitButton name="addComment" class="save btn btn-default" value="${message(code: 'default.button.add.label', default: 'Add')}" />
                    </div>
                </fieldset>
            </g:form>
        </g:if>
    </sec:ifLoggedIn>
    <br>
    <sec:ifNotLoggedIn>
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;margin-bottom:20px;" >
            <g:message code="place.scores.add.logged.in.required"/> <a href="${createLink(controller:'login',action:'auth')}"><span><g:message code="layout.header.link.login"/></span></a>
        </div>
    </sec:ifNotLoggedIn>
        <g:each in="${comments}" var="comment" >
            <div class="row">
                <div class="col-lg-1 col-md-1 hidden-sm hidden-xs"></div>
                <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12" style="margin-bottom:10px;">
                    <div class="row">
                        <div class="col-md-2 col-sm-3 col-xs-3" style="height: 125px;">
                            <div class="pull-left">
                                    <a ng-href="/user/show/${comment.owner.id}">
                                        <img ng-src="${comment.owner.profilePicture != null ? '/image/'+comment.owner.profilePicture.id :
                                                '/assets/no-profile.jpg'}" width="75px" height="75px"/>
                                        <div style="text-align:center" ng-app>
                                            ${comment.owner.username}
                                        </div>
                                    </a>
                            </div>
                        </div>
                        <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9" style="background:#D6E6C3;border: 3px solid #fff;box-shadow: 0 0 0 3px #eceae2;border-radius: 10px;">
                            <div class="row" style="margin: 5px;">
                                <div class="col-md-12 col-sm-12 col-xs-12" style="border-bottom: 1px solid black;">
                                    <div class="pull-left" style="margin: 5px 0px;;font-size: 16px;color: #4D8365;font-weight: bold;font-style: italic;">
                                        ${comment.title}
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12" style="margin: 10px 0px;">
                                    <div class="pull-left" style="text-align: left;">
                                        ${comment.description}
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</div>