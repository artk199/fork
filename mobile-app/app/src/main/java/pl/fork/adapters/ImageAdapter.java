package pl.fork.adapters;

import android.net.Uri;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;

import com.etiennelawlor.imagegallery.library.util.ImageGalleryUtils;
import com.facebook.drawee.view.SimpleDraweeView;

import java.util.List;

import pl.fork.SessionHandler;
import pl.fork.fork.R;

/**
 * Created by etiennelawlor on 8/20/15.
 */
public class ImageAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    // region Member Variables
    private List<String> mImages;
    private int mGridItemWidth;
    private int mGridItemHeight;
    private OnImageClickListener mOnImageClickListener;

    public interface OnImageClickListener {
        void onImageClick(View view, int position);
    }
    public ImageAdapter(List<String> images) {
        mImages = images;
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.image_thumbnail, viewGroup, false);

        v.setLayoutParams(getGridItemLayoutParams(v));

        return new ImageViewHolder(v);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder viewHolder, int position) {

        final ImageViewHolder holder = (ImageViewHolder) viewHolder;
        String image = mImages.get(position);
        Uri uri = Uri.parse(image);
        holder.draweeView.setImageURI(uri);

    }

    @Override
    public int getItemCount() {
        int size;

        if(mImages != null){
            size = mImages.size();
        } else {
            size = 0;
        }

        return size;
    }

    public void setOnImageClickListener(OnImageClickListener listener) {
        this.mOnImageClickListener = listener;
    }

    private ViewGroup.LayoutParams getGridItemLayoutParams(View view) {
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        int screenWidth = ImageGalleryUtils.getScreenWidth(view.getContext());
        int numOfColumns = 3;

        mGridItemWidth = screenWidth / numOfColumns;
        mGridItemHeight = screenWidth / numOfColumns;

        layoutParams.width = mGridItemWidth;
        layoutParams.height = mGridItemHeight;

        return layoutParams;
    }

    //Wyswietlanie miniaturki zdjecia
    public class ImageViewHolder extends RecyclerView.ViewHolder {
        private SimpleDraweeView draweeView;
        private FrameLayout mFrameLayout;

        public ImageViewHolder(final View view) {
            super(view);
            draweeView = (SimpleDraweeView) view.findViewById(R.id.my_image_view);
            mFrameLayout = (FrameLayout) view.findViewById(R.id.fl);

            mFrameLayout.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (mOnImageClickListener != null) {
                        mOnImageClickListener.onImageClick(view, getAdapterPosition());
                    }
                }
            });
        }
    }


}