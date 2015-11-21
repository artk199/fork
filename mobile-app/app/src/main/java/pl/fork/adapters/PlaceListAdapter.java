package pl.fork.adapters;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.nostra13.universalimageloader.core.ImageLoader;

import java.util.ArrayList;
import java.util.List;

import pl.fork.Config;
import pl.fork.fork.R;
import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceListAdapter extends ArrayAdapter<Place> {

    private static final String LOG_TAG = "PlaceListAdapter";

    public PlaceListAdapter(Context context,List<Place> objects) {
        super(context, 0, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if(convertView == null) {
            LayoutInflater inflater  = (LayoutInflater)this.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(R.layout.place_row, null);
        }

        Place placeToRender = this.getItem(position);

        Log.d(LOG_TAG,"ładuje widok " + placeToRender.getName() + " position " + position);
        ImageView placeImageView = (ImageView) convertView.findViewById(R.id.placeImageView);
        TextView placeNameTextView = (TextView) convertView.findViewById(R.id.placeNameTextView);
        TextView placeDescriptionTextView = (TextView) convertView.findViewById(R.id.placeDescriptionTextView);

        if(placeToRender.getImageID() != -1) {
            ImageLoader imageLoader = ImageLoader.getInstance();
            imageLoader.displayImage(Config.baseURL + "image/" + placeToRender.getImageID() + "/mini", placeImageView);
        }

        placeNameTextView.setText(placeToRender.getName());
        placeDescriptionTextView.setText(placeToRender.getDescription());

        return convertView;
    }

    public ArrayList<Place> getAllPlaces() {
        ArrayList<Place> places = new ArrayList<Place>();
        for (int i = 0; i < getCount(); i++) {
            places.add(getItem(i));
        }
        return places;
    }
}
