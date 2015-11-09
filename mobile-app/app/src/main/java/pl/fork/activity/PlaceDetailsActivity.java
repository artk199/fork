package pl.fork.activity;

import java.util.Locale;

import android.support.v7.app.AppCompatActivity;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import and.fork.pl.fork.R;
import pl.fork.activity.fragments.PlaceDetailsFragment;
import pl.fork.activity.fragments.PlaceMapFragment;
import pl.fork.activity.fragments.PlaceOpinionsFragment;
import pl.fork.activity.fragments.PlacePicturesFragment;
import pl.fork.place.entity.Place;

public class PlaceDetailsActivity extends AppCompatActivity {

    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v4.app.FragmentStatePagerAdapter}.
     */
    SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    ViewPager mViewPager;


    /**
     * Obiekt ktorego szczegóły wyswietlamy.
     */
    Place place;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_place_details);

        this.place = (Place) getIntent().getSerializableExtra("place");

        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager(),place);

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.pager);
        mViewPager.setAdapter(mSectionsPagerAdapter);

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_place_details, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
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
                    return PlacePicturesFragment.newInstance(position + 1, place);
                case 2:
                    return PlaceOpinionsFragment.newInstance(position + 1,place);
            }
            return null;
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 3;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.title_section_description).toUpperCase(l);
                case 1:
                    return getString(R.string.title_section_photos).toUpperCase(l);
                case 2:
                    return getString(R.string.title_section_map).toUpperCase(l);
            }
            return null;
        }
    }

}
