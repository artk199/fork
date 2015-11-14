package pl.fork.adapters;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

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

        placeNameTextView.setText(placeToRender.getName());
        placeDescriptionTextView.setText(placeToRender.getDescription());

        return convertView;
    }
}
