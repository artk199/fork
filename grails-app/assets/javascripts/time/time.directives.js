forkApp.directive('timeDifference', [ 'timeService', function(timeService){
    return {
        restrict: 'E',
        replace: 'true',
        template: "<span>{{difference}}</span>",
        scope: { date: '@'},
        link: function(scope){

            var currentTime = new Date().getTime();
            var oldDate = new Date(scope.date);
            var oldTime = oldDate.getTime();
            var timeDifference = currentTime - oldTime;
            var daysDifference = Math.floor(timeDifference / ( 1000 * 3600 * 24 ));
            var hoursDifference = Math.floor(timeDifference / ( 1000 * 3600 ));
            var minutesDifference = Math.floor(timeDifference / ( 1000 * 60 ));

            var monthName = timeService.getMonthDate(oldDate.getMonth());
            var day = timeService.getDayString(daysDifference);

            if( daysDifference >= 7 ) {
                scope.difference = oldDate.getDate() + ' ' + monthName + ' ' + oldDate.getFullYear() + 'r.';
                return;
            }
            if( daysDifference < 7 && daysDifference >= 1 ){
                hoursDifference = hoursDifference - (daysDifference * 24);
                var hour = timeService.getHourString(hoursDifference);
                scope.difference = daysDifference + ' ' + day + ' ' + hoursDifference + ' ' + hour + ' temu';
                return;
            }

            if ( daysDifference == 0 ){
                var hour = timeService.getHourString(hoursDifference);
                minutesDifference = minutesDifference - (hoursDifference * 60);
                var minute = timeService.getMinutesString(minutesDifference);
                if( hoursDifference >= 1 ){
                    scope.difference = hoursDifference + ' ' + hour + ' ' + minutesDifference + ' ' + minute + ' temu';
                    return;
                }
                if( hoursDifference == 0 ){
                    if( minutesDifference < 60 && minutesDifference > 3 ){
                        scope.difference = minutesDifference + ' ' + minute + ' temu';
                        return;
                    }
                    if( minutesDifference <= 3 ) {
                        scope.difference = "Dosłowanie przed chwilą";
                    }
                }

            }
        }
    }
}]);