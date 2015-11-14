/**
 * Created by sirke on 13.11.2015.
 */
forkApp.controller('profileController', ['$scope', '$window', function($scope, $window) {


    $scope.verticalLayout;
    $scope.horizontalOffset = 200;
    $scope.horizontalMargins = 60;
    $scope.minimumWidth = 768;

    $scope.calculateWidth = function(maximumWidth){
        return maximumWidth - $scope.horizontalOffset - $scope.horizontalMargins;
    }

    $scope.switchLayout = function(){
        console.log( $window.innerWidth );
        if(  $window.innerWidth < $scope.minimumWidth ){
            $scope.verticalLayout = true;
        }
        else{
            $scope.verticalLayout = false;
        }
    }

}]);