package pl.fork.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;

import com.etiennelawlor.imagegallery.library.enums.PaletteColorType;

import java.util.ArrayList;
import java.util.List;

import pl.fork.adapters.FullScreenImageAdapter;
import pl.fork.fork.R;

/**
 * This code is from https://github.com/lawloretienne/ImageGallery but its after a few changes
 * to adjust it to current project.
 */
public class FullScreenImageActivity extends AppCompatActivity {

    private FullScreenImageAdapter mFullScreenImageGalleryAdapter;
    private List<String> mImages;
    private int mPosition;
    private PaletteColorType mPaletteColorType;

    private Toolbar mToolbar;
    private ViewPager mViewPager;

    private ViewPager.OnPageChangeListener mViewPagerOnPageChangeListener = new ViewPager.OnPageChangeListener() {
        @Override
        public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

        }

        @Override
        public void onPageSelected(int position) {
            if (mViewPager != null) {
                mViewPager.setCurrentItem(position);
                setActionBarTitle(position);
            }
        }

        @Override
        public void onPageScrollStateChanged(int state) {

        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.full_screen_image);

        bindViews();

        setSupportActionBar(mToolbar);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null)
            actionBar.setDisplayHomeAsUpEnabled(true);


        Intent intent = getIntent();
        if (intent != null) {
            Bundle extras = intent.getExtras();
            if (extras != null) {
                mImages = extras.getStringArrayList("images");
                mPaletteColorType = (PaletteColorType) extras.get("palette_color_type");
                mPosition = extras.getInt("position")-3;
            }
        }

        setUpViewPager();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mViewPager.removeOnPageChangeListener(mViewPagerOnPageChangeListener);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        } else {
            return super.onOptionsItemSelected(item);
        }
    }

    private void bindViews() {
        mViewPager = (ViewPager) findViewById(R.id.vp);
        mToolbar = (Toolbar) findViewById(R.id.toolbar);
    }

    private void setUpViewPager(){
        ArrayList<String> images = new ArrayList<>();

        for(String image : mImages){
            images.add(image);
        }

        mFullScreenImageGalleryAdapter = new FullScreenImageAdapter(images, mPaletteColorType);
        mViewPager.setAdapter(mFullScreenImageGalleryAdapter);
        mViewPager.addOnPageChangeListener(mViewPagerOnPageChangeListener);
        mViewPager.setCurrentItem(mPosition);

        setActionBarTitle(mPosition);
    }

    private void setActionBarTitle(int position) {
        if (mViewPager != null && mImages.size() > 1) {
            int totalPages = mViewPager.getAdapter().getCount();
            getSupportActionBar().setTitle(String.format("%d of %d", (position + 1), totalPages));
        }else{
            getSupportActionBar().setTitle("Zdjecie");
        }
    }
}