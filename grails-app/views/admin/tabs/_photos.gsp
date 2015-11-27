<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
    <div class="col-md-8 col-sm-8 col-xs-11">
        <h3><g:message code="admin.tabs.photos.header"/></h3>

        <g:if test="${!waitingImages}">
            <p><g:message code="admin.tabs.photos.noPending"/></p>
        </g:if>
        <g:else>
            <div id="admin-image-tiles">
                <g:each in="${waitingImages}" var="file" >
                    <div class="admin-image-tile pull-left">
                        <g:if test="${file.title}">
                            <div class="pos">
                                <span class="glyphicon glyphicon-picture"></span>
                                <span>${file.title}</span>
                            </div>
                        </g:if>
                        <div class="image-container">
                            <span class="helper"></span>
                            <img src="/image/${file.id}" alt="${file.title ? file.title : file.owner.username}"/>
                        </div>
                        <div class="pos">
                            <span class="glyphicon glyphicon-calendar"></span>
                            <span>${file.dateCreated}</span>
                        </div>
                        <div class="pos">
                            <span class="glyphicon glyphicon-user"></span>
                            <span>
                                <a href="/user/show/${file.owner.id}">${file.owner.username}</a>
                            </span>
                        </div>
                        <g:if test="${file.place}">
                            <div class="pos">
                                <span class="glyphicon glyphicon-map-marker"></span>
                                <span>
                                    <a href="/place/show/${file.place.id}">${file.place.name}</a>
                                </span>
                            </div>
                        </g:if>
                        <div class="buttons">
                            <a class="btn btn-default"
                            onclick="updateImages('${g.createLink(controller:'admin',action:'rejectImage')}', 'admin-image-tiles', '${file.id}')">
                                <span class='glyphicon glyphicon-remove-sign'></span>
                                <span><g:message code="admin.tabs.photos.reject"/></span>
                            </a>
                            <a class="btn btn-default"
                               onclick="updateImages('${g.createLink(controller:'admin',action:'acceptImage')}', 'admin-image-tiles', '${file.id}')">
                                <span class='glyphicon glyphicon-ok-sign'></span>
                                <span><g:message code="admin.tabs.photos.accept"/></span>
                            </a>
                        </div>
                    </div>
                </g:each>
            </div>
        </g:else>
    </div>
    <div class="col-md-2 col-sm-2 col-xs-1 hidden-xs"></div>
</div>