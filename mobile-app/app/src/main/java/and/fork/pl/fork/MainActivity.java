package and.fork.pl.fork;

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
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

import pl.fork.pl.fork.listeners.PlaceListClickListener;
import pl.fork.pl.fork.web.LoadPlacesTask;

public class MainActivity extends AppCompatActivity {

    private LocationManager locationManager = null;
    private LocationListener locationListener = null;

    /** Menus */
    private static final int MENU_LOGIN = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        locationManager = (LocationManager)
                getSystemService(Context.LOCATION_SERVICE);

        ListView listView = (ListView) findViewById(R.id.listView);
        listView.setOnItemClickListener(new PlaceListClickListener());

        Button refreshButton = (Button) findViewById(R.id.refresh);
        refreshButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                refreshPlaces();
            }
        });
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
        locationListener = new ForkLocationListener();
        try {
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 10, locationListener);
            Location locationGPS = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
            Location locationNet = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);

            if(locationGPS != null)
                Log.d("CURRENT GPS LOCATION",locationGPS.toString());
            else
                Log.d("CURRENT GPS LOCATION","null");
            if(locationNet != null)
                Log.d("CURRENT NET LOCATION",locationNet.toString());
            else
                Log.d("CURRENT NET LOCATION","null");

            if(locationNet!=null) {
                TextView latitudeValue = (TextView) findViewById(R.id.lat_value);
                latitudeValue.setText(Double.toString(locationNet.getLatitude()));

                TextView longitudeValue = (TextView) findViewById(R.id.lon_value);
                longitudeValue.setText(Double.toString(locationNet.getLongitude()));
            }
        } catch (SecurityException e) {
            Log.e("PERMISSION_EXCEPTION","PERMISSION_NOT_GRANTED");
        } catch (Exception e){}

        System.out.println("Hello world2");

        ListView placesListView = (ListView) findViewById(R.id.listView);

        ListAdapter adapter = placesListView.getAdapter();
        if(adapter == null) {
            ArrayList<String> adapterList = new ArrayList<String>();
            adapter = new ArrayAdapter<String>(this, R.layout.place_row, adapterList);
        }
        placesListView.setAdapter(adapter);


        new LoadPlacesTask().execute(adapter);
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


