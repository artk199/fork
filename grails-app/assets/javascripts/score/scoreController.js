forkApp.controller('ScoreController', ['$scope', '$location', '$http', function( $scope, $location, $http ){

    $scope.placeId = -1;
    $scope.data = {};
    $scope.empty = false;
    $scope.submitted = false;
    $scope.hovered = 0;
    $scope.instance = {};
    $scope.errors = [];

    $scope.init = function(id){
        $scope.id = id;

        $scope.data.score = 0;

        $http.get("/place/"+$scope.id+"/metascore").success(function(data) {
            $scope.empty = data['empty'];
            $scope.submitted = data['submitted'];
            $scope.instance = data['score'];
        });
    }

    $scope.addScore = function(){
        $scope.errors = [];
        $http.post("/place/"+$scope.id+"/score", $scope.data). success(function(data) {
            $scope.empty = false;
            $scope.submitted = true;
            $scope.instance = data;
        }).error( function( data, status ){
            $scope.errors = data;
        });
    }



    $scope.scoreCount = function(score){
        return new Array(score);
    }

}]);

forkApp.directive('star', function(){
    return {
        link: function(scope, element, attrs) {

            var score = attrs['star'];

            element.bind('click', function () {
                scope.$apply( function (){
                   scope.data.score = score;
                });
            });
            element.bind('mouseover', function(){
                scope.$apply( function (){
                    scope.hovered = score;
                });
            });

            element.bind('mouseout', function(){
                scope.$apply( function (){
                    scope.hovered = 0;
                });
            });

            scope.$watch( function(){
                return scope.hovered;
            }, function( hoverscore ) {
                if( hoverscore >= score ){
                    element.addClass('hover-score');
                }
                else{
                    element.removeClass('hover-score');
                }
            });

            scope.$watch( function(){
                return scope.data.score;
            }, function( newscore ) {
                if( newscore >= score ){
                    element.addClass('new-score');
                }
                else{
                    element.removeClass('new-score');
                }
            });


        }
    }
});

forkApp.directive( 'stars', function() {
    return{
        restrict: 'E',
        scope: {
            active: '@',
            amount: '@'
        },
        controller: ['$scope', function($scope) {

            $scope.newArray = function(){
                var number = parseInt($scope.amount);
                if(isNaN(number)){
                    return 0;
                }
                return new Array(parseInt(number));
            }

            $scope.isActive = function(){
                if( $scope.active == "true" ){
                    return true;
                }
                return false;
            }

        }],
        template: "<span ng-repeat='score in newArray() track by $index' class='glyphicon glyphicon-star fork-star' ng-class='{active: isActive()}'></span>"
    }
});
