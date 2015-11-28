<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'pricing.label', default: 'Pricing')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
    <div id="edit-pricing" class="content scaffold-edit" role="main">
        <h2>
            <a href="/place/show/${pricing.place.id}">
                ${pricing.place.name}
            </a>
            -
            ${pricing.title}
        </h2>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.pricing}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.pricing}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>
        <g:form resource="${this.pricing}" method="PUT" class="form-horizontal">
            <g:hiddenField name="version" value="${this.pricing?.version}" />
            <div class="text-left row">
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                    <fieldset class="form">
                        <!-- FIELDS ON MENU !-->
                        <div class="form-group">
                            <label for="title" class="col-sm-4 control-label">
                                <g:message code="pricing.title" />
                            </label>
                            <div class="col-sm-8">
                                <input class="form-control" name="title" id="title" value="${pricing.title}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description" class="col-sm-4 control-label">
                                <g:message code="pricing.description" />
                            </label>
                            <div class="col-sm-8">
                                <textarea class="form-control" name="description"
                                          id="description" value="${pricing.description}">${pricing.description}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="place" class="col-sm-4 control-label">
                                <g:message code="pricing.place" />
                            </label>
                            <div class="col-sm-8">
                                <g:select name="place" id="place" from="${pl.fork.place.Place.list()}"
                                          optionValue="name" class="form-control" value="${pricing.place}"
                                          optionKey="id"
                                />
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
            </div>

            <h2><g:message code="pricing.elements.header"/></h2>
            <div class="text-left row">
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
                <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                    <g:if test="${pricing.elements.size() > 0}">
                        <!-- SHOW ELEMENTS FOR THIS PRICING !-->
                        <table class="table table-striped sortable">
                            <caption><g:message code="place.show.pricing.elements"/></caption>
                            <thead>
                            <tr>
                                <th class='col-md-4 col-sm-4 col-xs-4' data-defaultsort="asc" data-firstsort="desc">
                                    <span class="glyphicon glyphicon-th-large"></span>
                                    <g:message code="pricing.element.name"/>
                                </th>
                                <th class='col-md-4 col-sm-4 col-xs-4'>
                                    <span class="glyphicon glyphicon-comment"></span>
                                    <g:message code="pricing.element.description"/>
                                </th>
                                <th class='col-md-1 col-sm-1 col-xs-1'>
                                    <span class="glyphicon glyphicon-euro pull-left"></span>
                                    <g:message code="pricing.element.price"/>
                                </th>
                                <th class='col-md-2 col-sm-2 col-xs-2' data-defaultsort='disabled'>
                                    <span class="glyphicon glyphicon-wrench"></span>
                                    <g:message code="pricing.options"/>
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${pricing.elements}" var="element" >
                                <tr>
                                    <td class='col-md-4 col-sm-4 col-xs-4'>
                                        <a href="/pricedElement/show/${element.id}">${element.name}</a>
                                    </td>
                                    <td class='col-md-5 col-sm-5 col-xs-5'>${element.description}</td>
                                    <td class='col-md-1 col-sm-1 col-xs-1'>${element.price}</td>
                                    <td class='col-md-2 col-sm-2 col-xs-2'>
                                        <g:form resource="${element}" method="DELETE" >
                                            <fieldset class="buttons">
                                                <a href="/pricedElement/edit/${element.id}">
                                                    <span class="glyphicon glyphicon-edit"></span>
                                                    <g:message code="default.link.edit"/>
                                                </a>
                                                <label for="delete-element">
                                                    <span class="glyphicon glyphicon-remove"></span>
                                                    <g:message code="default.link.delete"/>
                                                </label>
                                                <input id="delete-element" class="hidden" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                            </fieldset>
                                        </g:form>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
            </div>
            <fieldset class="form-group" id="pricing-elements">
                <!-- FIELDS ON MENU ELEMENT!-->
                <div class="buttons">

                    <a href="/pricedElement/create?pricing.id=${pricing.id}" class="save btn btn-default">
                        <span class="glyphicon glyphicon-plus"></span>
                        <g:message code="pricing.element.add.new"/>
                    </a>
                </div>
            </fieldset>

            <fieldset class="buttons">
                <input class="save btn btn-default" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                <g:link controller="place" action="show" id="${pricing.place?.id}" class="save btn btn-default">
                    <span class="glyphicon glyphicon-step-backward"></span>
                    <g:message code="pricing.backToPlace"/>
                </g:link>
                <g:link controller="pricing" action="show" id="${pricing.id}" class="save btn btn-default">
                    <span class="glyphicon glyphicon-remove"></span>
                    <g:message code="default.input.cancel"/>
                </g:link>
            </fieldset>
        </g:form>
    </div>
</body>
</html>
