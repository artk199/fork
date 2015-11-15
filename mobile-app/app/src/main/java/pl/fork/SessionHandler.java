package pl.fork;

/**
 * Created by Artur on 2015-11-14.
 */
public class SessionHandler {

    private boolean active = false;


    private String cookie = "";

    private static SessionHandler ourInstance = new SessionHandler();

    public static SessionHandler getInstance() {
        return ourInstance;
    }

    private SessionHandler() {
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        if(active == false){
            this.cookie = "";
        }
        this.active = active;
    }

    public String getCookie() {
        return cookie;
    }

    public void setCookie(String cookie) {
        this.cookie = cookie;
    }

}
