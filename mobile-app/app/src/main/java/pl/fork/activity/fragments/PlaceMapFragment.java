package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;

import pl.fork.activity.MapsActivity;
import pl.fork.fork.R;
import pl.fork.activity.PlaceDetailsActivity;
import pl.fork.entity.Place;
import pl.fork.web.LoadAllImagesIDTask;

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
    private ObservableScrollView mScrollView;

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

        View rootView = inflater.inflate(R.layout.fragment_place_map, container, false);

        Button btn = (Button) rootView.findViewById(R.id.mapButton);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), MapsActivity.class);
                intent.putExtra("place", place);
                startActivity(intent);
            }
        });

        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mScrollView = (ObservableScrollView) view.findViewById(R.id.scrollView);

        MaterialViewPagerHelper.registerScrollView(getActivity(), mScrollView, null);
    }
}