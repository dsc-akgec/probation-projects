package com.example.list;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

public class MainActivity extends AppCompatActivity {
     ImageButton button;
     ImageButton Button2;





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        button = (ImageButton) findViewById(R.id.Button1);
        Button2 = (ImageButton)findViewById(R.id.imageButton2);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openactivity2();
            }
        });
        Button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v1) {
                openaccountsactivity();
            }
        });

    }
     public void openactivity2()
     {
         Intent intent = new Intent(this, Activity2.class );
         startActivity(intent);
     }
    public void openaccountsactivity()
    {
        Intent intent2 = new Intent(this, accountsactivity.class );
        startActivity(intent2);
    }

}
