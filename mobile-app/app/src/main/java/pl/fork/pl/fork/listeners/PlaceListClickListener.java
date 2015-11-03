package pl.fork.pl.fork.listeners;

import android.util.Log;
import android.view.View;
import android.widget.AdapterView;

/**
 * Created by Artur on 2015-11-01.
 */
public class PlaceListClickListener implements AdapterView.OnItemClickListener {
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Log.d("PlaceListClickListener","Nacisęło się cos!" + position + " id " + id);
    }
}
