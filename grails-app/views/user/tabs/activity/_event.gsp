<div style="height:100px;">
    <div style="float:left; width:140px;height:140px;">
        <div style="float:left">
            <img src="http://www.parentcenterhub.org/wp-content/uploads/2014/03/No-Image-.jpg" width="140px" height="140px" style="border: 1px solid #DDD;">
        </div>
    </div>
    <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:35px; overflow:hidden;white-space: nowrap;text-overflow:ellipsis;">
        <h2 style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 30px;font-weight: bold; font-style: italic;">
            <a ng-href="/event/show/{{instance.event}}" >Dołączył do wydarzenia {{ instance.event_name }}</a>
        </h2>
    </div>
    <div style="float:left;text-align:left; margin-left: 10px;width: -moz-calc(100% - 160px);width: -webkit-calc(100% - 160px); width: calc(100% - 160px);height:60px;overflow:hidden;">
        Miejsce wydarzenia: {{ instance.event_place }} <br/>
        Data rozpoczęcia wydarzenia: {{ instance.event_date | date: 'yyyy-MM-dd' }}
    </div>
</div>
