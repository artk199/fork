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
    $scope.openDialog = false;
    $scope.progress = '0%';
    $scope.uploading = false;

    $scope.description = "";
    $scope.title = "";

    $scope.requestImages = function() {
        $http.get('/user/' + $scope.id + '/image')
            .success(function (data) {
                $scope.images = data;
            });
    }

    $scope.getSelectedUrl = function(){
        return '/image/'+$scope.images[$scope.selectedImage];
    }

    $scope.requestDetails = function(){
        $http.get('/image/' + $scope.images[$scope.selectedImage] + '/details')
            .success(function (data) {
                $scope.description = data.description;
                $scope.title = data.title;
            });
    }

    $scope.deleteImage = function(){
        $http.delete('/image/' + $scope.images[$scope.selectedImage])
            .success( function (){
                var removed = $scope.selectedImage;
                $scope.selectedImage = -1;
                $scope.images.splice(removed, 1);
                $scope.toggleDropdown();
            });
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