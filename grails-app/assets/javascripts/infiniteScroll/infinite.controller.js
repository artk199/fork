/**
 * Created by sirke on 13.11.2015.
 */
forkApp.controller('infiniteController', ['$scope', '$http', '$timeout', function($scope, $http) {

    $scope.link;
    $scope.amount;
    $scope.blockLoading = true;
    $scope.noMoreData = false;
    $scope.list = [];

    $scope.requestList = function(){
        $http.get($scope.link+'?offset='+$scope.list.length+'&max='+$scope.amount)
            .success( function(data){
                if( data.length < $scope.amount ){
                    $scope.noMoreData = true;
                }
                angular.forEach( data, function( element ){
                    $scope.list.push(element);
                });
                $scope.blockLoading = false;

            })
            .error( function(){
                $scope.blockLoading = false;
                $scope.noMoreData = true;
            });
    }

}]);