var forkApp = angular.module('forkApp', []);


forkApp.directive('searchInput', function($http) {
    return {
        restrict: 'E',
        controller: ['$scope', function($scope) {

            $scope.searchValue = "Wprowadź nazwę atrakcji...";
            $scope.isDefault = true;
            $scope.focused = false;
            $scope.inputHeight = 0;
            $scope.inputWidth = 0;
            $scope.searchResults = [];


            $scope.showResult = function(){
                if( $scope.focused && !$scope.isDefault && $scope.searchValue.length > 0 ){
                    return true;
                }
                return false;
            }

            $scope.topPosition = function(){
                return $scope.inputHeight + 'px';
            }

            $scope.widthLength = function(){
                return $scope.inputWidth + 'px';
            }

        }],
        link: {
            post: function(scope,element){
                scope.inputHeight = element.children().prop('offsetHeight') * 3 + 6;
                scope.inputWidth = element.children().prop('offsetWidth');
                element.bind('focusin', function(e){
                    scope.focused = true;
                    scope.$apply();
                });
                element.bind('focusout', function(e){
                    scope.focused = false;
                    scope.$apply();
                });
                element.bind('click', function(e){
                    if( scope.isDefault ) {
                        scope.searchValue = '';
                        scope.$apply();
                        scope.isDefault = false;
                    }
                });
                element.bind('input', function(e){
                    $http.get('/place/search', { params: { search : scope.searchValue } } )
                        .success(function(data){
                            scope.searchResults = data;
                        });
                });
            }
        },
        template:"<input type='text' class='fork-content-main-search-field' ng-model='searchValue'/>" +
        "<div ng-show='showResult()' ng-style='{top: topPosition(), width:widthLength()}' class='fork-content-main-search-results'>" +
        "   <div class='fork-content-main-search-result' ng-repeat='place in searchResults'>" +
        "       <div class='fork-content-main-search-result'>{{place.name}}</div>" +
        "       <div class='fork-content-main-search-result-small'>{{place.description}}</div>" +
        "   </div>" +
        "</div>",

    };
});