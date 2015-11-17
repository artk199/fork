package pl.fork.activity;

import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;


import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;

import java.util.ArrayList;
import java.util.List;

import pl.fork.LocationService;
import pl.fork.SessionHandler;
import pl.fork.fork.R;
import pl.fork.adapters.PlaceListAdapter;
import pl.fork.listeners.PlaceListClickListener;
import pl.fork.entity.Place;
import pl.fork.web.LoadPlacesTask;

public class MainActivity extends AppCompatActivity {

    private LocationManager locationManager = null;
    private LocationListener locationListener = null;

    /** Menus */
    private static final int MENU_LOGIN = 1;

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

        locationManager = (LocationManager)
                getSystemService(Context.LOCATION_SERVICE);

        Button refreshButton = (Button) findViewById(R.id.refresh);
        refreshButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                refreshPlaces();
            }
        });

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

        final Button loginbutton = (Button) findViewById(R.id.loginButton);

        if(SessionHandler.getInstance().isActive()){
            loginbutton.setText("Wyloguj.");
            loginbutton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    SessionHandler.getInstance().setActive(false);
                    finish();
                    startActivity(getIntent());
                }
            });
        }else{
            loginbutton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent loginIntent = new Intent(mainActivity,LoginActivity.class);
                    startActivity(loginIntent);
                }
            });
        }

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);

        if(true)
            menu.add(0, 1, Menu.NONE, R.string.log_in);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if(id == MENU_LOGIN){
            Intent loginIntent = new Intent(this,LoginActivity.class);
            startActivity(loginIntent);
        }

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {


            return true;
        }

        return super.onOptionsItemSelected(item);
    }


    private void refreshPlaces(){

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

        new LoadPlacesTask(adapter,getApplicationContext()).execute(location.getLatitude(),location.getLongitude());
    }

    private class ForkLocationListener implements LocationListener {
        @Override
        public void onLocationChanged(Location loc) {
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {



        }

        @Override
        public void onProviderEnabled(String provider) {

        }

        @Override
        public void onProviderDisabled(String provider) {

        }
    }

}


