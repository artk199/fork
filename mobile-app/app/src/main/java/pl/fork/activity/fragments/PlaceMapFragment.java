package pl.fork.activity.fragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import and.fork.pl.fork.R;
import pl.fork.activity.PlaceDetailsActivity;
import pl.fork.place.entity.Place;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceMapFragment extends Fragment {
    /**
     * The fragment argument representing the section number for this
     * fragment.
     */
    private static final String ARG_SECTION_NUMBER = "section_number";

    Place place;

    /**
     * Returns a new instance of this fragment for the given section
     * number.
     */
    public static PlaceMapFragment newInstance(int sectionNumber,Place place) {
        PlaceMapFragment fragment = new PlaceMapFragment();

        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.place = place;
        fragment.setArguments(args);
        return fragment;
    }

    public PlaceMapFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_place_details, container, false);
        TextView placeNameTextView = (TextView) rootView.findViewById(R.id.placeNameTextView);
        placeNameTextView.setText(place.getName());
        return rootView;
    }
}