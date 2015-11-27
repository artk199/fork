<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
                    <div style="border: 1px solid #DDD; width:100%; background: white; margin-top:20px; padding:20px; text-align: left; font-size:16px;">
                        Jeżeli nie pamiętasz swojego starego hasła przejdź <a>tutaj</a>.
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </body>
</html>
