package pl.fork.adapters;

import android.content.Context;
import android.net.Uri;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.graphics.Palette;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.etiennelawlor.imagegallery.library.enums.PaletteColorType;
import com.etiennelawlor.imagegallery.library.view.PaletteTransformation;
import com.facebook.drawee.view.SimpleDraweeView;
import com.squareup.picasso.Picasso;

import java.util.List;

import pl.fork.fork.R;

/**
 * Created by etiennelawlor on 8/20/15.
 */
public class FullScreenImageAdapter extends PagerAdapter {

    // region Member Variables
    private List<String> mImages;
    private PaletteColorType mPaletteColorType;
    // endregion

    // region Constructors
    public FullScreenImageAdapter(List<String> images, PaletteColorType paletteColorType) {
        mImages = images;
        mPaletteColorType = paletteColorType;
    }
    // endregion

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        LayoutInflater inflater = (LayoutInflater) container.getContext()
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = inflater.inflate(R.layout.fullscreenimage_image, null);

        SimpleDraweeView draweeView = (SimpleDraweeView) view.findViewById(R.id.my_image_view);

        String image = mImages.get(position);

        if(!TextUtils.isEmpty(image)){
            Uri imageUri = Uri.parse(image);
            draweeView.setImageURI(imageUri);
        }


        ((ViewPager) container).addView(view, 0);

        return view;
    }

    @Override
    public int getCount() {
        return mImages.size();
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        ((ViewPager) container).removeView((View) object);
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }

    // region Helper Methods
    private int getBackgroundColor(Palette palette){
        int bgColor = -1;

        int vibrantColor = palette.getVibrantColor(0x000000);
        int lightVibrantColor = palette.getLightVibrantColor(0x000000);
        int darkVibrantColor = palette.getDarkVibrantColor(0x000000);

        int mutedColor = palette.getMutedColor(0x000000);
        int lightMutedColor = palette.getLightMutedColor(0x000000);
        int darkMutedColor = palette.getDarkMutedColor(0x000000);

        if(mPaletteColorType != null){
            switch (mPaletteColorType){
                case VIBRANT:
                    if(vibrantColor != 0){ // primary option
                        bgColor = vibrantColor;
                    } else if(lightVibrantColor != 0 ){ // fallback options
                        bgColor = lightVibrantColor;
                    } else if(darkVibrantColor != 0){
                        bgColor = darkVibrantColor;
                    } else if(mutedColor != 0){
                        bgColor = mutedColor;
                    } else if(lightMutedColor != 0 ){
                        bgColor = lightMutedColor;
                    } else if(darkMutedColor != 0){
                        bgColor = darkMutedColor;
                    }
                    break;
                case LIGHT_VIBRANT:
                    if(lightVibrantColor != 0 ){ // primary option
                        bgColor = lightVibrantColor;
                    } else if(vibrantColor != 0){ // fallback options
                        bgColor = vibrantColor;
                    } else if(darkVibrantColor != 0){
                        bgColor = darkVibrantColor;
                    } else if(mutedColor != 0){
                        bgColor = mutedColor;
                    } else if(lightMutedColor != 0 ){
                        bgColor = lightMutedColor;
                    } else if(darkMutedColor != 0){
                        bgColor = darkMutedColor;
                    }
                    break;
                case DARK_VIBRANT:
                    if(darkVibrantColor != 0){ // primary option
                        bgColor = darkVibrantColor;
                    } else if(vibrantColor != 0){ // fallback options
                        bgColor = vibrantColor;
                    } else if(lightVibrantColor != 0 ){
                        bgColor = lightVibrantColor;
                    } else if(mutedColor != 0){
                        bgColor = mutedColor;
                    } else if(lightMutedColor != 0 ){
                        bgColor = lightMutedColor;
                    } else if(darkMutedColor != 0){
                        bgColor = darkMutedColor;
                    }
                    break;
                case MUTED:
                    if(mutedColor != 0){ // primary option
                        bgColor = mutedColor;
                    } else if(lightMutedColor != 0 ){ // fallback options
                        bgColor = lightMutedColor;
                    } else if(darkMutedColor != 0){
                        bgColor = darkMutedColor;
                    } else if(vibrantColor != 0){
                        bgColor = vibrantColor;
                    } else if(lightVibrantColor != 0 ){
                        bgColor = lightVibrantColor;
                    } else if(darkVibrantColor != 0){
                        bgColor = darkVibrantColor;
                    }
                    break;
                case LIGHT_MUTED:
                    if(lightMutedColor != 0 ){ // primary option
                        bgColor = lightMutedColor;
                    } else if(mutedColor != 0){ // fallback options
                        bgColor = mutedColor;
                    } else if(darkMutedColor != 0){
                        bgColor = darkMutedColor;
                    } else if(vibrantColor != 0){
                        bgColor = vibrantColor;
                    } else if(lightVibrantColor != 0 ){
                        bgColor = lightVibrantColor;
                    } else if(darkVibrantColor != 0){
                        bgColor = darkVibrantColor;
                    }
                    break;
                case DARK_MUTED:
                    if(darkMutedColor != 0){ // primary option
                        bgColor = darkMutedColor;
                    } else if(mutedColor != 0){ // fallback options
                        bgColor = mutedColor;
                    } else if(lightMutedColor != 0 ){
                        bgColor = lightMutedColor;
                    } else if(vibrantColor != 0){
                        bgColor = vibrantColor;
                    } else if(lightVibrantColor != 0 ){
                        bgColor = lightVibrantColor;
                    } else if(darkVibrantColor != 0){
                        bgColor = darkVibrantColor;
                    }
                    break;
                default:
                    break;
            }
        }

        return bgColor;
    }

}
