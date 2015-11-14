package pl.fork.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Artur on 2015-11-13.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class User {

    Integer id;
    String username;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
