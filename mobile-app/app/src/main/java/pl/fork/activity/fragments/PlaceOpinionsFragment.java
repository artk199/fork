package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

import pl.fork.activity.MapsActivity;
import pl.fork.fork.AddOpinionActivity;
import pl.fork.fork.R;
import pl.fork.adapters.OpinionsListAdapter;
import pl.fork.adapters.PlaceListAdapter;
import pl.fork.listeners.PlaceListClickListener;
import pl.fork.entity.Opinion;
import pl.fork.entity.Place;
import pl.fork.web.LoadOpinionsTask;

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

        Button btn = (Button) rootView.findViewById(R.id.addOpinionButton);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(),AddOpinionActivity.class);
                intent.putExtra("place",place);
                startActivity(intent);
            }
        });

        OpinionsListAdapter adapter = (OpinionsListAdapter)placesListView.getAdapter();

        if(adapter == null) {
            List<Opinion> opinions = new ArrayList<Opinion>();
            adapter = new OpinionsListAdapter(rootView.getContext(), opinions);
            placesListView.setAdapter(adapter);
        }
        if(place != null) {
            new LoadOpinionsTask(adapter).execute(place.getId());
            TextView placeNameTextView = (TextView) rootView.findViewById(R.id.placeNameTextView);
            placeNameTextView.setText(place.getName());
        }
        return rootView;
    }
}