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
                            $scope.images.push("/assets/no-image.jpg");
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
