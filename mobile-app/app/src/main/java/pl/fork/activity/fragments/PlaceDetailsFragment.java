package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import pl.fork.activity.MapsActivity;
import pl.fork.fork.R;
import pl.fork.entity.Place;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceDetailsFragment extends Fragment {
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
    public static PlaceDetailsFragment newInstance(int sectionNumber,Place place) {
        PlaceDetailsFragment fragment = new PlaceDetailsFragment();

        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.place = place;
        fragment.setArguments(args);
        return fragment;
    }

    public PlaceDetailsFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View rootView = inflater.inflate(R.layout.fragment_place_details, container, false);
        TextView placeNameTextView = (TextView) rootView.findViewById(R.id.placeNameTextView);
        placeNameTextView.setText(place.getName());

        Button btn = (Button) rootView.findViewById(R.id.mapButton);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(),MapsActivity.class);
                intent.putExtra("place",place);
                startActivity(intent);
            }
        });

        return rootView;
    }
}