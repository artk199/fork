package pl.fork.web;

import android.os.AsyncTask;
import android.util.Log;
import android.widget.ArrayAdapter;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

import pl.fork.place.entity.Place;

/**
 * Created by Artur on 2015-10-31.
 */
public class LoadPlacesTask extends AsyncTask<Object,Void,List<Place>> {

    private static final String LOG_TAG = "LoadPlacesTask";
    ArrayAdapter list;
    @Override
    protected List<Place> doInBackground(Object... params) {
        list = (ArrayAdapter) params[0];
        try {
            final String url = "http://45.55.215.21:8080/place/getAll";
            //final String url = "http://192.168.0.18:8080/place/getAll";
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            Place[] placeArray = restTemplate.getForObject(url, Place[].class);
            for (Place place: placeArray) {
                Log.d(LOG_TAG,"Loaded place from server: " + place.getName());
            }
            List<Place> places = Arrays.asList(placeArray);
            if(places == null) {
                Log.e(LOG_TAG, "places are null");
            }
            return places;
        } catch (Exception e) {
            Log.e(LOG_TAG, e.getMessage(), e);
        }
        return null;
    }

    @Override
    protected void onPostExecute(List<Place> places) {

        for(Place place: places){
            Log.d(LOG_TAG, "Wrzucam do listy wyswietlania: " + place.getName() + "");
            list.add(place);
        }


    }


}
