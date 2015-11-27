package pl.fork.web;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;

import com.etiennelawlor.imagegallery.library.activities.ImageGalleryActivity;
import com.etiennelawlor.imagegallery.library.enums.PaletteColorType;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import pl.fork.Config;
import pl.fork.entity.Opinion;

/**
 * Created by Artur on 2015-11-17.
 */
public class LoadAllImagesIDTask extends AsyncTask<Integer,Void,Integer[]> {

    public LoadAllImagesIDTask(Context context) {
        this.context = context;
    }

    Context context;

    private static final String LOG_TAG = "LoadAllImagesIDTask";

    @Override
    protected Integer[] doInBackground(Integer... params) {

        int id = params[0];

        try {
            final String url = Config.baseURL + "place/"+Integer.toString(id)+"/image";
            Log.d(LOG_TAG, "Wołam URL " + url);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            Integer[] images = restTemplate.getForObject(url, Integer[].class);
            return images;
        }catch (Exception e){
            Log.e("Blad","Blad podczas ladowania wszystkich zdjec.");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    protected void onPostExecute(Integer[] imagesID) {

        if(imagesID != null) {
            Intent intent = new Intent(context, ImageGalleryActivity.class);

            ArrayList<String> images = new ArrayList<>();

            for(Integer image : imagesID){
                images.add("http://45.55.215.21:8080/image/1");
            }

            intent.putStringArrayListExtra("images", images);
            // optionally set background color using Palette
            intent.putExtra("palette_color_type", PaletteColorType.VIBRANT);

            context.startActivity(intent);
        }

    }
}
