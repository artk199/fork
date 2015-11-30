package pl.fork.activity;

import android.graphics.Color;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.maps.model.PolylineOptions;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

import pl.fork.LocationService;
import pl.fork.entity.Place;
import pl.fork.fork.R;

public class MapsActivity extends FragmentActivity {

    private GoogleMap mMap; // Might be null if Google Play services APK is not available.
    private Place place;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        this.place = (Place) getIntent().getSerializableExtra("place");
        setUpMapIfNeeded();


    }

    @Override
    protected void onResume() {
        super.onResume();
        setUpMapIfNeeded();
    }

    private void setUpMapIfNeeded() {
        // Do a null check to confirm that we have not already instantiated the map.
        if (mMap == null) {
            // Try to obtain the map from the SupportMapFragment.
            mMap = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map))
                    .getMap();
            // Check if we were successful in obtaining the map.
            if (mMap != null) {
                setUpMap();
            }
        }
    }

    private void setUpMap() {
        LocationService locationService = new LocationService(getApplicationContext());
        Location location = locationService.getLocation();

        if(location != null) {
            LatLng position = new LatLng(location.getLatitude(), location.getLongitude());
            new GetPathTask(place).execute(position,position);
            mMap.addMarker(new MarkerOptions().position(position).title("Moja pozycja"));
            CameraUpdate update = CameraUpdateFactory.newLatLngZoom(position, 17);
            mMap.animateCamera(update);
        }

    }


    private class GetPathTask extends AsyncTask<LatLng,Void,List<LatLng>>{

        Place place;

        public GetPathTask(Place place) {
            this.place = place;
        }

        @Override
        protected List<LatLng> doInBackground(LatLng... params) {
            if(params.length < 2){
                Log.e("GetPathTask","Nie podano wystarczajacej liczny wspolzendych.");
            }

            LatLng from = params[0];
            LatLng dest = params[1];

            double lat2,lon2,lat1,lon1;
            lat2 = from.latitude;
            lon2 = from.longitude;

            lat1 = place.getLatitude();
            lon1 = place.getLongitude();

            String url = "http://maps.googleapis.com/maps/api/directions/json?origin=" +lat1 + "," + lon1  + "&destination=" + lat2 + "," + lon2 + "&sensor=false&units=metric";
            Log.d("MapsActivity", url);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            String result = restTemplate.getForObject(url, String.class);
            Log.d("JSON result",result);
            List<LatLng> list = null;
            try {
                //Tranform the string into a json object
                final JSONObject json = new JSONObject(result);
                JSONArray routeArray = json.getJSONArray("routes");
                JSONObject routes = routeArray.getJSONObject(0);
                JSONObject overviewPolylines = routes.getJSONObject("overview_polyline");
                String encodedString = overviewPolylines.getString("points");
                list = decodePoly(encodedString);

            }catch(JSONException e) {
                Log.e("GetPathTask","Blad podczas parsowania sciezki.");
                e.printStackTrace();
            }

            return list;
        }

        @Override
        protected void onPostExecute(List<LatLng> latLngs) {
            if(latLngs != null) {
                Polyline line = mMap.addPolyline(new PolylineOptions()
                                .addAll(latLngs)
                                .width(12)
                                .color(Color.parseColor("#05b1fb"))//Google maps blue color
                                .geodesic(true)
                );
            }
        }

        /**
         * Magiczna metoda prosto z internetów
         */
        private List<LatLng> decodePoly(String encoded) {

            List<LatLng> poly = new ArrayList<LatLng>();
            int index = 0, len = encoded.length();
            int lat = 0, lng = 0;

            while (index < len) {
                int b, shift = 0, result = 0;
                do {
                    b = encoded.charAt(index++) - 63;
                    result |= (b & 0x1f) << shift;
                    shift += 5;
                } while (b >= 0x20);
                int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
                lat += dlat;

                shift = 0;
                result = 0;
                do {
                    b = encoded.charAt(index++) - 63;
                    result |= (b & 0x1f) << shift;
                    shift += 5;
                } while (b >= 0x20);
                int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
                lng += dlng;

                LatLng p = new LatLng( (((double) lat / 1E5)),
                        (((double) lng / 1E5) ));
                poly.add(p);
            }

            return poly;
        }
    }
}
