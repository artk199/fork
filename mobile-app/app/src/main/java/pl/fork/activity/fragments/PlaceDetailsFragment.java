package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;

import pl.fork.SessionHandler;
import pl.fork.entity.Place;
import pl.fork.fork.AddOpinionActivity;
import pl.fork.fork.R;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlaceDetailsFragment extends Fragment {

    private static final String ARG_SECTION_NUMBER = "section_number";

    Place place;

    private ObservableScrollView mScrollView;

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

        Button btn = (Button) rootView.findViewById(R.id.addOpinionButton);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(),AddOpinionActivity.class);
                intent.putExtra("place",place);
                startActivity(intent);
            }
        });



        TextView descriptionTextView = (TextView) rootView.findViewById(R.id.descriptionTextView);
        descriptionTextView.setText(place.getDescription());

        TextView townTextView = (TextView) rootView.findViewById(R.id.townTextView);
        townTextView.setText(place.getTown());

        TextView addressTextView = (TextView) rootView.findViewById(R.id.addressTextView);
        addressTextView.setText(place.getAddress());

        RatingBar ratingBar = (RatingBar) rootView.findViewById(R.id.ratingBar);
        ratingBar.setRating(place.getAvgScore().floatValue());

        if(!SessionHandler.getInstance().isActive()){
            Button addOpinionButton = (Button) rootView.findViewById(R.id.addOpinionButton);
            addOpinionButton.getLayoutParams().height = 0;
            addOpinionButton.setVisibility(View.INVISIBLE);
        }

        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mScrollView = (ObservableScrollView) view.findViewById(R.id.scrollView);

        MaterialViewPagerHelper.registerScrollView(getActivity(), mScrollView, null);
    }
}