//= require_self
//= require gallery/gallery.controller.js
//= require gallery/gallery.directives.js

var forkApp = angular.module('forkApp', ['ngAnimate']);

forkApp.directive('tileImage', [ '$window', '$location', '$timeout', function($window, $location, $timeout){
    return {
        restrict: 'E',
        scope: {
            id: '@'
        },
        controller: ['$scope', function($scope) {
            $scope.currentPicture = 0;
            $scope.overlay = false;
            $scope.top = 0;
            $scope.left = 0;
            $scope.blockEvent = false;

            $scope.getTop = function(){
                return $scope.top + 'px';
            }

            $scope.getLeft = function(mode){
                if( mode == 1 ){
                    return $scope.left + 'px';
                }
                else if ( mode == 2 ){
                    return $scope.left + 150 + 'px';
                }
            }

            $scope.shiftLeft = function(){
                if( $scope.currentPicture == 0 ){
                    $scope.currentPicture = $scope.images.length - 1;
                }
                else{
                    $scope.currentPicture--;
                }
            }

            $scope.shiftRight = function(){
                if( $scope.currentPicture == $scope.images.length - 1 ){
                    $scope.currentPicture = 0;
                }
                else{
                    $scope.currentPicture++;
                }
            }

            $scope.showOverlay = function(){
                if($scope.overlay && $scope.images.length > 1 ) {
                    return true;
                }
                return false;
            }

            $scope.images = ['http://www.demilked.com/magazine/wp-content/uploads/2014/03/zoomed-out-landmarks-2-1.jpg', 'http://theclassytraveler.com/wp-content/uploads/2013/01/Paris-France-Landmarks-Arc-De-Triomphe-1.jpg' , 'http://designlike.com/wp-content/uploads/2011/12/Giza-Pyramids1-600x450.jpg']

        }],
        link: function (scope, element) {
            /*var top = element[0].getBoundingClientRect().top; var left = element[0].getBoundingClientRect().left; var doc = element[0].ownerDocument; var offY = $window.pageYOffset; var offX = $window.pageXOffset; var cTop = doc.documentElement.clientTop; var cLeft = doc.documentElement.clientLeft;*/

            $timeout( function(){
                scope.$apply(function(){
                    scope.top = element.offset().top - $(window).scrollTop();
                    scope.left = element.offset().left;
                });
            });

            $(window).bind("scroll", function(){
                scope.$apply(function(){
                    scope.top = element.offset().top - $(window).scrollTop();
                    scope.left = element.offset().left;
                });
            });

            $(window).bind("resize", function(){
                scope.$apply(function(){
                    scope.top = element.offset().top - $(window).scrollTop();
                    scope.left = element.offset().left;
                });
            });

            element.bind('mouseover', function(){
                scope.$apply(function(){
                    scope.overlay = true;
                });
            });
            element.bind('mouseout', function(){
                scope.$apply(function(){
                    scope.overlay = false;
                });
            });
            element.bind('click', function(){
                if(document.selection && document.selection.empty) {
                    document.selection.empty();
                } else if($window.getSelection) {
                    var sel = $window.getSelection();
                    sel.removeAllRanges();
                }

                if( !scope.blockEvent ){
                    var baseUrl = $location.absUrl().toString();
                    $window.location.href = baseUrl.substring(0,baseUrl.indexOf('index')) + 'show/' + scope.id;
                }
                scope.blockEvent = false;

            });

        },
        template:"<div class='fork-tile-image-container'>" +
        "           <img class='fork-tile-image' data-ng-src='{{images[currentPicture]}}'>" +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(1)}' tile-image-left></div> " +
        "           <div ng-show='showOverlay()' ng-style='{top: getTop(), left: getLeft(2) }' tile-image-right></div>" +
        "         </div>"
    }
}]);

forkApp.directive('tileImageLeft', function(){
    return {
        restrict: 'A',
        link: function (scope, element){
            element.bind('click', function(){
                scope.$apply(function(){
                    scope.blockEvent = true
                    scope.shiftLeft();
                });
            });
        }
    }
});

forkApp.directive('tileImageRight', function(){
    return {
        restrict: 'A',
        link: function (scope, element){
            element.bind('click', function(){
                scope.$apply(function(){
                    scope.blockEvent = true;
                    scope.shiftRight();
                });
            });
        }
    }
});

