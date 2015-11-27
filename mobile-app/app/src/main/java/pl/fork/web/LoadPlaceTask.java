package pl.fork.web;

import android.os.AsyncTask;
import android.view.View;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-01.
 */
public class LoadPlaceTask extends AsyncTask<Object,Void,Place> {



    @Override
    protected Place doInBackground(Object... params) {

        View view = (View) params[0];
        int id = (int) params[1];
        try {
            final String url = "http://45.55.215.21:8080/fork/place/get/"+Integer.toString(id);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            Place place = restTemplate.getForObject(url, Place.class);
            return place;
        }catch (Exception e){

        }
        return null;
    }

    @Override
    protected void onPostExecute(Place place) {
        super.onPostExecute(place);
    }

}
