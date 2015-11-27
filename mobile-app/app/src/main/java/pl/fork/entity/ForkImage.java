package pl.fork.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

/**
 * Created by Artur on 2015-11-18.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ForkImage implements Serializable {

    private Integer id = -1;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
