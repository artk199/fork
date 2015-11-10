package pl.fork.activity.fragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

import and.fork.pl.fork.R;
import pl.fork.adapters.OpinionsListAdapter;
import pl.fork.adapters.PlaceListAdapter;
import pl.fork.listeners.PlaceListClickListener;
import pl.fork.place.entity.Opinion;
import pl.fork.place.entity.Place;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceOpinionsFragment extends Fragment {
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
    public static PlaceOpinionsFragment newInstance(int sectionNumber,Place place) {
        PlaceOpinionsFragment fragment = new PlaceOpinionsFragment();

        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.place = place;
        fragment.setArguments(args);
        return fragment;
    }

    public PlaceOpinionsFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_place_opinions, container, false);

        ListView placesListView = (ListView) rootView.findViewById(R.id.listView);


        OpinionsListAdapter adapter = (OpinionsListAdapter)placesListView.getAdapter();

        if(adapter == null) {
            List<Opinion> opinions = new ArrayList<Opinion>();
            opinions.add(new Opinion());
            opinions.add(new Opinion());
            opinions.add(new Opinion());
            adapter = new OpinionsListAdapter(rootView.getContext(), opinions);
            placesListView.setAdapter(adapter);
        }

        TextView placeNameTextView = (TextView) rootView.findViewById(R.id.placeNameTextView);
        placeNameTextView.setText(place.getName());
        return rootView;
    }
}