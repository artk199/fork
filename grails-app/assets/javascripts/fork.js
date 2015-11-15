//= require_self
//= require profile/profile.controller.js
//= require profile/profile.directives.js
//= require gallery/gallery.controller.js
//= require gallery/gallery.directives.js
//= require edit/edit.controller.js
//= require edit/edit.directives.js

var forkApp = angular.module('forkApp', ['ngAnimate']);

forkApp.directive('tileImage', [ '$window', '$location', '$timeout', '$http', function($window, $location, $timeout, $http){
    return {
        restrict: 'E',
        scope: {
            id: '@'
        },
        controller: ['$scope', function($scope) {
            $scope.currentPicture = 0;
            $scope.overlay = false;
            $scope.top = 0;
            $scope.left = 0;
            $scope.blockEvent = false;
            $scope.images = [];
            $scope.loaded = false;

            $scope.getTop = function(){
                return $scope.top + 'px';
            }

            $scope.getLeft = function(mode){
                if( mode == 1 ){
                    return $scope.left + 'px';
                }
                else if ( mode == 2 ){
                    return $scope.left + 150 + 'px';
                }
            }

            $scope.shiftLeft = function(){
                if( $scope.currentPicture == 0 ){
                    $scope.currentPicture = $scope.images.length - 1;
                }
                else{
                    $scope.currentPicture--;
                }
            }

            $scope.shiftRight = function(){
                if( $scope.currentPicture == $scope.images.length - 1 ){
                    $scope.currentPicture = 0;
                }
                else{
                    $scope.currentPicture++;
                }
            }

            $scope.requestImages = function(){
                $http.get('/place/' + $scope.id + '/image')
                    .success(function (data) {
                        if( data.length == 0 ){
                            $scope.images.push("http://www.parentcenterhub.org/wp-content/uploads/2014/03/No-Image-.jpg");
                        }
                        angular.forEach( data, function( image){
                            $scope.images.push('/image/'+image+'/mini');
                        });
                        $scope.loaded = true;
                    });
            }

            $scope.showOverlay = function(){
                if($scope.overlay && $scope.images.length > 1 ) {
                    return true;
                }
                return false;
            }

        }],
        link: function (scope, element) {
            /*var top = element[0].getBoundingClientRect().top; var left = element[0].getBoundingClientRect().left; var doc = element[0].ownerDocument; var offY = $window.pageYOffset; var offX = $window.pageXOffset; var cTop = doc.documentElement.clientTop; var cLeft = doc.documentElement.clientLeft;*/

            scope.requestImages();

            $(window).bind("scroll", function(){
                scope.$apply(function(){
                    scope.top = element.offset().top - $(window).scrollTop();
                    scope.left = element.offset().left;
                });
            });

            $(window).bind("resize", function(){
                scope.$apply(function(){
                    scope.top = element.offset().top - $(window).scrollTop();
                    scope.left = element.offset().left;
                });
            });

            element.bind('mouseover', function(){
                scope.$apply(function(){
                    scope.overlay = true;
                });
            });
            element.bind('mouseout', function(){
                scope.$apply(function(){
                    scope.overlay = false;
                });
            });
            element.bind('click', function(){
                if(document.selection && document.selection.empty) {
                    document.selection.empty();
                } else if($window.getSelection) {
                    var sel = $window.getSelection();
                    sel.removeAllRanges();
                }

                if( !scope.blockEvent ){
                    var baseUrl = $location.absUrl().toString();
                    $window.location.href = baseUrl.replace('/index','') + '/show/' + scope.id;
                }
                scope.blockEvent = false;

            });

            scope.$watch( function(){ return scope.loaded; }, function(isLoaded){
                if( isLoaded ) {
                    $timeout(function () {
                        scope.$apply(function () {
                            scope.top = element.offset().top - $(window).scrollTop();
                            scope.left = element.offset().left;
                        });
                    });
                }
            });

        },
        template:"<div class='fork-tile-image-container'>" +
        "           <img class='fork-tile-image' data-ng-src='{{images[currentPicture]}}' width='175px' height='175px'>" +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(1)}' tile-image-left></div> " +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(2) }' tile-image-right></div>" +
        "         </div>"
    }
}]);

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
        link: function(scope, element){
            scope.state = false;
            var className = 'open';
            element.bind('click', function(){
                scope.$apply(function(){
                    if( scope.state ){
                        $animate.removeClass(element, className);
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

forkApp.directive('imagePlace', [ '$timeout', function($timeout){
    return{
        link: function(scope, element, attrs){
            scope.place = {
                id: attrs['placeId'],
                name: attrs['placeName']
            }
        }
    }
}]);

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
