forkApp.controller('editController', ['$scope', '$http', function($scope, $http) {

    $scope.editing = false;
    $scope.editFieldValue = '';
    $scope.notSet = false;
    $scope.default = 'No value';

    $scope.getValue = function(){
        if( $scope.notSet ){
            return $scope.default;
        }
        return $scope.fieldValue;
    }

    $scope.requestEdit = function() {

        var sendData = {
            value: $scope.editFieldValue,
            fieldName: $scope.fieldName
        };

        $http.post('/image/' + $scope.id, sendData)
            .success(function (data) {
                $scope.description = data.description;
                $scope.title = data.title;
                $scope.fieldValue = $scope.editFieldValue;
                $scope.editing = false;
                $scope.notSet = false;
            });

    }

}]);