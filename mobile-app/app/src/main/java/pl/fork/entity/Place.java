package pl.fork.entity;

import android.util.Log;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;
import java.util.LinkedList;

/**
 * Created by Artur on 2015-10-29.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Place implements Serializable {


    private Integer id = 0;
    private String name = "";
    private String description = "";
    private String address = "";
    private String town = "";
    private String email = "";
    private String phone = "";
    private String website = "";
    private Double avgScore = 2.0;
    private Integer imageID = -1;
    private Double longitude = 18.6900271;
    private Double latitude = 54.3610873;
    private LinkedList<ForkImage> images = new LinkedList<>();
    private LinkedList<ForkScore> scores = new LinkedList<>();
    private LinkedList<PlaceType> types = new LinkedList<>();

    public LinkedList<PlaceType> getTypes() {
        return types;
    }

    public void setTypes(LinkedList<PlaceType> types) {
        this.types = types;
    }


    public LinkedList<ForkImage> getImages() {
        return images;
    }

    public void setImages(LinkedList<ForkImage> images) {
        this.images = images;
    }


    public Integer getImageID() {

        if(images != null && images.size() > 0){
            return images.getFirst().getId();
        }else{
            Log.e("Place","IMAGES JEST NULLEEEEM");
        }
        return imageID;
    }

    public void setImageID(Integer imageID) {
        this.imageID = imageID;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }


    public LinkedList<ForkScore> getScores() {
        return scores;
    }

    public void setScores(LinkedList<ForkScore> scores) {
        this.scores = scores;
    }

    public Double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(Double avgScore) {
        this.avgScore = avgScore;
    }
}
