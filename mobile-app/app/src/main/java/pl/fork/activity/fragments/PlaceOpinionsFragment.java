package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;

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

    private ObservableScrollView mScrollView;

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

        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mScrollView = (ObservableScrollView) view.findViewById(R.id.scrollView);

        MaterialViewPagerHelper.registerScrollView(getActivity(), mScrollView, null);
    }

}