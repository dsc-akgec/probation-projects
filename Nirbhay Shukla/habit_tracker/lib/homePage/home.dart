import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:soberity_app/database/database_helper.dart';
import 'package:soberity_app/newHabitPage/newhabit.dart';
import 'package:soberity_app/database/data.dart';
import 'package:soberity_app/habitDetailsPage/habitdetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Data> _habits = [];
  int count = 0;
  DataBaseHelper dbhelper = DataBaseHelper();


//To calculate and return abstinence time
  Widget abstinenceTime(DateTime lastinteraction) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(lastinteraction);
    int finalresult = abstime.inHours;
    return Text(
      "$finalresult hours",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }


//To show circular progress bar
  Widget progressbar(DateTime lastinteraction) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(lastinteraction);
    int finalresult = abstime.inHours;
    double barprogress = finalresult / 720;
    var percent = (barprogress * 100).toStringAsFixed(2);
    return CircularPercentIndicator(
      radius: 85.0,
      lineWidth: 8.0,
      percent: barprogress,
      center: new Text(
        "$percent%",
        style: TextStyle(
          fontSize: 15,
          color: Colors.redAccent,
        ),
      ),
      animation: true,
      animationDuration: 1200,
      progressColor: Colors.redAccent,
      backgroundColor: Colors.grey[200],
      footer: new Text(
        "30 DAYS",
        style: TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }


//To display the list of habits
  Widget habitList() {
    if (_habits.length > 0)
      return Column(
        children: _habits
            .map(
              (habit) => Padding(
                padding: EdgeInsets.all(6),
                child: RawMaterialButton(
                  padding: EdgeInsets.all(15),
                  constraints:
                      BoxConstraints(minWidth: double.infinity, minHeight: 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Habitdetails(habit),
                      ),
                    ) as bool;
                    if (result == true) {
                      _habits.remove(habit);
                      deletehabit(context, habit);
                    }
                  },
                  fillColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            habit.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                          ),
                          Text(
                            "Abstinence Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          abstinenceTime(habit.lastinteraction)
                        ],
                      ),
                      progressbar(habit.lastinteraction),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }


//TO modigy habit details
  void updatehabitlist() {
    final Future<Database> dbfuture = dbhelper.initializedb();
    dbfuture.then((db) {
      Future<List<Data>> habitlistfuture = dbhelper.getHabitlist();
      habitlistfuture.then((habitlist) {
        setState(() {
          this._habits = habitlist;
          this.count = habitlist.length;
        });
      });
    });
  }


//To save habit in database
  void savehabit(Data data) async {
    int result = await dbhelper.insert(data);
    print(result);
  }


//To delete habit from database
  void deletehabit(BuildContext context, Data habit) async {
    int result = await dbhelper.delete(habit.name);
    print(result);
    updatehabitlist();
  }


  @override
  void initState() {
    if (_habits == null) _habits = List<Data>();
    updatehabitlist();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soberity',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Milkshake',
            fontSize: 30,
          ),
        ),
        titleSpacing: 0,
        leading: Icon(Icons.mood),
        actions: <Widget>[
          RawMaterialButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NewHabit(),
                ),
              ) as Data;
              if (result.name != null) {
                _habits.add(result);
                savehabit(result);
              }
              setState(() {});
            },
            constraints: BoxConstraints(maxWidth: 50),
          ),
          RawMaterialButton(
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {},
            constraints: BoxConstraints(maxWidth: 50),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.grey, blurRadius: 2)
                  ]),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Quote of the day",
                      style: TextStyle(fontSize: 19, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                      "If you don't like how things are , change it! You're not a tree",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Text("Jim Rohn",
                      style: TextStyle(color: Colors.grey, fontSize: 10))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "I commit to quit :",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            habitList(),
          ],
        ),
      ),
    );
  }
}
