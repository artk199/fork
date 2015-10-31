var forkApp = angular.module('forkApp', []);


forkApp.directive('searchInput', function($http, $window, $location) {
    return {
        restrict: 'E',
        controller: ['$scope', function($scope) {

            $scope.searchValue = "Wprowadź nazwę atrakcji...";
            $scope.isDefault = true;
            $scope.focused = false;
            $scope.resultsFocused = false;
            $scope.inputHeight = 0;
            $scope.inputWidth = 0;
            $scope.resultHeight = 0;
            $scope.searchResults = [];
            $scope.maxResults = 4;

            $scope.showResult = function(){
                if( ( $scope.focused && !$scope.isDefault && $scope.searchValue.length > 0 ) || $scope.resultsFocused){
                    return true;
                }
                return false;
            }

            $scope.showAllResults = function(){
                var baseUrl = $location.absUrl().toString();
                $window.location.href = baseUrl+'place/search/all?search='+$scope.searchValue;
            }

            $scope.showDetails= function(id){
                var baseUrl = $location.absUrl().toString();
                $window.location.href = baseUrl+'place/'+id;
            }

            $scope.bottomPosition = function(){
                return -($scope.inputHeight + $scope.resultHeight ) + 'px';
            }

            $scope.widthLength = function(){
                return $scope.inputWidth + 'px';
            }

            $scope.update = function(height){
                $scope.resultHeight = height;
            }

            $scope.moreResults = function(){
                if( $scope.searchResults.length > $scope.maxResults) {
                    return true;
                }
                return false;
            }

        }],
        link: {
            post: function(scope,element){

                scope.inputWidth = element.children().prop('offsetWidth');

                element.bind('focusin', function(e){
                    scope.$apply(function() {
                        scope.focused = true;
                    });
                    scope.$apply(function() {
                        scope.resultHeight = element.children().next().prop('offsetHeight');
                        scope.inputHeight = element.children().prop('offsetHeight');
                    });

                });
                element.bind('focusout', function(e){
                    scope.$apply(function() {
                        scope.focused = false;
                    });
                    scope.$apply(function() {
                        scope.resultHeight = element.children().next().prop('offsetHeight');
                        scope.inputHeight = element.children().prop('offsetHeight');
                    });
                });
                element.bind('click', function(e){
                    if( scope.isDefault ) {
                        scope.$apply(function() {
                            scope.searchValue = '';
                            scope.isDefault = false;
                        });
                    }
                });
                element.bind('input', function(e){
                    $http.get('/place/search', { params: { search : scope.searchValue } } )
                        .success(function(data){
                            scope.searchResults = data;
                            scope.resultHeight = element.children().next().prop('offsetHeight');
                            scope.inputHeight = element.children().prop('offsetHeight');
                        });
                });
            }
        },
        template:"<input type='text' class='fork-content-main-search-field' ng-model='searchValue'/>" +
        "<div ng-show='showResult()' ng-style='{bottom: bottomPosition(), width:widthLength()}' class='fork-content-main-search-results' search-results>" +
        "   <div class='fork-content-main-search-result' ng-repeat='place in searchResults | limitTo:maxResults' ng-click='showDetails(place.id)' on-finish-render>" +
        "       <div class='fork-content-main-search-result'>{{place.name}}</div>" +
        "       <div class='fork-content-main-search-result-small'>{{place.description}}</div>" +
        "   </div>" +
        "   <div ng-show='moreResults()' class='fork-content-main-search-more' ng-click='showAllResults()'>" +
        "       <small>Lub znajdź więcej<span class='glyphicon glyphicon-arrow-right'></span></small>" +
        "   </div>" +
        "</div>",

    };
});

forkApp.directive('searchResults', function () {
    return {
        restrict: 'A',
        link: function (scope, element) {
            element.bind('mouseenter', function(){
                scope.$apply(function() {
                    scope.resultsFocused = true;
                });
            });
            element.bind('mouseleave', function(){
                scope.$apply(function() {
                    scope.resultsFocused = false;
                });
            });
        }
    }
});

forkApp.directive('onFinishRender', function () {
    return {
        restrict: 'A',
        link: function (scope, element) {
            if (scope.$last === true) {
                element.ready(function () {
                    scope.$apply(function () {
                        scope.update(element.parent().prop('offsetHeight'));
                    });
                    scope.$apply();
                });
            }
        }
    }
});



forkApp.directive('tileImage', function($window, $location){
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

            $scope.showOverlay = function(){
                if($scope.overlay && $scope.images.length > 1 ) {
                    return true;
                }
                return false;
            }

            $scope.images = ['http://www.demilked.com/magazine/wp-content/uploads/2014/03/zoomed-out-landmarks-2-1.jpg', 'http://theclassytraveler.com/wp-content/uploads/2013/01/Paris-France-Landmarks-Arc-De-Triomphe-1.jpg' , 'http://designlike.com/wp-content/uploads/2011/12/Giza-Pyramids1-600x450.jpg']

        }],
        link: function (scope, element) {
            var top = element[0].getBoundingClientRect().top;
            var left = element[0].getBoundingClientRect().left;
            var doc = element[0].ownerDocument;
            var offY = $window.pageYOffset;
            var offX = $window.pageXOffset;
            var cTop = doc.documentElement.clientTop;
            var cLeft = doc.documentElement.clientLeft;

            scope.top = top + offY - cTop;

            scope.left = left + offX - cLeft;

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
                    $window.location.href = baseUrl.substring(0,baseUrl.indexOf('index')) + 'show/' + scope.id;
                }
                scope.blockEvent = false;

            });
        },
        template:"<div class='fork-tile-image-container'>" +
        "           <img class='fork-tile-image' data-ng-src='{{images[currentPicture]}}'>" +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(1)}' tile-image-left></div> " +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(2) }' tile-image-right></div>" +
        "         </div>"
    }
});

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