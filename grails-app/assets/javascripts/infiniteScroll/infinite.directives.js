/**
 * Created by sirke on 13.11.2015.
 */
forkApp.directive('infiniteList', function($compile) {
    return {
        restrict: 'E',
        controller: 'infiniteController',
        scope: {
            link: '@',
            amount: '@',
        },
        link: function(scope){

            scope.requestList();

        },
        transclude: true,
        template: `
            <div>
                <div>
                    <div ng-repeat='instance in list track by $index' inject>
                   </div>
                </div>
                <div class="fork-list-loading-more ng-hide" ng-show="blockLoading && list.length > 0"> Loading more elements <span class="glyphicon glyphicon-cog"></span></div>
                <div trigger-request style="width:650px;height:0px; background:black; float:right;"></div>
            </div>
        `
    }
});


forkApp.directive('inject', function(){
    return {
        link: function(scope, element, attrs, controller, transclude) {

            var innerScope = scope.$new();
            transclude(innerScope, function(clone) {
                element.empty();
                element.append(clone);
                element.on('$destroy', function() {
                    innerScope.$destroy();
                });
            });
        }
    };
});
forkApp.directive( 'triggerRequest', function($timeout) {
    return {
        link: function( scope, element ) {

            var top, scroll, height;

            var requestNew = function(){
                top = $(element).offset().top;
                var isVisible = top - 50 < scroll + height;
                var isVisible2 = top + height > scroll + height;
                //console.log("Top: " +  top + " | Other: " + (scroll + height));
                if( isVisible && isVisible2 && !scope.blockLoading && !scope.noMoreData){
                    scope.$apply( function (){
                        scope.blockLoading = true;
                    })
                    scope.requestList();
                }
            }

            $(window).bind("load", function() {
                scroll = $(window).scrollTop();
                height = $(window).height();
            });
            $(window).bind("scroll", function(){
                scroll = $(window).scrollTop();
                requestNew();
            });
            $(window).bind("resize", function(){
                height = $(window).height();
                requestNew();
            });

            scope.$watch( function(){ return scope.blockLoading; } , function(isBlocked ){
                $timeout( function(){if (!isBlocked ){
                    requestNew();
                }}, 250);
            });
        }
    };
});