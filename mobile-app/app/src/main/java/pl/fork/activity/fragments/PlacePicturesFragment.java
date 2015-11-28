package pl.fork.activity.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.etiennelawlor.imagegallery.library.util.ImageGalleryUtils;
import com.etiennelawlor.imagegallery.library.view.GridSpacesItemDecoration;
import com.github.florent37.materialviewpager.MaterialViewPagerHelper;
import com.github.florent37.materialviewpager.adapter.RecyclerViewMaterialAdapter;

import java.util.ArrayList;

import pl.fork.UtilFunctions;
import pl.fork.activity.FullScreenImageActivity;
import pl.fork.adapters.ImageAdapter;
import pl.fork.entity.ForkImage;
import pl.fork.entity.Place;
import pl.fork.fork.R;

/**
 * Created by Artur on 2015-11-07.
 */
public class PlacePicturesFragment extends Fragment implements ImageAdapter.OnImageClickListener {

    private RecyclerView mRecyclerView;
    private ImageAdapter mImageGalleryAdapter;
    ArrayList<String> pictures;
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
        pictures = new ArrayList<>();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_place_pics, container, false);
        pictures.clear();
        for (ForkImage forkImage : place.getImages()) {
            pictures.add(UtilFunctions.getImageURI(forkImage.getId()));
        }
        return rootView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        bindViews(view);
        setUpRecyclerView();
        MaterialViewPagerHelper.registerRecyclerView(getActivity(), mRecyclerView, null);
    }


    private void bindViews(View root) {
        mRecyclerView = (RecyclerView) root.findViewById(R.id.rv);
    }

    private void setUpRecyclerView(){
        int numOfColumns=3;

        mRecyclerView.setLayoutManager(new GridLayoutManager(getContext(), numOfColumns));
        mRecyclerView.addItemDecoration(new GridSpacesItemDecoration(ImageGalleryUtils.dp2px(getContext(), 2), numOfColumns));
        mImageGalleryAdapter = new ImageAdapter(pictures);
        mImageGalleryAdapter.setOnImageClickListener(this);
        RecyclerViewMaterialAdapter mAdapter = new RecyclerViewMaterialAdapter(mImageGalleryAdapter,3);
        mRecyclerView.setAdapter(mAdapter);
    }

    @Override
    public void onImageClick(View view, int position) {
        Intent intent = new Intent(getActivity(), FullScreenImageActivity.class);

        intent.putStringArrayListExtra("images", pictures);
        intent.putExtra("position", position);

        startActivity(intent);
    }
}