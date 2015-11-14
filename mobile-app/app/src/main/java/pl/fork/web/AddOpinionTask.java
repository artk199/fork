package pl.fork.web;

import android.os.AsyncTask;
import android.util.Log;
import android.view.View;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import pl.fork.Config;
import pl.fork.SessionHandler;
import pl.fork.entity.Opinion;
import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-01.
 */
public class AddOpinionTask extends AsyncTask<Object,Void,Place> {


    static final String LOG_TAG = "AddOpinionTask";

    @Override
    protected Place doInBackground(Object... params) {

        Opinion opinion = (Opinion) params[0];
        int id = (int) params[1];
        try {
            final String url = Config.baseURL + "place/addScore/"+Integer.toString(id);

            ObjectMapper mapper = new ObjectMapper();
            String opinionJson = mapper.writeValueAsString(opinion);

            Log.d(LOG_TAG,"url  =" + url);
            Log.d(LOG_TAG, "JSON =" + opinionJson);

            HttpHeaders headers = new HttpHeaders();
            headers.add("Cookie", "JSESSIONID="+SessionHandler.getInstance().getCookie());
            RestTemplate restTemplate = new RestTemplate();
            HttpEntity<String> entity = new HttpEntity<String>(opinionJson,headers);
            restTemplate.put(url, entity);

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
