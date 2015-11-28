<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title>${this.user.username}</title>
    </head>
    <body>

       <div class="row" style="margin-bottom:20px;">
           <div class="col-md-2 col-sm-1 hidden-xs"></div>
           <div class="col-md-8 col-sm-10 col-xs-12">
               <g:render template="tabs"/>
           </div>
           <div class="col-md-2 col-sm-1 hidden-xs"></div>
       </div>
    </body>
</html>
