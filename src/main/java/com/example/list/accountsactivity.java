package com.example.list;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class accountsactivity extends AppCompatActivity {
    Button button2;
    Button button3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accountsactivity);
        button2=(Button) findViewById(R.id.button2);
        button3 =(Button) findViewById(R.id.button3);
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                accounts2();
            }
        });
        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                 accounts2();
            }
        });

    }
    public void accounts2()
    {

        Intent intent = new Intent(this, accounts2.class );
        startActivity(intent);

    }
}
