<div class="row page-section dark-section page-footer" id="foot">
    <div class="col-md-1 col-sm-1 col-lg-1 col-xs-1 hidden-xs"></div>
    <div class="col-md-10 col-sm-10 col-lg-10 col-xs-10">
        <g:set var="maxElementsSize" value="6"/>
        <!-- Sections list in foot -->
        <div class="row">
            <div class="col-md-4 col-sm-4 col-lg-4 col-xs-6">
                <h4><g:message code="footer.siteLinks"/></h4>
                <ul>
                    <li><a href="${createLink(uri:'/')}"><span><g:message code="layout.header.link.home"/></span></a></li>
                    <li><a href="${createLink(controller:'place',action:'index')}"><span><g:message code="layout.header.link.place"/></span></a></li>
                    <li><a href="${createLink(controller:'event',action:'index')}"><span><g:message code="layout.header.link.event"/></span></a></li>
                    <sec:ifLoggedIn>
                        <sec:ifAllGranted roles='ROLE_ADMIN'>
                            <li><a href="${createLink(controller:'admin',action:'index')}"><span><g:message code="layout.footer.link.administration"/></span></a></li>
                        </sec:ifAllGranted>
                    </sec:ifLoggedIn>
                </ul>
            </div>
            <div class="col-md-4 col-sm-4 col-lg-4 col-xs-6">
                <h4><g:message code="footer.mostPopular"/></h4>
                <foot:getTopScoredPlaces maxSize="${maxElementsSize}"/>
            </div>
            <div class="col-md-4 col-sm-4 col-lg-4 col-xs-6">
                <h4><g:message code="footer.newestUsers"/></h4>
                <foot:getNewestUsers maxSize="${maxElementsSize}"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-sm-4 col-lg-4 col-xs-6 logo">
                <a href="${createLink(uri:'/')}" title="${g.message(code: 'application.name')}">
                    <g:img file="logo.png"/>
                    <h5 class="small-application-name"><g:message code="application.name"/></h5>
                </a>
            </div>
            <div class="col-md-4 col-sm-4 col-lg-4 hidden-xs"></div>
            <div class="col-md-4 col-sm-4 col-lg-4 col-xs-6 authors">
                <p><g:message code="footer.rights"/></p>
                <p><g:message code="footer.contact"/></p>
            </div>
        </div>
    </div>
    <div class="col-md-1 col-sm-1 col-lg-1 col-xs-1 hidden-xs"></div>
</div>