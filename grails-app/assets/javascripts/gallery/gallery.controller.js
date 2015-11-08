forkApp.controller('galleryController', ['$scope', '$http', function($scope, $http) {

    $scope.readyToRead = false;
    $scope.readyToReverse = false;
    $scope.images = [];
    $scope.maxDimension = 200;
    $scope.selectedImage = -1;
    $scope.hovered = false;
    $scope.dropdown = false;
    $scope.overImage = false;
    $scope.addHovered = false;

    $scope.requestImages = function() {
        $http.get('/user/' + $scope.id + '/image')
            .success(function (data) {
                $scope.images = data;
            });
    }

    $scope.getSelectedUrl = function(){
        return '/user/'+$scope.id+'/image/'+$scope.images[$scope.selectedImage];
    }

    $scope.isSelected = function() {
        if ($scope.selectedImage != -1) {
            return true;
        }
        return false;
    }


    $scope.toggleDropdown = function(){
        $scope.dropdown = !$scope.dropdown;
    }

    $scope.showDropdown = function(){
        return $scope.dropdown;
    }

}]);