forkApp.controller('ScoreController', ['$scope', '$location', '$http', function( $scope, $location, $http ){

    $scope.placeId = -1;
    $scope.url = "";
    $scope.data = {};
    $scope.scores = [];
    $scope.submitted = false;

    $scope.init = function(id){
        var url = $location.absUrl().toString();
        var ind = url.indexOf('place');
        url = url.substring(0, ind + 'place'.length);

        $scope.id = id;
        $scope.url = url + '/' + id + '/score';

        $http.get($scope.url). success(function(data, status, headers, config) {
            $scope.scores = data;
            console.log(data);
        });
    }

    $scope.noScores = function(){
        if( $scope.scores.length == 0 ){
            return true;
        }
        return false;
    }

    $scope.notSubmitted = function(){
        if( $scope.submitted ){
            return false;
        }
        return true;
    }

    $scope.addScore = function(){
        $http.post($scope.url, $scope.data). success(function(data, status, headers, config) {
            $scope.scores.push(data);
            $scope.submitted = true;
        });
    }

}]);