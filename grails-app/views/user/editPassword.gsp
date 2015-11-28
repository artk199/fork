<!DOCTYPE html>
<html>
    <head>
        <title>${this.user.username}</title>
    </head>
    <body>

        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div style="width:100%; height:100%;padding-top:30px; padding-bottom:30px;">
                    <g:form resource="${this.user}" method="PUT" class="form-horizontal">
                        <g:hiddenField name="version" value="${this.user?.version}" />
                        <fieldset class="form">
                            <div class="form-group">
                                <label for="password" class="col-sm-4 control-label">
                                    <g:message code="user.password.old" />
                                </label>
                                <div class="col-sm-8">
                                    <g:passwordField class="form-control" name="old_password" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password_confirm" class="col-sm-4 control-label">
                                    <g:message code="user.password.new" />
                                </label>
                                <div class="col-sm-8">
                                    <g:passwordField class="form-control" name="password" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="email" class="col-sm-4 control-label">
                                    <g:message code="user.password.new.confirm" />
                                </label>
                                <div class="col-sm-8">
                                    <g:passwordField class="form-control" name="password_confirm" />
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="buttons">
                            <input class="btn btn-default btn-block" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                        </fieldset>
                    </g:form>

                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </body>
</html>
