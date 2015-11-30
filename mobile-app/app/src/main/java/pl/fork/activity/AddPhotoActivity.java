package pl.fork.activity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import pl.fork.Config;
import pl.fork.SessionHandler;
import pl.fork.entity.Place;
import pl.fork.fork.R;

/**
 * Created by Artur on 2015-11-27.
 */
public class AddPhotoActivity  extends AppCompatActivity {

    private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;
    ImageView mImageView;
    Button mUploadButton;
    Bitmap imageBitmap;
    private ProgressDialog progressDialog;
    Place place;
    File photoFile = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.upload_photo);
        mImageView = (ImageView) findViewById(R.id.imageThumbnail);

        try {
            photoFile = createImageFile();
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(photoFile));
        startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);

        this.place = (Place) getIntent().getSerializableExtra("place");
        mUploadButton = (Button) findViewById(R.id.uploadButton);
        mUploadButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new UploadPhoto().execute();
                mUploadButton.setEnabled(false);
            }
        });


    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                Bitmap imageBitmap = BitmapFactory.decodeFile(photoFile.getAbsolutePath());
                mImageView.setImageBitmap(imageBitmap);
            } else if (resultCode == RESULT_CANCELED) {
                onBackPressed();
            } else {
                Toast.makeText(this, "Błąd podczas robienia zdjęcia.", Toast.LENGTH_LONG).show();
            }
        }
    }
    String mCurrentPhotoPath;

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        File storageDir = Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_PICTURES);
        File image = File.createTempFile(
                imageFileName,
                ".jpg",
                storageDir
        );

        // Save a file: path for use with ACTION_VIEW intents
        mCurrentPhotoPath = "file:" + image.getAbsolutePath();
        return image;
    }


    public void showLoadingProgressDialog() {
        this.showProgressDialog("Proszę czekać...");
    }

    public void showProgressDialog(CharSequence message) {
        if (progressDialog == null) {
            progressDialog = new ProgressDialog(this);
            progressDialog.setIndeterminate(true);
        }

        progressDialog.setMessage(message);
        progressDialog.show();
    }

    public void dismissProgressDialog() {
        if (progressDialog != null) {
            progressDialog.dismiss();
        }
    }

    private class UploadPhoto extends AsyncTask<File,Void,Boolean> {


        @Override
        protected Boolean doInBackground(File... params) {
            File file = AddPhotoActivity.this.photoFile;
            try {

                Log.d("UploadPhoto","Proboba dodawnia zjecia.");
                FileSystemResource fsr = new FileSystemResource(file);

                MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

                map.add("file", fsr);
                map.add("place.id", place.getId().toString());

                RestTemplate restTemplate = new RestTemplate();

                HttpHeaders headers = new HttpHeaders();
                headers.add("Cookie", "JSESSIONID=" + SessionHandler.getInstance().getCookie());
                HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<>(map,headers);
                final String url = Config.baseURL + "place/upload";
                restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

                Log.d("UploadPhoto", "Koniec dodawania zdjecia.");
            }catch (Exception e){
                return false;
            }
            return true;
        }

        @Override
        protected void onPreExecute() {
            showLoadingProgressDialog();
        }

        @Override
        protected void onPostExecute(Boolean aBoolean) {
            dismissProgressDialog();
            if(aBoolean){
                Log.d("UploadPhoto","Dodawnie zdjecia poprawnie.");
                Toast.makeText(AddPhotoActivity.this, "Dodawanie zdjęcia powiodło się.", Toast.LENGTH_LONG);
                AddPhotoActivity.this.onBackPressed();
            }else{
                Log.d("UploadPhoto","Blad podlacz dodawania zdjecia.");
                AddPhotoActivity.this.mUploadButton.setEnabled(true);
                Toast.makeText(AddPhotoActivity.this,"Błąd podczas wysyłania pliku",Toast.LENGTH_LONG);
            }
        }

        @Override
        protected void onProgressUpdate(Void... values) {
            super.onProgressUpdate(values);
        }
    }

}
