<div class="pull-left btn">
    <span style="overflow:hidden;width:175px;display: block;">
        <a moving-text ng-href="/place/show/{{instance.id}}" style="font-weight: bold;font-size: 16px;">{{instance.name}}</a>
    </span>
    <div class="img-responsive">
        <tile-image id="{{instance.id}}"/>
    </div>
    <tile-score score="{{instance.avgScore}}"></tile-score>
</div>