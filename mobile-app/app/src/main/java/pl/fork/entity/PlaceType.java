package pl.fork.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

/**
 * Created by Artur on 2015-11-22.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlaceType implements Serializable {

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }



}
