forkApp.directive('userImages', function(){
    return {
        link: function(scope, element, attrs){
            scope.id = attrs.id;
            scope.requestImages();
        }
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

                scope.requestDetails();

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

            element.bind('mouseover', function(){
                scope.$apply(function(){
                    scope.overImage = true;
                });
            });

            element.bind('mouseout', function(){
                scope.$apply(function(){
                    scope.overImage = false;
                });
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

forkApp.directive('addImage', function(){
    return {
        link: function (scope, element, attrs) {

            var original = true;
            if ( attrs['addImage'] == 2 ){
                original = false;
            }

            element.bind('mouseover', function(){
                scope.$apply(function(){
                    scope.addHovered = true;
                });
            });

            element.bind('mouseout', function(){
                scope.$apply(function(){
                    scope.addHovered = false;
                });
            });

            element.bind('click', function(){
                scope.$apply( function(){
                    scope.openDialog = true;
                })
            });

            scope.$watch( function(){
                return scope.addHovered;
            }, function(newVal){
                if( ! (newVal ^ original ) ){ //condition passes when image is hovered and image is original or when image is not hovered and is not original
                    element.addClass('ng-hide');
                }
                else{
                    element.removeClass('ng-hide');
                }
            } );
        }
    }
});

forkApp.directive('fileDialog', function(){
    return {
        link: function (scope, element, attrs) {
            scope.$watch( function(){
                return scope.openDialog;
            }, function(openDialog){
                if( openDialog ){
                    scope.openDialog = false;
                    element.trigger('click');
                }
            });

            element.bind('change', function(){
                var file = element[0].files[0];
                var form = new FormData();
                form.append('file', file, 'image.png');

                var xhr = new XMLHttpRequest();
                xhr.open('POST','/image/upload',true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        console.log('xd');
                        scope.images.push(xhr.responseText);
                        console.log('pls');
                    } else {
                        alert('An error occurred!');
                    }
                };
                xhr.send(form);
            });

        }
    }
});

forkApp.directive('deleteImage', function(){
    return {
        link: function (scope, element) {
            //ng - href = '/image/{{images[selectedImage]}}/delete'
            element.bind('click', function(){
                scope.deleteImage();
            });
        }
    }
});

forkApp.directive('editImage', function(){
   return {
       link: function (scope, element) {
           element.bind('click', function(){
               window.location.href = '/image/'+scope.images[scope.selectedImage]+'/edit';
           });
       }
   }
});