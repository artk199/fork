<div class="user-panel" user-panel>
    <div style="height: 20px">
        <div class="container">
            <div class="row text-left" style="margin-top:10px">
                <div class="col-md-12" style="height:160px;cursor:default;">
                    <span style="margin-bottom:5px; display:block;">Witaj użytkowniku</span>
                    <span style="margin-bottom:5px; display:block;">Nowa aktywność znajomych: {{activities}}</span>
                    <span style="margin-bottom:5px; display:block;">Nowe zaproszenia do znajomych: {{invites}}</span>
                    <span style="margin-bottom:5px; display:block;">Nowi znajomi: {{friends}}</span>
                </div>
                <a href="/user/show/${g.currentUserID()}">
                    <div class="col-md-12" style="border-top: black solid 1px;height: 39px; text-align: center; line-height:39px;">
                        Odwiedź swój profil
                    </div>
                </a>
            </div>
        </div>
        <div style="color:#A2A2A2; display:inline-block; font-size:52px;position:relative; top:-16px; float:right;cursor:default;left:-4px;">
            <i class="fi-torso"></i>
        </div>
        <div style="color:black; display:inline-block; font-size:20px;position:relative; top:-207px; float:right;cursor:default;left:-15px;">
            <span ng-show="notifications.length > 0">{{notifications.length}}</span>
        </div>
    </div>
</div>