package pl.fork.auth;

/**
 * Created by Patryk on 11/11/2015.
 */
public enum RoleType {

    ROLE_ADMIN("enum.roleType.admin"),
    ROLE_MODERATOR("enum.roleType.moderator"),
    ROLE_USER("enum.roleType.user");

    private String label;

    RoleType(String label) {
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
