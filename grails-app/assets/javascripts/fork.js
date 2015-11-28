//= require_self
//= require time/time.service.js
//= require time/time.directives.js
//= require infiniteScroll/infinite.controller.js
//= require infiniteScroll/infinite.directives.js
//= require profile/profile.controller.js
//= require profile/profile.directives.js
//= require gallery/gallery.controller.js
//= require gallery/gallery.directives.js
//= require edit/edit.controller.js
//= require edit/edit.directives.js
//= require quicksearch/directives.js
//= require score/scoreController.js


var forkApp = angular.module('forkApp', ['ngAnimate']);

forkApp.directive('tileImageLeft', function(){
    return {
        restrict: 'A',
        link: function (scope, element){
            element.bind('click', function(){
                scope.$apply(function(){
                    scope.blockEvent = true
                    scope.shiftLeft();
                });
            });
        }
    }
});

forkApp.directive('tileImageRight', function(){
    return {
        restrict: 'A',
        link: function (scope, element){
            element.bind('click', function(){
                scope.$apply(function(){
                    scope.blockEvent = true;
                    scope.shiftRight();
                });
            });
        }
    }
});

forkApp.directive('tileScore', function() {
    return {
        restrict: 'E',
        scope: {
            score: '@'
        },
        controller: ['$scope', function($scope) {
            $scope.getNumbers = function(num){
                return new Array(Math.floor(num));
            }

            $scope.getWidth = function(num){
                if( $scope.score >= num ){
                    return '100%';
                }
                if( num - $scope.score < 1 ){
                    return (num-$scope.score) * 100+'%';
                }
                return '0%';
            }
        }],
        template:"<div ng-repeat='i in getNumbers(5) track by $index' class='fork-tile-score'>" +
        "           <div ng-style='{width: getWidth($index+1)}'></div>" +
        "         </div>"
    }
});



forkApp.directive('filterDate', function(){
   return {
       restrict: 'A',
       scope: {
           placeholder: '@'
       },
       link: function (scope, element){
           element.datetimepicker({
               timepicker:false,
               format:'Y/m/d'
           });
       }
   }
});

forkApp.directive('filterDateAndTime', function(){
    return {
        restrict: 'A',
        scope: {
            placeholder: '@'
        },
        link: function (scope, element){
            element.datetimepicker({
                timepicker:true,
                format:'Y/m/d H:i'
            });
        }
    }
});




forkApp.directive('userPanel', ['$animate', function($animate) {
    return {
        controller: ['$scope', function($scope) {
            $scope.notifications = [];

            $scope.invites = 0;
            $scope.friends = 0;
            $scope.activities = 0;

            $scope.state = false;
        }],
        link: function(scope, element){
            var className = 'open';

            var socket = new SockJS('/stomp');
            var client = Stomp.over(socket);
            client.debug = null;

            client.connect({}, function() {
                client.subscribe("/user/queue/notification", function(message) {
                    scope.$apply(function() {
                        scope.notifications.push(message.body);
                        var jsonObj = JSON.parse(message.body);
                        switch(jsonObj.values[0]){
                            case 'friendInvite':
                                scope.invites++;
                                break;
                            case 'friend':
                                scope.friends++;
                                break;
                            case 'activity':
                                scope.activities++;
                                break;
                        }
                    });
                });
            });


            element.bind('click', function(){
                scope.$apply(function(){
                    if( scope.state ){
                        $animate.removeClass(element, className);
                        scope.notifications = [];
                        scope.invites = 0;
                        scope.friends = 0;
                        scope.events = 0;
                    }
                    else{
                        $animate.addClass(element,className);
                    }
                    scope.state = !scope.state;
                });

            });
        }
    }
}]);


forkApp.controller('visibilityController', ['$scope', function($scope){

    $scope.visibility = 'public';

    $scope.setVisibility = function(visibility){
        $scope.visibility = visibility;
    }

    $scope.isActive = function(visibility){
        if( $scope.visibility == visibility ){
            return { background: '#96a682'};
        }
        return {};
    }

    $scope.isVisible = function(visibility){
        if( $scope.visibility == visibility ){
            return true;
        }
        return false;
    }

}]);

forkApp.directive('changeUrl', [ '$window', function($window){
    return{
        link: function(scope, element, attrs) {
            element.bind('click', function () {
                $window.location.href = attrs['changeUrl'];
            });
        }
    }
}]);



forkApp.controller('imageController', [ '$timeout', '$scope', '$http', '$window', function($timeout, $scope, $http, $window){

    $scope.show = false;
    $scope.place= null;
    $scope.isProfile = false;

    $scope.showPlace = function(){
        if( $scope.place != null ){
            return true;
        }
        return false;
    }


    $scope.deleteImage = function(url){
        $http.delete(url, { headers : { 'Accept':'text/html'}})
            .success( function (data){
               $window.location.href = data
            });
    }
    $scope.setProfile = function(url){
        if( !$scope.isProfile )
        $http.post(url)
            .success( function (data){
                $scope.isProfile = true;
            });
    }

}]);

