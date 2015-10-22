package pl.fork.place.other

enum DayOfTheWeek{
    MONDAY('mon'),
    TUESDAY('tue'),
    WEDNESDAY('wed'),
    THURSDAY('thu'),
    FRIDAY('fri'),
    SATURDAY('sat'),
    SUNDAY('sun')

    final String id

    DayOfTheWeek(String id) { this.id = id }
}


class OpenHours {

    static constraints = {
        days minSize: 1
        days maxSize: 7
        places minSize: 1
    }


    /*TODO: Make sure that days are selectable */
    static hasMany = [places:OtherPlace, days:DayOfTheWeek]
    static belongsTo = OtherPlace

    int start_hour
    int start_minutes

    int end_hour
    int end_minutes

}
