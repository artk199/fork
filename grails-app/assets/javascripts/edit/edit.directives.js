forkApp.directive('fieldEdit', function(){
    return {
        restrict: 'E',
        controller: 'editController',
        scope: {
            fieldName: '@',
            fieldValue: '@',
            default: '@',
            id: '@'
        },
        link: function(scope, element){

            scope.editFieldValue = scope.fieldValue;
            if( scope.fieldValue == "" ){
                scope.notSet = true;
            }

        },
        template:"<a field-pre-edit style='cursor:pointer;word-wrap:break-word;'>{{getValue()}}</a>" +
        "<input field-during-edit ng-model='editFieldValue' type='text' style='padding-right:80px;max-width: 84%;'/>" +
        "<span ng-show='editing' class='fork-accept-cancel'>" +
        "    <span accept-edit class='glyphicon glyphicon-ok'></span>" +
        "    <span cancel-edit class='glyphicon glyphicon-remove'></span>" +
        "</span>"
    }
});

forkApp.directive('descriptionEdit', function(){
    return {
        restrict: 'E',
        controller: 'editController',
        scope: {
            fieldName: '@',
            fieldValue: '@',
            default: '@',
            id: '@'
        },
        link: function(scope, element){
            scope.editFieldValue = scope.fieldValue;
            if( scope.fieldValue == "" ){
                scope.notSet = true;
            }

        },
        template:"<a field-pre-edit style='cursor:pointer;word-wrap:break-word;'>{{getValue()}}</a>" +
        "<textarea field-during-edit ng-model='editFieldValue' style='width: 100%;height: 150px;resize: none;padding-right: 80px'></textarea>" +
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
                    scope.editFieldValue = scope.notSet ? '' : scope.fieldValue;
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