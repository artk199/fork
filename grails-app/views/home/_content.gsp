<div id='main-content'>
    <div class="row page-section">
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-3 col-sm-3 col-lg-3 hidden-xs">
            <g:img class="img-responsive pull-right" file="home_attractions.png"/>
        </div>
        <div class="col-md-5 col-sm-5 col-lg-5 col-xs-10 text-left">
            <h2>
                <span class="glyphicon glyphicon glyphicon-flag pull-left"></span>
                <g:message code="home.attractions.header"/>
            </h2>
            <p><g:message code="home.attractions.description.first"/></p>
            <p><g:message code="home.attractions.description.second" args="['/place']"/></p>
        </div>
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    </div>

    <div class="row page-section blue-section">
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
        <div class="col-md-5 col-sm-5 col-lg-5 col-xs-10 text-left">
            <h2>
                <span class="glyphicon glyphicon glyphicon-user pull-left"></span>
                <g:message code="home.register.header"/>
            </h2>
            <p><g:message code="home.register.description.first"/></p>
            <p><g:message code="home.register.description.second" args="['/register']"/></p>
            <a href="/register" class="btn btn-orange btn-default pull-right" role="button">
                <span class="glyphicon glyphicon glyphicon-user"></span>
                <g:message code="default.registration"/>
            </a>
        </div>
        <div class="col-md-3 col-sm-3 col-lg-3 hidden-xs">
            <g:img class="img-responsive" file="home_community.png"/>
        </div>
        <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
    </div>
    <g:if test="${randomPlace}">
        <div class="row page-section">
            <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
            <div class="col-md-3 col-sm-3 col-lg-3 hidden-xs">
                <g:if test="${randomPlace.images.size() > 0 }">
                    <img style="max-width: 270px;border-radius: 50%;" class="img-responsive pull-right" src="/image/${randomPlace.images[0].id}"/>
                </g:if>
                <g:else>
                    <img style="max-width: 270px;border-radius: 50%;" src="/assets/no-image.jpg" class="img-responsive pull-right"/>
                </g:else>
            </div>
            <div class="col-md-5 col-sm-5 col-lg-5 col-xs-10 text-left">
                <h2>
                    <a href="/place/show/${randomPlace.id}">${randomPlace.name}</a>
                </h2>
                <p>${randomPlace.description}</p>
            </div>
            <div class="col-md-2 col-sm-2 col-lg-2 col-xs-1 hidden-xs"></div>
        </div>
    </g:if>
</div>