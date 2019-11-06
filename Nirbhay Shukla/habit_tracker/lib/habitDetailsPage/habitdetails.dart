import 'package:flutter/material.dart';

import 'package:soberity_app/database/data.dart';
import 'package:soberity_app/habitDetailsPage/overview.dart';
import 'package:soberity_app/habitDetailsPage/statistics.dart';

class Habitdetails extends StatelessWidget {
  final Data habit;

  Habitdetails(this.habit);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(habit.name,
              style: TextStyle(fontFamily: 'Milkshake', fontSize: 25)),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Confirm"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.description),
                text: "Overview",
              ),
              Tab(
                icon: Icon(Icons.timeline),
                text: "Statistics",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[Overview(habit), Statistics(habit)],
        ),
      ),
    );
  }
}
