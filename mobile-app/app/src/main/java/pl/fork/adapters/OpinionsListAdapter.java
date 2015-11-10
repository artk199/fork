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

import and.fork.pl.fork.R;
import pl.fork.place.entity.Opinion;
import pl.fork.place.entity.Place;

/**
 * Created by Artur on 2015-11-07.
 */
public class OpinionsListAdapter extends ArrayAdapter<Opinion> {

    private static final String LOG_TAG = "OpinionsListAdapter";

    public OpinionsListAdapter(Context context, List<Opinion> objects) {
        super(context, 0, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if(convertView == null) {
            LayoutInflater inflater  = (LayoutInflater)this.getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(R.layout.opinion_row, null);
        }

        /*
        Opinion placeToRender = this.getItem(position);

        Log.d(LOG_TAG,"ładuje widok " + placeToRender.getName() + " position " + position);
        ImageView placeImageView = (ImageView) convertView.findViewById(R.id.placeImageView);
        TextView placeNameTextView = (TextView) convertView.findViewById(R.id.placeNameTextView);
        TextView placeDescriptionTextView = (TextView) convertView.findViewById(R.id.placeDescriptionTextView);

        placeNameTextView.setText(placeToRender.getName());
        placeDescriptionTextView.setText(placeToRender.getDescription());
        */

        return convertView;
    }
}
