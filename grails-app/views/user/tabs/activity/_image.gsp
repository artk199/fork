<div class='col-md-12' style="height:220px; border: 1px #DDD solid; margin-bottom: 25px;">
    <div style="height:60px">
        <div style="float:left; margin: 10px 0px; line-height:20px; height:40px;">
            <g:if test="${activity.user.profilePicture}">
                <img src="${g.createLink(absolute:true,uri:'/image/'+activity.user.profilePicture.id+'/mini')}" width="40px" height="40px" style="border: 1px solid #DDD;">
            </g:if>
            <g:else>
                <img src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="40px" height="40px" style="border: 1px solid #DDD;">
            </g:else>
        </div>
        <div style="float:left; height:40px; margin-top: 10px; margin-left:10px; text-align:left;">
            <g:link action="show" controller="user" id="${activity.user.id}"><span style="font-weight:bold">${activity.user}</span></g:link>
            <br/>
            <small><g:timeSince date="${activity.dateCreated}"/></small>
        </div>
    </div>
    <div style="height:100px;">
        <div style="float:left; width:140px;height:140px;">
             <div style="float:left">
                 <img src="${g.createLink(absolute:true,uri:'/image/'+activity.image.id+'/mini')}" width="140px" height="140px" style="border: 1px solid #DDD;">
             </div>
        </div>
        <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:35px; overflow:hidden;white-space: nowrap;text-overflow:ellipsis;">
            <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 30px;font-weight: bold; font-style: italic;">
            Dodał zdjęcie
            <g:if test="${activity.image.title}">
                &bdquo;${activity.image.title}&rdquo;
            </g:if>
            <g:else>
                &bdquo;Bez tutułu&rdquo;
            </g:else>
            </h2>
        </div>
        <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:60px;overflow:hidden;">
            ${activity.image.description}
        </div>
        <div style="float:right;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);text-align:right;margin-top:10px;">
            <%--<div style="float:left;">
                <g:link action="show" controller="place" id="${activity.score.place.id}"> ${activity.score.place.name} </g:link>
            </div>
            <g:each var="star" in="${score}">
                <span class="glyphicon glyphicon-star" style="color: #F9FF00;font-size: 20px; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;margin:-1px;"></span>
            </g:each>
            <g:each var="star" in="${noscore}">
                <span class="glyphicon glyphicon-star" style="font-size: 20px; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;margin:-1px;"></span>
            </g:each> --%>
        </div>
    </div>
</div>
