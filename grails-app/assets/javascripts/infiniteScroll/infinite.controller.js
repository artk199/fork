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

        var link = $scope.link;

        if( link.indexOf('?') > -1 ){
            link = link + '&offset='+$scope.list.length+'&max='+$scope.amount
        }
        else{
            link = link + '?offset='+$scope.list.length+'&max='+$scope.amount
        }

        $http.get(link)
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

    $scope.$watch( function(){ return $scope.link; } , function(newLink, oldLink){
        if(newLink != oldLink){
            $scope.noMoreData = false;
            $scope.blockLoading = true;
            $scope.list = [];
            $scope.requestList();
        }
    })

}]);