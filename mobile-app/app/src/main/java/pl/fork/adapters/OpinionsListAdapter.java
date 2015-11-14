package pl.fork.adapters;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.RatingBar;
import android.widget.TextView;

import java.util.List;

import pl.fork.fork.R;
import pl.fork.entity.Opinion;

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


        Opinion opinion = this.getItem(position);

        Log.d(LOG_TAG, "ładuje widok " + opinion.getReview() + " position " + position);

        TextView userNameTextView = (TextView) convertView.findViewById(R.id.userNameTextView);
        RatingBar ratingBar = (RatingBar) convertView.findViewById(R.id.ratingBar);
        TextView reviewTextView = (TextView) convertView.findViewById(R.id.reviewTextView);
        TextView summaryTextView = (TextView) convertView.findViewById(R.id.summaryTextView);

        userNameTextView.setText(opinion.getOwner().getUsername());
        ratingBar.setRating(opinion.getScore());
        reviewTextView.setText(opinion.getReview());
        summaryTextView.setText(opinion.getTitle());

        return convertView;
    }
}
