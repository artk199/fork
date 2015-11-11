forkApp.directive('userImages', function(){
    return {
        link: function(scope, element, attrs){
            scope.id = attrs.id;
            if( attrs.controller ) {
                scope.controller = attrs.controller;
            }
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

                form.append('id', scope.id);

                var xhr = new XMLHttpRequest();

                xhr.upload.onprogress = function(e){
                    var done = e.position || e.loaded, total = e.totalSize || e.total;
                    var present = Math.floor(done/total*100);
                    scope.$apply(function(){
                        scope.progress = present+'%';
                        console.log(scope.progress);
                    });
                };

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        scope.$apply(function() {
                            scope.progress = '0%';
                            scope.uploading = false;
                            scope.images.push(xhr.responseText);
                        });
                    } else {
                        alert('An error occurred!');
                    }
                };
                xhr.open('POST','/'+scope.controller+'/upload',true);
                scope.uploading = true;

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