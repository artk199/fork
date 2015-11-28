<div class="form-group">
    <label for="profilePicture" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="user.profilePicture" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <g:select name="profilePicture" id="profilePicture" from="${user.images}"
                  optionValue="id" class="form-control" value="${user.profilePicture?.id}"
                  optionKey="id" noSelection="${['null':message(code:'default.select.noSelection')]}"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="enabled" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="user.accountEnabled" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input name="_enabled" type="hidden"/>
        <input type="checkbox"  name="enabled" id="enabled" <g:if test="${user.enabled}">checked="checked"</g:if>/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="accountLocked" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="user.accountLocked" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        <input name="_accountLocked" type="hidden"/>
        <input type="checkbox" name="accountLocked" id="accountLocked" <g:if test="${user.accountLocked}">checked="checked"</g:if>/>
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>

<div class="form-group">
    <label for="authorities" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 control-label">
        <g:message code="user.permissions" />
    </label>
    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
        ${user.authorities}
        <g:select name="authorities" id="authorities" from="${pl.fork.auth.Role.list()}"
                  class="form-control"  multiple="multiple"
        />
    </div>
    <div class="col-xs-1 col-sm-2 col-md-2 col-lg-2 hidden-xs"></div>
</div>