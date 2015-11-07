var forkApp = angular.module('forkApp', ['ngAnimate']);

forkApp.directive('tileImage', [ '$window', '$location', function($window, $location){
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
            var top = element[0].getBoundingClientRect().top;
            var left = element[0].getBoundingClientRect().left;
            var doc = element[0].ownerDocument;
            var offY = $window.pageYOffset;
            var offX = $window.pageXOffset;
            var cTop = doc.documentElement.clientTop;
            var cLeft = doc.documentElement.clientLeft;

            scope.top = top + offY - cTop;

            scope.left = left + offX - cLeft;

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



forkApp.directive('userImages', function(){
    return {
        restrict: 'E',
        controller: ['$scope', '$http', function($scope, $http) {

            $scope.readyToRead = false;
            $scope.readyToReverse = false;
            $scope.images = [];
            $scope.maxDimension = 200;
            $scope.selectedImage = -1;
            $scope.hovered = false;
            $scope.dropdown = false;

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


        }],
        scope: { id : '@'},
        link: function(scope, element){
            scope.requestImages();
        },
        template: "<div class='row' style='padding-top:10px; margin-left: 15px; margin-right:25px;'>" +
        "               <div class='col-md-12' style='padding:0px; margin:10px; margin-bottom:0px;overflow-x:auto;overflow-y:hidden;' ng-show='isSelected()'>" +
        "                   <img full-image ng-src='{{getSelectedUrl()}}'/>" +
        "               </div> " +
        "               <div class='col-md-12' style='height:100px; border-bottom: 1px solid #DDD; box-shadow:0px -6px 3px -4px #DDD inset; z-index:5;' ng-show='isSelected()'>" +
        "                   <div class='dropdown pull-right fork-cog'>" +
        "                       <span toggle-dropdown class='glyphicon glyphicon-cog'></span>" +
        "                       <div ng-show='showDropdown()'>" +
        "                           <div><a ng-href='/image/{{images[selectedImage]}}/link'>Powiąż z miejscem</a></div>" +
        "                           <div><a ng-href='/image/{{images[selectedImage]}}/edit'>Edytuj</a></div>" +
        "                           <div><a ng-href='/image/{{images[selectedImage]}}/delete'>Usuń</a></div>" +
        "                       </div>" +
        "                   </div>" +
        "                   <div style='float:left'>" +
            "                   <h2> Image title </h2>" +
            "                   <span>Image description</span>" +
    "                       </div>" +
        "               </div>" +
        "               <div class='col-md-12'>" +
            "               <div user-image-wrapper style='position:relative;display:inline-block; margin: 5px;' ng-repeat='image in images'>" +
            "                   <img ng-style='imageStyle()' style='border:1px black solid;' ng-src='/user/{{id}}/image/{{image}}' user-image/>" +
        "                       <div ng-style='overlayStyle()' style='position:absolute; background-color: white; top:0; left:0; width:100%; pointer-events: none; height:100%;'></div>"+
            "               </div>" +
        "               </div>"+
        "          </div>"
    }
});

forkApp.directive('userImage',  ['$timeout', function($timeout) {
    return {
        controller: ['$scope', function($scope) {

            $scope.imageStyle = function(){
                if( $scope.$index == $scope.selectedImage ) {
                    return { cursor: 'default'};
                }
                return { cursor: 'pointer'};

            }

        }],
        link: function (scope, element, attrs) {

            $timeout(function () { //Without specifying delay this method will fire after full render is complete

                if( scope.$first ){ //We want to make image visible before getting its dimensions otherwise they are always 0 and 0
                    var elementIterator = element.parent().parent();
                    var counter = 0;
                    while( elementIterator[0].getBoundingClientRect().width == 0 && elementIterator[0].getBoundingClientRect().height == 0 ){
                        elementIterator.css('display','block');
                        elementIterator = elementIterator.parent();
                        counter++;
                    }
                    scope.$parent.readyToRead = true;
                    scope.$parent.counter = counter;
                }

                var watcher = scope.$watch( function(){ return scope.$parent.readyToRead; } , function(newVal) {
                    if( newVal ) {

                        var newImg = new Image();

                        newImg.onload = function() {
                            var height = newImg.height;
                            var width = newImg.width;

                            var biggerDimension = height > width ? height : width;

                            if( biggerDimension > scope.$parent.maxDimension ) {
                                var ratio = scope.$parent.maxDimension / biggerDimension;
                                var newHeight = height*ratio + 'px';
                                var newWidth = width*ratio + 'px';
                                element.css('height', newHeight );
                                element.css('width', newWidth);
                                element.parent().css('height', '200px');
                                element.parent().css('line-height','200px');
                                element.parent().css('width', newWidth);
                            }


                            if( scope.$last ){
                                scope.$parent.readyToReverse = true;
                            }

                            watcher();
                        }

                        newImg.src = attrs.ngSrc;
                    }
                });

                if( scope.$last ){

                    var sec_watcher = scope.$watch( function(){ return scope.$parent.readyToReverse; } , function(newVal) {
                        if( newVal ) {
                            console.log("destruvtion");
                            var elementIterator = element.parent().parent();
                            for (var i = 0; i < scope.$parent.counter; i++) {
                                elementIterator.css('display', '');
                                elementIterator = elementIterator.parent();
                            }
                            sec_watcher();
                        }
                    });
                }

            } );

            element.bind('click', function(){
                if( scope.$parent.selectedImage != scope.$index ) {
                    scope.$parent.$apply(function () {
                        scope.$parent.selectedImage = scope.$index;
                        scope.$parent.dropdown = false;
                    });
                }
            });

            element.bind('mouseenter', function(){
                scope.$apply( function(){
                    scope.hovered = true;
                });
            });

            element.bind('mouseleave', function(){
                scope.$apply( function(){
                    scope.hovered = false;
                });
            });
        }
    }
}]);

forkApp.directive('fullImage', ['$animateCss', function($animateCss) {
    return {
        link: function (scope, element) {
            scope.$watch( function(){
                return scope.getSelectedUrl();
            }, function(newval, oldval){

                var oldheight = element[0].getBoundingClientRect().height;

                var newImg = new Image();

                newImg.onload = function() {
                    var newheight = newImg.height;
                    $animateCss(element, {
                        from:{ height: oldheight+'px' },
                        to: {height: newheight+'px'},
                        duration: 1,
                    }).start();

                }

                newImg.src = newval;
            });
        }
    }
}]);

forkApp.directive('userImageWrapper', function() {
    return {
        controller: ['$scope', function ($scope) {
            $scope.hovered = false;

            $scope.overlayStyle = function () {
                if ($scope.hovered && $scope.selectedImage != $scope.$index) {
                    return { opacity : 0.3 };
                }
                return {opacity: 0};
            }
        }]
    }
});

forkApp.directive('toggleDropdown', function(){
   return {
       link: function (scope, element) {
           element.bind('click', function(){
               scope.$apply( function(){
                   scope.toggleDropdown();
               });
               element[0].classList.remove("spin-animation");

               // -> triggering reflow /* The actual magic */
               // without this it wouldn't work. Try uncommenting the line and the transition won't be retriggered.
               element[0].offsetWidth = element[0].offsetWidth;

               element[0].classList.add("spin-animation");
           });
       }
   }
});