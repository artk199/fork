package pl.fork.activity;

import android.location.Location;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import pl.fork.LocationService;
import pl.fork.entity.Place;
import pl.fork.fork.R;

public class AllPlacesMapsActivity extends FragmentActivity {

    private GoogleMap mMap;
    List<Place> places;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        this.places = (ArrayList<Place>) getIntent().getSerializableExtra("places");
        setUpMapIfNeeded();


    }

    @Override
    protected void onResume() {
        super.onResume();
        setUpMapIfNeeded();
    }

    private void setUpMapIfNeeded() {
        if (mMap == null) {
            mMap = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map))
                    .getMap();
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
            MarkerOptions markerOptions = new MarkerOptions();
            markerOptions.position(position);
            markerOptions.title("Moja pozycja!");

            mMap.addMarker(markerOptions);

            CameraUpdate update = CameraUpdateFactory.newLatLngZoom(position, 15);
            mMap.animateCamera(update);
        }

        for (Place place : places) {
            LatLng position = new LatLng(place.getLatitude(), place.getLongitude());
            MarkerOptions markerOptions = new MarkerOptions();
            markerOptions.position(position);
            markerOptions.title(place.getName());
            mMap.addMarker(markerOptions);
        }





    }
}
