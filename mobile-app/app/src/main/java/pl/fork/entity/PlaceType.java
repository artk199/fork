package pl.fork.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

/**
 * Created by Artur on 2015-11-22.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlaceType implements Serializable {

    public static PlaceType RESTAURANT = new PlaceType(1);
    public static PlaceType ATTRACTION = new PlaceType(2);
    public static PlaceType HOTEL = new PlaceType(3);

    private int id;

    public PlaceType() {
    }

    public PlaceType(int id) {

        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PlaceType placeType = (PlaceType) o;

        return id == placeType.id;

    }

    @Override
    public int hashCode() {
        return id;
    }
}
