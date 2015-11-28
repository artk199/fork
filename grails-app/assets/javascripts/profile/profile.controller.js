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
        if(  $window.innerWidth < $scope.minimumWidth ){
            $scope.verticalLayout = true;
        }
        else{
            $scope.verticalLayout = false;
        }
    }

}]);







forkApp.controller('friendsController', [ '$scope', '$http', function($scope, $http ){

    $scope.users = [];
    $scope.friends = [];
    $scope.requests = [];
    $scope.tab = 1;
    $scope.notAddedClass = 'glyphicon-plus-sign';
    $scope.requestedClass = 'glyphicon-question-sign';

    $scope.getFriends = function(){
        $http.get('/user/friend')
            .success ( function( data ){
                $scope.friends = data['friends'];
                $scope.requests = data['requests'];
                $scope.invitations = data['invitations'];
            });
    }

    $scope.findUsers = function(){
        $http.get('/user/search/?query='+$scope.query)
            .success( function( data ){
                $scope.users = data;
            });
    }

    $scope.addFriend = function(receiver){
        $http.post('/user/friend/'+$scope.users[receiver].id)
            .success( function(data){
                $scope.invitations.push( $scope.users[receiver] );
            });
    }

    $scope.modifyFriend = function(receiver, status, array){
        $http.put('/user/friend/'+$scope[array][receiver].id, { status: status}).success( function( data ){
            $scope[array].splice(receiver,1)
        });
    }

}]);
