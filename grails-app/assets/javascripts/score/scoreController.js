forkApp.controller('ScoreController', ['$scope', '$location', '$http', function( $scope, $location, $http ){

    $scope.placeId = -1;
    $scope.url = "";
    $scope.data = {};
    $scope.scores = [];
    $scope.submitted = false;
    $scope.hovered = 0;

    $scope.init = function(id){
        var url = $location.absUrl().toString();
        var ind = url.indexOf('place');
        url = url.substring(0, ind + 'place'.length);

        $scope.id = id;
        $scope.url = url + '/' + id + '/score';

        $scope.data.score = 0;

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



    $scope.scoreCount = function(score){
        return new Array(score);
    }

    $scope.getPicture = function(score){
        if ( score.owner.profilePicture != null ){
            return "/image/" + score.owner.profilePicture;
        }
        return "http://icenz.org/wp-content/themes/twentyfifteen/img/no-img.jpg";
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