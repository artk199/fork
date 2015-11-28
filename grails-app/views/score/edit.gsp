<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'score.label', default: 'Score')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="edit-score" class="content scaffold-edit" role="main">
            <h1><g:message code="score.header.edit" args="[score.title]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.score}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.score}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.score}" method="PUT" class="form-horizontal">
                <g:hiddenField name="version" value="${this.score?.version}" />
                <div class="text-left row">
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                    <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                        <div class="form-group">
                            <label for="title" class="col-sm-4 control-label">
                                <g:message code="score.title" />
                            </label>
                            <div class="col-sm-8">
                                <input class="form-control" name="title" id="title" value="${score.title}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="review" class="col-sm-4 control-label">
                                <g:message code="score.review" />
                            </label>
                            <div class="col-sm-8">
                                <textarea class="form-control" name="review"
                                          id="review" value="${score.review}">${score.review}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="title" class="col-sm-4 control-label">
                                <g:message code="score.score" />
                            </label>
                            <div class="col-sm-8">
                                <input class="form-control" name="score" id="score" value="${score.score}"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                </div>
                <fieldset class="buttons">
                    <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
