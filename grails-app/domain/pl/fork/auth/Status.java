package pl.fork.auth;

/**
 * Created by Patryk on 11.11.2015.
 */
public enum Status {
    APPROVED("enum.approved"),
    PENDING ("enum.pending"),
    REJECTED ("enum.rejected");

    String label;

    Status(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }
}
