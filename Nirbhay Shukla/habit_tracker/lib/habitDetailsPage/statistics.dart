import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:soberity_app/database/data.dart';

class Statistics extends StatefulWidget {
  final Data habit;
  Statistics(this.habit);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Data habit;

  Row details(IconData icon, String title, String value) {
    return Row(
      children: <Widget>[
        Container(
          color: Colors.white,
          constraints: BoxConstraints(
            minHeight: 80,
            maxHeight: 80,
            maxWidth: 80,
            minWidth: 80,
          ),
          child: Icon(
            icon,
            color: Colors.redAccent,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            )
          ],
        ),
      ],
    );
  }

  Widget wasted(habit) {
    String spent = (habit.cost * habit.resets).toString();
    if (habit.money == 1) {
      spent = "₹ " + spent;
      return details(Icons.attach_money, "Money wasted", spent);
    } else {
      spent = spent + " hours";
      return details(Icons.timer, "Time wasted", spent);
    }
  }

  Container borderline() {
    return Container(
      color: Colors.grey[200],
      constraints:
          BoxConstraints(maxHeight: 1, minHeight: 1, minWidth: double.infinity),
    );
  }

  @override
  void initState() {
    habit = widget.habit;
    Duration zero = Duration(hours: 0);
    if (habit.maxabstinenceperiod.compareTo(zero) == 0) {
      habit.maxabstinenceperiod =
          DateTime.now().difference(habit.lastinteraction);
      habit.minabstinenceperiod =
          DateTime.now().difference(habit.lastinteraction);
      habit.previousabstinenceperiod =
          DateTime.now().difference(habit.lastinteraction);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          details(Icons.date_range, "The day you quit",
              DateFormat.yMMMEd().format(habit.quitdate)),
          borderline(),
          details(Icons.hourglass_full, "Max abstinence time",
              habit.maxabstinenceperiod.inHours.toString() + " hours"),
          borderline(),
          details(Icons.hourglass_empty, "Min abstinence time",
              habit.minabstinenceperiod.inHours.toString() + " hours"),
          borderline(),
          details(Icons.watch_later, "Previous abstinence time",
              habit.previousabstinenceperiod.inHours.toString() + " hours"),
          borderline(),
          details(Icons.settings_backup_restore, "Number of resets",
              habit.resets.toString()),
          borderline(),
          wasted(habit),
          borderline(),
        ],
      ),
    );
  }
}
