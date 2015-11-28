/**
 * Created by sirke on 13.11.2015.
 */

forkApp.directive('profileImage', function() {
    return {
        link: function(scope, element){

            var horizontalStyle = function(){
                element.css('margin-left','20px');
                element.css('top','0px');
                element.css('left','0px');
                element.css('height', '100%');
                element.css('float','left');
                element.css('margin-right','0px');
                element.css('width', '200px');
            }

            var verticalStyle = function(){
                element.css('height', '');
                element.css('width', '100%');
                element.css('top','');
                element.css('left','');
                element.css('margin-left','');
                element.css('margin-right','');
            }

            scope.$watch( function(){ return scope.verticalLayout; } , function( isVertical){
                if( isVertical ){
                    verticalStyle();
                }
                else{
                    horizontalStyle();
                }
            });

        }
    }
});

forkApp.directive('profileDetails', function() {
    return {
        link: function(scope, element){



            var horizontalStyle = function(){
                element.css('margin-left','20px');
                element.css('top','0px');
                element.css('left','0px');
                element.css('height', '100%');
                element.css('float','left');
            }

            var horizontalResize = function(){
                element.css('width','100%');
                var maximumWidth = element[0].offsetWidth;
                element.css('width', scope.calculateWidth(maximumWidth)+'px');
            }


            var verticalStyle = function(){
                element.css('top','20px');
                element.css('margin-left','');
                element.css('left','0px');
                element.css('height', '100%');
                element.css('float','left');
            }

            var verticalResize = function(){
                element.css('width','94%');
            }

            scope.switchLayout(scope.calculateWidth());

            $(window).bind("resize", function(){
                if( scope.verticalLayout ){
                    verticalResize();
                }
                else{
                    horizontalResize();
                }

                scope.$apply( function(){
                    scope.switchLayout(scope.calculateWidth());
                });

            });

            scope.$watch( function(){ return scope.verticalLayout; } , function( isVertical){
                if( isVertical ){
                    verticalStyle();
                    verticalResize();
                }
                else{
                    horizontalStyle();
                    horizontalResize();
                }
            });

        }
    }
});


forkApp.directive('addFriend', function(){
    return {
        link: function( scope, element ){

            var blocker = false;

            element.bind( 'click', function(){
                if( !blocker ){
                    blocker = true;
                    element.removeClass(scope.notAddedClass);
                    element.addClass(scope.requestedClass);
                    element.addClass('active');
                    scope.addFriend(scope.$index);
                }
            });
        }
    }
});

forkApp.directive('acceptFriend', function() {
    return {
        link: function (scope, element, attrs) {
            element.bind( 'click', function(){
                scope.friends.push(scope[attrs['array'][scope.$index]]);
                scope.modifyFriend(scope.$index, 'accept', attrs['array']);
            });
        }
    }
});

forkApp.directive('rejectFriend', function() {
    return {
        link: function (scope, element, attrs) {
            element.bind( 'click', function(){
                scope.modifyFriend(scope.$index, 'reject', attrs['array']);
            });
        }
    }
});