package pl.fork.auth;

/**
 * Created by Patryk on 11.11.2015.
 */
public enum FriendshipStatus {
    ACCEPTED("enum.accepted"),
    PENDING ("enum.pending"),
    REJECTED ("enum.rejected"),
    REMOVED ("enum.removed");

    String label;

    FriendshipStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }
}
