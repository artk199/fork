package pl.fork.web;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.Toast;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import pl.fork.Config;
import pl.fork.activity.MainActivity;
import pl.fork.entity.Place;
import pl.fork.entity.PlaceType;

/**
 * Created by Artur on 2015-10-31.
 */
public class LoadPlacesTask extends AsyncTask<Double, Void, List<Place>> {

    private final MainActivity activity;
    private PlaceType placeType;
    ArrayAdapter list;
    Context context;

    private static final String LOG_TAG = "LoadPlacesTask";

    public LoadPlacesTask(ArrayAdapter list,Context ctx, PlaceType placeType, MainActivity activity) {
        this.context = ctx;
        this.list = list;
        this.placeType = placeType;
        this.activity = activity;
    }


    @Override
    protected List<Place> doInBackground(Double... params) {
        double latitude = params[0];
        double longitude = params[1];

        try {
            final String url = Config.baseURL + "place/getNear?x="+latitude+"&y="+longitude;
            Log.d(LOG_TAG,url);

            HttpHeaders requestHeaders = new HttpHeaders();
            requestHeaders.setAccept(Collections.singletonList(new MediaType("application", "json")));
            HttpEntity<?> requestEntity = new HttpEntity<Object>(requestHeaders);

            RestTemplate restTemplate = new RestTemplate();

            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());

            ResponseEntity<Place[]> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, Place[].class);
            Place[] placeArray = responseEntity.getBody();

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

        activity.dismissProgressDialog();

        if(places == null) {
            CharSequence text = "Błąd podczas ładowania atrakcji!";
            Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
            toast.show();
            return;
        }

        list.clear();
        for(Place place: places) {
            Log.d(LOG_TAG, "Wrzucam do listy wyswietlania: " + place.getName() + "");
            if (placeType != null) {
                if(place.getTypes().contains(placeType)){
                    Log.d(LOG_TAG,"Dodaję z sprawdzaniem typu.");
                    list.add(place);
                }
            } else {
                Log.d(LOG_TAG,"Dodaję bez sprawdzania typu.");
                list.add(place);
            }
        }

    }
}
