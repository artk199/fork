package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RatingBar;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.florent37.materialviewpager.adapter.RecyclerViewMaterialAdapter;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;
import com.nostra13.universalimageloader.core.ImageLoader;

import java.util.ArrayList;
import java.util.List;

import pl.fork.Config;
import pl.fork.activity.MapsActivity;
import pl.fork.adapters.OpinionsListAdapter;
import pl.fork.entity.Opinion;
import pl.fork.fork.AddOpinionActivity;
import pl.fork.fork.R;
import pl.fork.entity.Place;
import pl.fork.web.LoadOpinionsTask;

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

    private ObservableScrollView mScrollView;

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
        }

        TextView descriptionTextView = (TextView) rootView.findViewById(R.id.descriptionTextView);
        descriptionTextView.setText(place.getDescription());

        TextView townTextView = (TextView) rootView.findViewById(R.id.townTextView);
        townTextView.setText(place.getTown());

        TextView addressTextView = (TextView) rootView.findViewById(R.id.addressTextView);
        addressTextView.setText(place.getAddress());

        RatingBar ratingBar = (RatingBar) rootView.findViewById(R.id.ratingBar);
        ratingBar.setRating((float) 3.4);


       /* Button btn = (Button) rootView.findViewById(R.id.mapButton);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), MapsActivity.class);
                intent.putExtra("place", place);
                startActivity(intent);
            }
        });
       */
        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mScrollView = (ObservableScrollView) view.findViewById(R.id.scrollView);

        MaterialViewPagerHelper.registerScrollView(getActivity(), mScrollView, null);
    }
}