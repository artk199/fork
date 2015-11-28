package pl.fork.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.florent37.materialviewpager.MaterialViewPager;
import com.nostra13.universalimageloader.core.ImageLoader;

import java.util.Locale;

import pl.fork.Config;
import pl.fork.activity.fragments.PlaceDetailsFragment;
import pl.fork.activity.fragments.PlaceMapFragment;
import pl.fork.activity.fragments.PlaceOpinionsFragment;
import pl.fork.activity.fragments.PlacePicturesFragment;
import pl.fork.entity.Place;
import pl.fork.fork.R;

public class PlaceDetailsActivity extends AppCompatActivity {


    SectionsPagerAdapter mSectionsPagerAdapter;
    MaterialViewPager mViewPager;

    /**
     * Obiekt ktorego szczegóły wyswietlamy.
     */
    Place place;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_place_details);

        this.place = (Place) getIntent().getSerializableExtra("place");

        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager(),place);
        mViewPager = (MaterialViewPager) findViewById(R.id.materialViewPager);

        ViewPager viewPager = mViewPager.getViewPager();
        viewPager.setAdapter(mSectionsPagerAdapter);

        mViewPager.getPagerTitleStrip().setViewPager(mViewPager.getViewPager());

        ImageView placeImageView = (ImageView) findViewById(R.id.logo_place);

        /** Pobranie obrazka oraz wstawienie go */
        if(place.getImageID() != -1) {
            ImageLoader imageLoader = ImageLoader.getInstance();
            imageLoader.displayImage(Config.baseURL + "image/" + place.getImageID(), placeImageView);
        }

        /** Ustawienie nazwy miejsca */
        TextView textView = (TextView) findViewById(R.id.place_name);
        textView.setText(place.getName());

        //setup toolbar
        setSupportActionBar(mViewPager.getToolbar());
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayShowTitleEnabled(false);
            actionBar.setDisplayHomeAsUpEnabled(true);
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        return true;
    }

    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        Place place;

        public SectionsPagerAdapter(FragmentManager fm,Place place) {
            super(fm);
            this.place = place;
        }

        @Override
        public Fragment getItem(int position) {
            switch(position){
                case 0:
                    return PlaceDetailsFragment.newInstance(position + 1, place);
                case 1:
                    return PlaceOpinionsFragment.newInstance(position + 1,place);
                case 2:
                    return PlacePicturesFragment.newInstance(position + 1, place);
                case 3:
                    return PlaceMapFragment.newInstance(position + 1,place);
            }
            return null;
        }

        @Override
        public int getCount() {
            return 4;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.title_section_description).toUpperCase(l);
                case 1:
                    return getString(R.string.title_section_opinion).toUpperCase(l);
                case 2:
                    return getString(R.string.title_section_photos).toUpperCase(l);
                case 3:
                    return getString(R.string.title_section_map).toUpperCase(l);
            }
            return null;
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        onBackPressed();
        return true;
    }

}
