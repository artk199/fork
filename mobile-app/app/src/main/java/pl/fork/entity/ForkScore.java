package pl.fork.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

/**
 * Created by Artur on 2015-11-26.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ForkScore implements Serializable {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
