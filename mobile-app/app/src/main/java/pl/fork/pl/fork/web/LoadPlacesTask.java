package pl.fork.pl.fork.web;

import android.os.AsyncTask;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import and.fork.pl.fork.R;
import pl.fork.Place;

/**
 * Created by Artur on 2015-10-31.
 */
public class LoadPlacesTask extends AsyncTask<Object,Void,List<Place>> {

    ArrayAdapter list;
    @Override
    protected List<Place> doInBackground(Object... params) {
        list = (ArrayAdapter) params[0];
        try {
            final String url = "http://45.55.215.21:8080/fork/place/getAll";
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            Place[] placeArray = restTemplate.getForObject(url, Place[].class);
            List<Place> places = Arrays.asList(placeArray);
            if(places == null) {
                Log.e("LoadPlacesTask", "places are null");
            }
            return places;
        } catch (Exception e) {
            Log.e("LoadPlacesTask", e.getMessage(), e);
        }
        return null;
    }

    @Override
    protected void onPostExecute(List<Place> places) {

        for(Place place: places){
            Log.d("LoadPlacesTask", "" + place.getDescription() + "");
            list.add(place.getName());
        }


    }


}
