forkApp.directive('searchInput', ['$http', '$window' , '$location', function($http, $window, $location) {
    return {
        restrict: 'E',
        scope: { controller: '@', value: '@' },
        controller: ['$scope', function($scope) {

            $scope.searchValue = $scope.value;
            $scope.isDefault = true;
            $scope.focused = false;
            $scope.resultsFocused = false;
            $scope.inputWidth = 0;
            $scope.searchResults = [];
            $scope.maxResults = 4;
            $scope.top = 0;

            $scope.showResult = function(){
                if( ( $scope.focused && !$scope.isDefault && $scope.searchValue.length > 0 ) || $scope.resultsFocused){
                    return true;
                }
                return false;
            }

            $scope.showAllResults = function(){
                var baseUrl = $location.absUrl().toString();
                $window.location.href = baseUrl+$scope.controller+'/search/all?search='+$scope.searchValue;
            }

            $scope.showDetails= function(id){
                var baseUrl = $location.absUrl().toString();
                $window.location.href = baseUrl+$scope.controller+'/show/'+id;
            }

            $scope.topPosition = function(){
                return $scope.top + 'px';
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
                scope.top = element.parent().offset().top + element.parent()[0].getBoundingClientRect().height - $(window).scrollTop();

                $(window).bind('scroll', function(){
                    scope.$apply( function(){
                        scope.top = element.parent().offset().top + element.parent()[0].getBoundingClientRect().height - $(window).scrollTop();
                    });
                });


                element.bind('focusin', function(e){
                    scope.$apply(function() {
                        scope.focused = true;
                    });

                });
                element.bind('focusout', function(e){
                    scope.$apply(function() {
                        scope.focused = false;
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
                    $http.get('/'+scope.controller+'/search', { params: { search : scope.searchValue } } )
                        .success(function(data){
                            scope.searchResults = data;
                        });
                });
            }
        },
        template:"<input type='text' class='fork-content-main-search-field' ng-model='searchValue'/>" +
        "<div ng-show='showResult()' style='position:fixed;' ng-style='{top:topPosition(), width:widthLength()}' class='fork-content-main-search-results' search-results>" +
        "   <div class='fork-content-main-search-result' ng-repeat='place in searchResults | limitTo:maxResults' ng-click='showDetails(place.id)'>" +
        "       <div class='fork-content-main-search-result'>{{place.name}}</div>" +
        "       <div class='fork-content-main-search-result-small'>{{place.description}}</div>" +
        "   </div>" +
        "   <div ng-show='moreResults()' class='fork-content-main-search-more' ng-click='showAllResults()'>" +
        "       <small>Lub znajdź więcej<span class='glyphicon glyphicon-arrow-right'></span></small>" +
        "   </div>" +
        "</div>",

    };
}]);

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