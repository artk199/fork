var forkApp = angular.module('forkApp', []);


forkApp.directive('searchInput', function($http, $q) {
    return {
        restrict: 'E',
        controller: ['$scope', function($scope) {

            $scope.searchValue = "Wprowadź nazwę atrakcji...";
            $scope.isDefault = true;
            $scope.focused = false;
            $scope.inputHeight = 0;
            $scope.inputWidth = 0;
            $scope.resultHeight = 0;
            $scope.searchResults = [];


            $scope.showResult = function(){
                if( $scope.focused && !$scope.isDefault && $scope.searchValue.length > 0 ){
                    return true;
                }
                return false;
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
        "   <div class='fork-content-main-search-result' ng-repeat='place in searchResults' on-finish-render>" +
        "       <div class='fork-content-main-search-result'>{{place.name}}</div>" +
        "       <div class='fork-content-main-search-result-small'>{{place.description}}</div>" +
        "   </div>" +
        "</div>",

    };
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