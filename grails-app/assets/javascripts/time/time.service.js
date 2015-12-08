forkApp.factory('timeService', function(){

    var monthNames = [
        "Styczeń", "Luty", "Marzec", "Kwiecień",
        "Maj", "Lipiec", "Czerwiec", "Sierpień",
        "Wrzesień", "Październik", "Listopad", "Grudzień"
    ];

    var days = [ "dzień,", "dni"];
    var hours = {};
    hours["godzinę"] = [1];
    hours["godziny"] = [2,3,4,22,23,24];
    hours["godzin"] = [0,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];

    var minutes = {};
    minutes["minutę"] = [1];
    minutes["minuty"] = [2,3,4,22,23,24,32,33,34,42,43,44,52,53,54];
    minutes["minut"] = [0,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,25,26,27,28,29,30,31,34,35,36,37,38,39,40,41,45,46,47,48,49,50,51,55,56,57,58,59,60]

    function getMonthDate(id){
        return monthNames[id];
    };

    function getDayString(days_){
        if( days_ == 1 ){
            return days[0];
        }
        return days[1];
    };

    function getHourString(hours_){
        var hour;
        for (var key in hours) {
            if (hours.hasOwnProperty(key)) {
                if( hours[key].indexOf(hours_) > -1){
                    hour = key;
                }
            }
        }
        return hour;
    };

    function getMinutesString(minute_){
        var minute;
        for (var key in minutes) {
            if (minutes.hasOwnProperty(key)) {
                if( minutes[key].indexOf(minute_) > -1){
                    minute = key;
                }
            }
        }
        return minute;
    };

    var service = {
        getMonthDate : getMonthDate,
        getDayString : getDayString,
        getHourString : getHourString,
        getMinutesString : getMinutesString
    };

    return service;

});