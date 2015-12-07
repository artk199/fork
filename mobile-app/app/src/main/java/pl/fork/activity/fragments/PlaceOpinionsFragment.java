package pl.fork.activity.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;

import pl.fork.entity.Place;
import pl.fork.fork.R;
import pl.fork.web.LoadOpinionsTask;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceOpinionsFragment extends Fragment {

    private ObservableScrollView mScrollView;

    private static final String ARG_SECTION_NUMBER = "section_number";

    Place place;

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

        LinearLayout linearLayout = (LinearLayout) view.findViewById(R.id.linearLayoutOpinions);

        new LoadOpinionsTask(getContext(),linearLayout).execute(place.getId());

    }

}