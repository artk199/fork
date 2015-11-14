package pl.fork.listeners;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;

import pl.fork.activity.LoginActivity;
import pl.fork.activity.PlaceDetailsActivity;
import pl.fork.adapters.PlaceListAdapter;
import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-01.
 */
public class PlaceListClickListener implements AdapterView.OnItemClickListener {

    private static final String LOG_TAG = "PlaceListClickListener";

    private PlaceListAdapter placeListAdapter;
    private Activity activity;

    public PlaceListClickListener(Activity activity,PlaceListAdapter placeListAdapter) {
        this.activity = activity;
        this.placeListAdapter = placeListAdapter;
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        
        Place place = placeListAdapter.getItem(position);
        
        Log.d(LOG_TAG,"Wyrano pozycje z menu: " + position + " id " + place.getId() + "object" + place.getName());
        
        // Zmieniamy activity na pokazujace szegoly o miejscu
        Intent placeDetailsIntent = new Intent(activity, PlaceDetailsActivity.class);

        // Wysylamy wiadomosc o tym jaki obiekt wyswietlic
        placeDetailsIntent.putExtra("place", place);
        activity.startActivity(placeDetailsIntent);
    }
}
