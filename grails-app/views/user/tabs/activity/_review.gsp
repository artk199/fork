<%--g:set var="score" value="${new int[activity.score.score]}"/>
<g:set var="noscore" value="${new int[5-activity.score.score]}"/>
<img ngsrc="${g.createLink(absolute:true,uri:'/image/'+activity.score.place.images[0].id+'/mini')}" width="140px" height="140px" style="border: 1px solid #DDD;">

--%>

<div style="height:100px;">
    <div style="float:left; width:140px;height:140px;">
        <div style="float:left">
           <img src="http://www.parentcenterhub.org/wp-content/uploads/2014/03/No-Image-.jpg" width="140px" height="140px" style="border: 1px solid #DDD;">
        </div>
    </div>
    <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:35px; overflow:hidden;white-space: nowrap;text-overflow:ellipsis;">
        <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 30px;font-weight: bold; font-style: italic;">
            Napisał &bdquo;{{instance.title}}&rdquo;
        </h2>
    </div>
    <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:60px;overflow:hidden;">
        {{instance.review}}
    </div>
    <div style="float:right;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);text-align:right;margin-top:10px;">
        <div style="float:left;">
            <a ng-href="/place/show/{{instance.place_id}}">{{instance.place_name}}</a>
        </div>
        <stars active="{{true}}" amount="{{instance.score}}"></stars>
        <stars active="{{false}}" amount="{{5-instance.score}}"></stars>
    </div>
</div>