forkApp.directive('tileScore', function() {
    return {
        restrict: 'E',
        scope: {
            score: '@'
        },
        controller: ['$scope', function($scope) {
            $scope.getNumbers = function(num){
                return new Array(Math.floor(num));
            }

            $scope.getWidth = function(num){
                if( $scope.score >= num ){
                    return '100%';
                }
                if( num - $scope.score < 1 ){
                    return (num-$scope.score) * 100+'%';
                }
                return '0%';
            }
        }],
        template:"<div ng-repeat='i in getNumbers(5) track by $index' class='fork-tile-score'>" +
        "           <div ng-style='{width: getWidth($index+1)}'></div>" +
        "         </div>"
    }
});



forkApp.directive('filterDate', function(){
   return {
       restrict: 'A',
       scope: {
           placeholder: '@'
       },
       link: function (scope, element){
           element.datetimepicker({
               timepicker:false,
               format:'Y/m/d',
               maxDate:'0'
           });
       }
   }
});




forkApp.directive('userPanel', ['$animate', function($animate) {
    return {
        link: function(scope, element){
            scope.state = false;
            var className = 'open';
            element.bind('click', function(){
                scope.$apply(function(){
                    if( scope.state ){
                        $animate.removeClass(element, className);
                    }
                    else{
                        $animate.addClass(element,className);
                    }
                    scope.state = !scope.state;
                });

            });
        }
    }
}]);

forkApp.directive('fieldEdit', function(){
   return {
       restrict: 'E',
       controller: ['$scope', '$http', function($scope, $http) {
           $scope.editing = false;
           $scope.editFieldValue = '';
           $scope.notSet = false;

           $scope.getValue = function(){
               if( $scope.notSet ){
                   return 'No title';
               }
               return $scope.fieldValue;
           }

           $scope.requestEdit = function() {

               var sendData = {
                   value: $scope.editFieldValue,
                   fieldName: $scope.fieldName
               };

               console.log(sendData);

               $http.post('/image/' + $scope.id, sendData)
                   .success(function (data) {
                       $scope.description = data.description;
                       $scope.title = data.title;
                       $scope.fieldValue = $scope.editFieldValue;
                       $scope.editing = false;
                       $scope.notSet = false;
                   });

               }

       }],
       scope: {
           fieldName: '@',
           fieldValue: '@',
           id: '@'
       },
       link: function(scope, element){
           scope.editFieldValue = scope.fieldValue;
           if( scope.fieldValue == "" ){
               scope.notSet = true;
           }

       },
       template:"<a field-pre-edit style='cursor:pointer;'>{{getValue()}}</a>" +
       "<input field-during-edit ng-model='editFieldValue' type='text' style='padding-right:80px;max-width: 84%;'/>" +
       "<span ng-show='editing' class='fork-accept-cancel'>" +
       "    <span accept-edit class='glyphicon glyphicon-ok'></span>" +
       "    <span cancel-edit class='glyphicon glyphicon-remove'></span>" +
       "</span>"
   }
});

forkApp.directive('fieldPreEdit', function(){
    return {
        link: function(scope, element){
            scope.$watch( function(){
                return scope.editing;
            }, function(editing){
                if( editing ){
                    element.addClass('ng-hide');
                }
                else{
                    element.removeClass('ng-hide');
                }
            } );

            element.bind('click', function(){
                scope.$apply( function(){
                    scope.editing = true;
                });
            });

        },
    }
});

forkApp.directive('fieldDuringEdit', function(){
    return {
        link: function(scope, element) {
            console.log('init');
            if (typeof scope.fieldValue !== 'undefined') {
                element.val(scope.fieldValue);
            }
            scope.$watch( function(){
                return scope.editing;
            }, function(editing){
                if( !editing ){
                    element.addClass('ng-hide');
                }
                else{
                    element.removeClass('ng-hide');
                }
            } );
        }
    }
});

forkApp.directive('cancelEdit', function(){
    return {
        link: function (scope, element) {
            element.bind('click', function(){
                scope.$apply( function(){
                    scope.editing = false;
                    scope.editFieldValue = '';
                });
            });
        }
    }
});

forkApp.directive('acceptEdit', function(){
    return {
        link: function (scope, element) {
            element.bind('click', function(){
                scope.requestEdit();
            });
        }
    }
});