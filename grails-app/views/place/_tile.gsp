<div class="pull-left btn">
    <a ng-href="/place/show/{{instance.id}}" style="font-weight: bold;font-size: 16px;">{{instance.name}}</a>
    <div class="img-responsive">
        <tile-image id="{{instance.id}}"/>
    </div>
    <tile-score score="{{instance.avgScore}}"></tile-score>
</div>