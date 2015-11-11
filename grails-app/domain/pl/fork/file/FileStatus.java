package pl.fork.file;

/**
 * Created by Patryk on 11.11.2015.
 */
public enum FileStatus {
    APPROVED("enum.approved"),
    PENDING ("enum.pending"),
    REJECTED ("enum.rejected");

    String label;

    FileStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }
}
