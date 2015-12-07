package pl.fork.adapters;

import android.content.Context;
import android.net.Uri;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.etiennelawlor.imagegallery.library.enums.PaletteColorType;
import com.facebook.drawee.view.SimpleDraweeView;

import java.util.List;

import pl.fork.fork.R;


public class FullScreenImageAdapter extends PagerAdapter {

    private List<String> mImages;

    public FullScreenImageAdapter(List<String> images, PaletteColorType paletteColorType) {
        mImages = images;
    }

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

}
