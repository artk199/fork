
    <div class="fork-tile-container">
        <div style="width:100%;height:175px;display:table-cell; vertical-align:middle;">
            <a href="show/${event.id}" >
                <tile-image id="${event.place.id}"/>
            </a>
        </div>
        <a href="show/${event.id}" >
            <div style="width:100%;height:50px;width: 100%;font-weight: bold;font-size: 16px;">
                <tile-score score="0"></tile-score>
                <div style="margin-left: 10px; margin-right: 10px; overflow: hidden;">
                    ${event.title}
                </div>
            </div>
        </a>
    </div>