package pl.fork.activity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.location.Location;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;

import java.util.ArrayList;
import java.util.List;

import pl.fork.LocationService;
import pl.fork.SessionHandler;
import pl.fork.adapters.PlaceListAdapter;
import pl.fork.entity.Place;
import pl.fork.entity.PlaceType;
import pl.fork.fork.R;
import pl.fork.listeners.PlaceListClickListener;
import pl.fork.web.LoadPlacesTask;

public class MainActivity extends AppCompatActivity {

    private final MainActivity mainActivity = this;

    /** Menus */
    private static final int MENU_LOGIN = 1;

    private ProgressDialog progressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

        final MainActivity mainActivity = this;

        setContentView(R.layout.activity_main);

        ListView placesListView = (ListView) findViewById(R.id.listView);


        PlaceListAdapter adapter = (PlaceListAdapter)placesListView.getAdapter();

        if(adapter == null) {
            List<Place> places = new ArrayList<Place>();
            adapter = new PlaceListAdapter(this, places);
            placesListView.setAdapter(adapter);
            placesListView.setOnItemClickListener(new PlaceListClickListener(this,adapter));
        }

        /** Inicjalizacja ImageLoadera */
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(this).build();
        ImageLoader.getInstance().init(config);
        Fresco.initialize(getApplicationContext());

        setUpMapButton();
        setUpFilterButtons();
        setUpLoginButton();

    }

    private void setUpMapButton() {
        Button allMapButton = (Button) findViewById(R.id.allMapButton);

        allMapButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mainActivity,AllPlacesMapsActivity.class);

                ListView placesListView = (ListView) findViewById(R.id.listView);
                PlaceListAdapter adapter = (PlaceListAdapter)placesListView.getAdapter();
                ArrayList<Place> placeList = adapter.getAllPlaces();
                intent.putExtra("places",placeList);
                startActivity(intent);
            }
        });
    }

    private void setUpFilterButtons() {
        Button restaurantsButton = (Button) findViewById(R.id.restaurants);
        setUpFilterButton(restaurantsButton,PlaceType.RESTAURANT);
        Button attractionsButton = (Button) findViewById(R.id.attractions);
        setUpFilterButton(attractionsButton,PlaceType.ATTRACTION);
        Button hotelsButton = (Button) findViewById(R.id.hotels);
        setUpFilterButton(hotelsButton,PlaceType.HOTEL);
        Button allButton = (Button) findViewById(R.id.allPlaces);
        setUpFilterButton(allButton,null);
    }

    private void setUpFilterButton(Button btn,final PlaceType placeType){
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                refreshPlaces(placeType);
            }
        });
    }

    private void setUpLoginButton() {
        final Button loginButton = (Button) findViewById(R.id.loginButton);
        if(SessionHandler.getInstance().isActive()){
            loginButton.setText("Wyloguj");
            loginButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    SessionHandler.getInstance().setActive(false);
                    finish();
                    startActivity(getIntent());
                }
            });
        }else{
            loginButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent loginIntent = new Intent(mainActivity, LoginActivity.class);
                    startActivity(loginIntent);
                }
            });
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);

        if(true)
            menu.add(0, 1, Menu.NONE, R.string.log_in);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if(id == MENU_LOGIN){
            Intent loginIntent = new Intent(this,LoginActivity.class);
            startActivity(loginIntent);
        }

        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void refreshPlaces(PlaceType placeType){

        LocationService locationService = new LocationService(getApplicationContext());
        Location location = locationService.getLocation();

        if(location != null) {
            TextView latitudeValue = (TextView) findViewById(R.id.lat_value);
            latitudeValue.setText(Double.toString(location.getLatitude()));

            TextView longitudeValue = (TextView) findViewById(R.id.lon_value);
            longitudeValue.setText(Double.toString(location.getLongitude()));
        }

        System.out.println("Hello world2");

        ListView placesListView = (ListView) findViewById(R.id.listView);

        PlaceListAdapter adapter = (PlaceListAdapter)placesListView.getAdapter();

        if(adapter == null) {
            List<Place> places = new ArrayList<Place>();
            adapter = new PlaceListAdapter(this, places);
            placesListView.setAdapter(adapter);
            placesListView.setOnItemClickListener(new PlaceListClickListener(this,adapter));
        }

        if(location != null) {
            showLoadingProgressDialog();
            new LoadPlacesTask(adapter, getApplicationContext(),placeType,this).execute(location.getLatitude(), location.getLongitude());
        }else{
            showLoadingProgressDialog();
            new LoadPlacesTask(adapter, getApplicationContext(),placeType,this).execute(0.0, 0.0);
        }
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
}