forkApp.directive('imagePlace', function(){
    return{
        link: function(scope, element, attrs){
            scope.place = {
                id: attrs['placeId'],
                name: attrs['placeName']
            }
        }
    }
});

forkApp.directive('popup', function(){

    return {
        restrict: 'E',
        controller: ['$scope', function($scope) {

            $scope.popup = false;

            /*
             */

            $scope.isPopupAvailable = function(){
                if( $scope.show ){
                    document.body.style.overflow = 'hidden';
                }
                else{
                    document.body.style.overflow = 'auto';
                }
                return $scope.show;
            }
            $scope.closePopup = function(){
                $scope.show = false;
            }


        }],
        scope: {
            returned: '=',
            show: '='
        },
        transclude: true,
        template: "<div ng-show='isPopupAvailable()' class='fork-popup-container ng-hide'>" +
        "               <div class='fork-popup-shadow'></div>" +
        "               <div ng-show='isPopupAvailable()' class='fork-popup'> " +
        "                   <div class='row' style='height:100%;'>" +
        "                       <div class='col-md-3 col-sm-2 col-xs-1' style='height:1px;'></div>" +
        "                       <div class='col-md-6 col-sm-8 col-xs-10 fork-popup-content-wrapper'>" +
        "                           <div class='fork-close-popup' ng-click='closePopup()'><span class='glyphicon glyphicon-remove'></span></div>" +
        "                               <ng-transclude></ng-transclude>" +
        "                           </div>" +
        "                       <div class='col-md-3 col-sm-2 col-xs-1' style='height:1px;'></div>" +
        "                   </div>" +
        "               </div>"+
        "           </div>"
    }

});


forkApp.directive('linkController', function(){
    return {
        controller:['$scope', '$http', function($scope, $http){

            $scope.places = [];
            $scope.searchValue = "";
            $scope.image = -1;

            $scope.init = function(){
                $http.get("/place")
                    .success( function (data){
                        $scope.places = data;
                    });
            }

            $scope.search = function(){
                $http.get('/place/search', { params: { search : $scope.searchValue } } )
                    .success(function(data){
                        $scope.places = data;
                    });
            }

            $scope.link = function(index){

                var sendData = { image: $scope.image };

                $http.post("/place/"+$scope.places[index].id+'/link',sendData)
                    .success(function(data){
                        $scope.$parent.show = false;
                        $scope.$parent.returned = { name: $scope.places[index].name, id: $scope.places[index].id } ;
                        document.body.style.overflow = 'auto';
                    });

            }

        }],
        link: function(scope, element, attrs){
            scope.image = attrs['image'];
            scope.init();
        }
    }
});

forkApp.directive('placeLink', function(){
    return{
        link: function(scope, element){
            if( ! scope.$last ){
                element.css('border-bottom', 'none');
            }
            element.bind('click', function(){
                scope.$apply(function(){
                    scope.link(scope.$index);
                });
            });
        }
    }
});

forkApp.directive('searchSelect', function(){
    return {
        restrict: 'A',
        scope: {
            placeholder: '@'
        },
        link: function (scope, element){
            element.select2();
        }
    }
});

forkApp.directive('movingText', [ '$interval', '$timeout', function($interval, $timeout){
    return {
        link: function(scope, element){
            var left = 0;
            var goLeft = true;
            var intervalFunc;

            var move = function(){
                if( goLeft ){
                    left--;
                }
                else{
                    left++;
                }
                if( left+$(element).width()-$(element).parent().width() + 10 == 0){
                    goLeft = false;
                }
                else if ( left == 10 ){
                    goLeft = true;
                }
                element.css('left', left + 'px');
            }
            $timeout( function() {
                if ($(element).width() > $(element).parent().width()) {
                    element.css('position', 'relative');
                    element.bind('mouseover', function () {
                        intervalFunc = $interval(move, 15);
                    });
                    element.bind('mouseleave', function () {
                        $interval.cancel(intervalFunc);
                    });
                }
            });
        }
    }
}]);


forkApp.directive('dynamicFiltering', function(){
   return{
       link: function(scope, element){
           element.bind('submit', function(event){
               event.preventDefault();
               scope.$apply( function (){
                   scope.dynamicURL = '?'+$(element).serialize();
               });
           });
       }
   }
});

forkApp.controller('placesController', [ '$scope', function($scope){

    $scope.baseURL = 'place/all';
    $scope.dynamicURL = '';
}]);