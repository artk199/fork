package pl.fork.activity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ImageView;
import android.widget.Toast;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import pl.fork.SessionHandler;
import pl.fork.fork.R;

/**
 * Created by Artur on 2015-11-27.
 */
public class AddPhotoActivity  extends AppCompatActivity {

    private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;
    ImageView mImageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.upload_photo);
        mImageView = (ImageView) findViewById(R.id.imageThumbnail);
        // create Intent to take a picture and return control to the calling application
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        // start the image capture Intent
        startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                Toast.makeText(this, "Image saved to:\n" +
                        data.getData(), Toast.LENGTH_LONG).show();
                Bundle extras = data.getExtras();
                Bitmap imageBitmap = (Bitmap) extras.get("data");
                mImageView.setImageBitmap(imageBitmap);

            } else if (resultCode == RESULT_CANCELED) {
                onBackPressed();
            } else {
                Toast.makeText(this, "Błąd podczas robienia zdjęcia.", Toast.LENGTH_LONG).show();
                onBackPressed();
            }
        }
    }

    private class UploadPhoto extends AsyncTask<Bitmap,Void,Boolean> {


        @Override
        protected Boolean doInBackground(Bitmap... params) {

            Bitmap bitmap = params[0];
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            bitmap.compress(Bitmap.CompressFormat.JPEG, 60, stream); // convert Bitmap to ByteArrayOutputStream

            MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

            Resource res = new ByteArrayResource(stream.toByteArray());
            HttpHeaders imageHeaders = new HttpHeaders();
            imageHeaders.add("Cookie", "JSESSIONID="+ SessionHandler.getInstance().getCookie());
            imageHeaders.setContentType(MediaType.IMAGE_JPEG);
            HttpEntity<Resource> imageEntity = new HttpEntity<Resource>(res, imageHeaders);
            map.add("item[image]", imageEntity);

            return null;
        }
    }

}
