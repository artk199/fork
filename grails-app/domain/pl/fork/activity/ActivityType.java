package pl.fork.activity;

/**
 * Created by Patryk on 11/11/2015.
 */
public enum ActivityType {

    INVITE("enum.activity.invite"),
    FRIEND("enum.activity.friend"),
    REVIEW("enum.activity.review"),
    IMAGE("enum.activity.image"),
    EVENT("enum.activity.event");

    private String label;

    ActivityType(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }

    @Override
    public String toString() {
        return this.name();
    }
}
