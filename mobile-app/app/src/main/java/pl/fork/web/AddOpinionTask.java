package pl.fork.web;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import pl.fork.Config;
import pl.fork.SessionHandler;
import pl.fork.activity.MainActivity;
import pl.fork.entity.Opinion;
import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-01.
 */
public class AddOpinionTask extends AsyncTask<Object,Void,Opinion> {


    Context context;

    public AddOpinionTask(Context context) {
        this.context = context;
    }

    static final String LOG_TAG = "AddOpinionTask";

    @Override
    protected Opinion doInBackground(Object... params) {

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

            Opinion opinion1 = restTemplate.getForObject(url, Opinion.class);
            return opinion1;
        }catch (Exception e){

        }
        return null;
    }

    @Override
    protected void onPostExecute(Opinion place) {
        if(place == null){
            CharSequence text = "Błąd! Spróbuj jeszcze raz!";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }else{
            CharSequence text = "Dodano opinię!";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
            Intent intent = new Intent(context,MainActivity.class);
            context.startActivity(intent);
        }
    }

}
