package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.ksoichiro.android.observablescrollview.ObservableScrollView;

import pl.fork.SessionHandler;
import pl.fork.fork.R;
import pl.fork.entity.Place;
import pl.fork.web.LoadAllImagesIDTask;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlacePicturesFragment extends Fragment {

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
    public static PlacePicturesFragment newInstance(int sectionNumber,Place place) {
        PlacePicturesFragment fragment = new PlacePicturesFragment();

        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.place = place;
        fragment.setArguments(args);
        return fragment;
    }

    public PlacePicturesFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_place_pics, container, false);

        Button galleryButton = (Button) rootView.findViewById(R.id.openGalleryButton);
        galleryButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new LoadAllImagesIDTask(getContext()).execute(place.getId());
            }
        });

        if(!SessionHandler.getInstance().isActive()){
            View cardView = rootView.findViewById(R.id.cameraCardView);
            cardView.getLayoutParams().height = 0;
            cardView.setVisibility(View.INVISIBLE);
        }else{
            Button cameraButton = (Button) rootView.findViewById(R.id.cameraButton);
            cameraButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                    if (takePictureIntent.resolveActivity(getContext().getPackageManager()) != null) {
                        startActivityForResult(takePictureIntent, 0);
                    }
                }
            });
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