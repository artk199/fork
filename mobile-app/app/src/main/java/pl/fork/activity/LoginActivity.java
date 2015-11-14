package pl.fork.activity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.Map;

import pl.fork.Config;
import pl.fork.SessionHandler;
import pl.fork.fork.R;

public class LoginActivity extends AppCompatActivity {


    /** Menus */
    private static final int MENU_FRONTPAGE = 1;


    private boolean destroyed = false;
    private ProgressDialog progressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        Button loginButton = (Button) findViewById(R.id.login_button);
        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new LoginTask().execute();
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        destroyed = true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == MENU_FRONTPAGE) {
            Intent frontPage = new Intent(this,MainActivity.class);
            startActivity(frontPage);
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Public methods
     * */
    public void showLoadingProgressDialog() {
        this.showProgressDialog("Loading. Please wait...");
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
        if (progressDialog != null && !destroyed) {
            progressDialog.dismiss();
        }
    }
    private class LoginTask extends AsyncTask<String,Void,Boolean>{

        private String username;

        private String password;

        @Override
        protected void onPreExecute() {
            showLoadingProgressDialog();

            // build the message object
            EditText editText = (EditText) findViewById(R.id.username);
            this.username = editText.getText().toString();

            editText = (EditText) findViewById(R.id.password);
            this.password = editText.getText().toString();
        }


        @Override
        protected Boolean doInBackground(String... params) {
            String TAG = "LOGIN TAG";

           // final String url = "http://45.55.215.21:8080/fork/place/getPlace";



            try {

               // RestTemplate restTemplate = new RestTemplate();

                MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();
                map.add("j_username", username);
                map.add("j_password", password);
                map.add("rest", "true");

                String baseUrl = Config.baseURL;
                String url = baseUrl + "j_spring_security_check";
                RestTemplate restTemplate = new RestTemplate();
                HttpHeaders headers = new HttpHeaders();
                headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
                headers.set("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp/*;q=0.8");
                headers.set("Accept-Language","pl-PL,pl;q=0.8,en-US;q=0.6,en;q=0.4,pt;q=0.2");
                headers.set("Connection", "keep-alive");

                HttpEntity<?> entity = new HttpEntity<Object>(map, headers);

                HttpEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

                //TODO: Zmienic na dobre sprawdzanie
                String cookie = response.getHeaders().get("Set-Cookie").get(0);

                Log.d(TAG, cookie);
                Log.d(TAG,response.getHeaders().toString());
                if(baseUrl.equals(response.getHeaders().get("Location").get(0))){
                    cookie = cookie.split("(JSESSIONID=)|;")[1];
                    Log.d(TAG, cookie);
                    SessionHandler.getInstance().setCookie(cookie);
                    SessionHandler.getInstance().setActive(true);
                    Log.d(TAG,"ZALOGOWANO");
                    return true;
                }else{
                    Log.d(TAG,"NIEZALOGOWANO");
                    return false;
                }
            } catch (HttpClientErrorException e) {
                Log.e(TAG, e.getLocalizedMessage(), e);
            } catch (ResourceAccessException e) {
                Log.e(TAG, e.getLocalizedMessage(), e);
            }
            return false;
        }


        @Override
        protected void onPostExecute(Boolean aBoolean) {
            dismissProgressDialog();
            TextView error = (TextView) findViewById(R.id.errorTextView);
            if(aBoolean){
                error.setText("Zalogowano!");
            }else{
                error.setText("Niezalogowano!");
            }
        }

    }
}
