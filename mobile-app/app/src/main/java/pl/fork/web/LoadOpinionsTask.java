package pl.fork.web;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.RatingBar;
import android.widget.TextView;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

import pl.fork.Config;
import pl.fork.entity.Opinion;
import pl.fork.fork.R;

/**
 * Created by Artur on 2015-11-01.
 */
public class LoadOpinionsTask extends AsyncTask<Object,Void,List<Opinion>> {


    private LinearLayout linearLayout;
    private Context context;

    ArrayAdapter list;
    private static final String LOG_TAG = "LoadOpinionsTask";

    public LoadOpinionsTask(ArrayAdapter list){
        this.list = list;
    }

    public LoadOpinionsTask(Context context, LinearLayout linearLayout) {
        this.context = context;
        this.linearLayout = linearLayout;
    }


    @Override
    protected List<Opinion> doInBackground(Object... params) {
        int id = (int) params[0];

        try {
            final String url = Config.baseURL + "place/getScores/"+Integer.toString(id);
            Log.d(LOG_TAG, "Wołam URL " + url);
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
            Opinion[] opinionsArray = restTemplate.getForObject(url, Opinion[].class);
            List<Opinion> opinions = Arrays.asList(opinionsArray);
            for (Opinion opinion : opinions) {
                Log.d(LOG_TAG, opinion.getReview());
            }
            return opinions;
        }catch (Exception e){

        }
        return null;
    }

    @Override
    protected void onPostExecute(List<Opinion> opinions) {
        if(opinions==null){
            Log.e(LOG_TAG,"Błąd podczas wczytywania opinii.");
            return;
        }

        LayoutInflater inflater = LayoutInflater.from(context);

        for(Opinion opinion: opinions){
            Log.d(LOG_TAG, "Wrzucam do listy wyswietlania: " + opinion.getReview() + "");
            //list.add(opinion);
            View view  = inflater.inflate(R.layout.opinion_row, linearLayout, false);

            TextView userNameTextView = (TextView) view.findViewById(R.id.userNameTextView);
            RatingBar ratingBar = (RatingBar) view.findViewById(R.id.ratingBar);
            TextView reviewTextView = (TextView) view.findViewById(R.id.reviewTextView);
            TextView summaryTextView = (TextView) view.findViewById(R.id.summaryTextView);

            userNameTextView.setText(opinion.getOwner().getUsername());
            ratingBar.setRating(opinion.getScore());
            reviewTextView.setText(opinion.getReview());
            summaryTextView.setText(opinion.getTitle());

            linearLayout.addView(view);
        }
    }

}
