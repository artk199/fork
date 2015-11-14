<div class="row" >
    <div ng-controller="profileController" class="col-md-12 profile-container">
        <div profile-image style="border: 1px #DDD solid">
            <div style="width:198.4px;float:left;height:200px;padding:0px;border-bottom: 1px #DDD solid;">
                <g:if test="${this.user.profilePicture}">
                    <img src="/image/${this.user.profilePicture.id}" width="100%" height="100%" />
                </g:if>
                <g:else>
                    <img src="http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg" width="100%" height="100%" />
                </g:else>
            </div>
            <div style="min-width:200px;float:left;height: 100%;">
                <div class="fork-profile-button">Edytuj informacje </div>
                <div class="fork-profile-button">Edytuj konto </div>
                <div class="fork-profile-button">Edytuj prywatbisc </div>
            </div>
        </div>
        <div profile-details style="padding-right:20px;">
            <div class='col-md-12' style="height:800px; border: 1px #DDD solid;">
                <div>
                    <div class="row">
                        <div class="col-md-12">
                            <h2 style="text-align:left;">Twoje ostatnie recenzje</h2>
                        </div>
                        <g:each in="${this.user.scores}" var="score">
                            <div class="col-md-12" style="border-bottom: 1px #DDD solid">
                                <div style="text-align:left; margin-left:30px;">
                                    <sppan style="font-family: times, Times New Roman, times-roman, georgia, serif;color: #444;margin: 0;padding: 0px 0px 6px 0px;font-size: 25px;font-weight: bold; font-style: italic;">
                                    &bdquo;${score.title}&rdquo;
                                    </sppan> z oceną
                                     ${score.score} gwiazdek dla
                                    <a href="/place/show/${score.place.id}">${score.place.name}</a>
                                </div>

                            </div>
                        </g:each>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
