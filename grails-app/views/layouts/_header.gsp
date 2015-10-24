<nav class="navbar navbar-default fork-layout-navbar">
    <div class="container-fluid fork-layout-header">
        <div class="row">
            <div class="col-md-2 col-sm-1 hidden-xs"></div>
            <div class="col-md-8 col-sm-10 col-xs-12">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#header-collapsable" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <g:img class="fork-layout-header-logo" file="logo.png" width="55px" height="55px"/>
                        <span class="fork-layout-header-title" ><g:message code="application.name"/></span>
                    </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="header-collapsable">
                        <ul class="nav navbar-nav navbar-right fork-layout-header-links">
                            <li><a href="${createLink(uri:'/')}"><span><g:message code="layout.header.link.home"/></span></a></li>
                            <li><a href="${createLink(controller:'place',action:'index')}"><span><g:message code="layout.header.link.place"/></span></a></li>
                            <li><a href="${createLink(controller:'event',action:'index')}"><span><g:message code="layout.header.link.event"/></span></a></li>
                            <li><a href="${createLink(controller:'user',action:'index')}"><span><g:message code="layout.header.link.login"/></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-10 hidden-xs"></div>
        </div>
    </div>
</nav>