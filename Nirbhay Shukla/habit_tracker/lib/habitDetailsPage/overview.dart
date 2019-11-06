import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:soberity_app/database/data.dart';

class Overview extends StatefulWidget {
  final Data habit;

  Overview(this.habit);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Data habit;
  CalendarController controller;

//To show circular progress bar
  Widget progressbar(DateTime lastinteraction) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(lastinteraction);
    int finalresult = abstime.inHours;
    double barprogress = finalresult / 720;
    var percent = (barprogress * 100).toStringAsFixed(2);
    return CircularPercentIndicator(
      radius: 140.0,
      lineWidth: 8.0,
      percent: barprogress,
      center: new Text(
        "$percent%",
        style: TextStyle(
          fontSize: 25,
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
          fontSize: 12,
        ),
      ),
    );
  }

//To calculate current abstinence time
  Widget abstinenceTime(DateTime lastinteraction) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(lastinteraction);
    int finalresult = abstime.inHours;
    return Text(
      "$finalresult hours",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

//To calculate and return current savings
  Widget currentsavings(Data habit) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(habit.lastinteraction);
    double currentsavings = abstime.inHours / 24 * habit.cost;
    String result = '';
    if (habit.money == 1)
      result = "₹ " + currentsavings.toStringAsFixed(0);
    else
      result = currentsavings.toStringAsFixed(0) + " hours";
    return Text(
      result,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

//To calculate and return all time savings
  Widget alltimesavings(Data habit) {
    String result;
    DateTime current = DateTime.now();
    Duration abstime = current.difference(habit.lastinteraction);
    double currentsavings = abstime.inHours / 24 * habit.cost;
    if (habit.money == 1)
      result = "₹ " + (habit.spent + currentsavings).toStringAsFixed(0);
    else
      result = (habit.spent + currentsavings).toStringAsFixed(0) + " hours";

    return Text(
      result,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

//Widget which acts as border
  Container borderline() {
    return Container(
      margin: EdgeInsets.all(15),
      color: Colors.grey[200],
      constraints:
          BoxConstraints(maxHeight: 1, minHeight: 1, minWidth: double.infinity),
    );
  }

//To modify habit details
  void updatehabit(Data habit) {
    DateTime current = DateTime.now();
    Duration abstime = current.difference(habit.lastinteraction);
    double currentsaving = abstime.inHours / 24 * habit.cost;

    habit.resets = habit.resets + 1;
    habit.spent = habit.spent + currentsaving;
    habit.previousabstinenceperiod = abstime;
    habit.lastinteraction = DateTime.now();
    if (habit.maxabstinenceperiod.compareTo(abstime) < 0)
      habit.maxabstinenceperiod = abstime;
    if (habit.minabstinenceperiod.compareTo(abstime) > 0)
      habit.minabstinenceperiod = abstime;
  }

  @override
  void initState() {
    habit = widget.habit;
    controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          progressbar(habit.lastinteraction),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Center(
            child: Text("I can achieve anything !",
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          borderline(),
          Center(
            child: Text(
              "Abstinence Time",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Center(
            child: abstinenceTime(habit.lastinteraction),
          ),
          borderline(),
          Center(
            child: Text(
              "Current period savings",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
          ),
          Center(
            child: currentsavings(habit),
          ),
          Padding(
            padding: EdgeInsets.all(3),
          ),
          Center(
            child: Text(
              "All time savings",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
          ),
          Center(child: alltimesavings(habit)),
          borderline(),
          TableCalendar(
            calendarController: controller,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            startingDayOfWeek: StartingDayOfWeek.monday,
            weekendDays: [DateTime.sunday],
            headerStyle: HeaderStyle(centerHeaderTitle: true),
            calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(color: Colors.black),
                outsideWeekendStyle: TextStyle(color: Color(0xFF9E9E9E)),
                todayColor: Colors.red[100],
                selectedColor: Colors.redAccent),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RawMaterialButton(
              constraints: BoxConstraints(minHeight: 50),
              fillColor: Colors.redAccent,
              elevation: 0,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              onPressed: () {
                updatehabit(habit);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Updated !"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.restore, color: Colors.white),
                  Text("  RESET TIMER",
                      style: TextStyle(fontSize: 15, color: Colors.white))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
