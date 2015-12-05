<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${event.title}" />
        <title>${entityName}</title>
    </head>
    <body>
    <div id="show-event">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <div class="row">

                    <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                        <h1>${event.title}</h1>

                        <div class="col-md-4 col-sm-6 col-xs-12" style="margin-bottom: 20px;">
                            <g:if test="${event.place.mainImage }">
                                <img src="${g.createLink(absolute:true,uri:'/image/'+event.place.mainImage.id)}" class="img-responsive">
                            </g:if>
                            <g:else>
                                <img src="/assets/no-image.jpg" class="img-responsive">
                            </g:else>
                        </div>
                        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                            <span><b><g:message code="event.startDate"/></b></span>
                            ${event.startDate != null ? event.startDate.format('yyyy/MM/dd HH:mm') : ''}
                        </div>
                        <div class="col-md-8 col-sm-8 col-xs-11 text-left">
                            <span><b><g:message code="event.endDate"/></b></span>
                            ${event.endDate != null ? event.endDate.format('yyyy/MM/dd HH:mm') : ''}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
        <div class="row page-section blue-section">
            <div class="col-sm-12 col-xs-12 col-lg-12 col-md-12">
                <g:render template="tabs" model="[event:event]"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                <g:render template="comments" model="[event:event, comment:comment, comments:comments, signedUser:signedUser]"/>
            </div>
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
        </div>
    </div>
    </body>
</html>
