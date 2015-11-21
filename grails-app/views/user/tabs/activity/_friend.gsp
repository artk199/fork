<g:set var="friend" value="${pl.fork.auth.User.findById(activity.friend)}"/>

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
                 <g:if test="${friend.profilePicture}">
                    <img src="${g.createLink(absolute:true,uri:'/image/'+friend.profilePicture.id+'/mini')}" width="140px" height="140px" style="border: 1px solid #DDD;">
                 </g:if>
                 <g:else>
                     <img src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="140px" height="140px" style="border: 1px solid #DDD;">
                 </g:else>
             </div>
        </div>
        <div style="margin-top:35px;float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:35px; overflow:hidden;white-space: nowrap;text-overflow:ellipsis;">
            <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 30px;font-weight: bold;">
                <g:if test="${g.currentUserID().toLong() == friend.id}">
                    Został twoim znajomym
                </g:if>
                <g:else>
                    Znalazł nowego znajomego
                </g:else>
            </h2>
        </div>
        <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:60px;overflow:hidden;">
            <g:if test="${!( g.currentUserID().toLong() == friend.id )}">
                <a href="/user/show/${friend.id}">${friend.username}</a>
            </g:if>
        </div>
    </div>
</div>
