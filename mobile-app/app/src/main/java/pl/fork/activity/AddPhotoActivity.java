package pl.fork.activity;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

/**
 * Created by Artur on 2015-11-27.
 */
public class AddPhotoActivity  extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }
    private class UploadPhoto extends AsyncTask<String,Void,Boolean> {


        @Override
        protected Boolean doInBackground(String... params) {
            return null;
        }
    }
}
