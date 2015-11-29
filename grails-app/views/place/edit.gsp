<%@ page import="pl.fork.auth.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>${this.place.town ? this.place.town + " - " : "" }${this.place.name}</title>
    </head>
    <body>
    <sec:ifLoggedIn>
        <permission:hasAccess isOwner="${((g.currentUserID()?.toInteger()) == this.place.owner?.id)}" displayNoPermInfo="true">
            <div id="edit-place" class="content scaffold-edit" role="main">
                <h2>${this.place.town ? this.place.town + " - " : "" }${this.place.name}</h2>
                <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.place}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.place}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
                        <g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
                </g:hasErrors>
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <g:form resource="${this.place}" method="PUT" class="form-horizontal">
                            <g:hiddenField name="version" value="${this.place?.version}" />
                            <fieldset class="form">
                                <g:render template="editParts/mainFields" model="[place:place]"/>
                                <hr/>
                                <g:render template="editParts/selectionPart" model="[place:place]"/>
                                <hr/>
                                <g:render template="editParts/pricings" model="[place:place]"/>

                            </fieldset>
                            <fieldset class="buttons">
                                <input class="btn btn-default" class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </permission:hasAccess>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        <g:render template="../noPermissions"/>
    </sec:ifNotLoggedIn>
    </body>
</html>
