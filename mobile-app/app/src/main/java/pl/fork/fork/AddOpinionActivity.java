package pl.fork.fork;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RatingBar;

import pl.fork.activity.MapsActivity;
import pl.fork.entity.Opinion;
import pl.fork.entity.Place;
import pl.fork.web.AddOpinionTask;

public class AddOpinionActivity extends AppCompatActivity {

    Place place;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_opinion);

        this.place = (Place) getIntent().getSerializableExtra("place");

        Button btn = (Button) findViewById(R.id.addOpinion);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                /* Views */
                EditText titleText = (EditText) findViewById(R.id.titleEditText);
                EditText editText = (EditText) findViewById(R.id.editText);
                RatingBar ratingBar = (RatingBar) findViewById(R.id.ratingBar);

                Opinion opinion = new Opinion();
                opinion.setScore(Math.round(ratingBar.getRating()));
                opinion.setTitle(titleText.getText().toString());
                opinion.setReview(editText.getText().toString());
                new AddOpinionTask(getApplicationContext()).execute(opinion,place.getId());
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_add_opinion, menu);
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
}
