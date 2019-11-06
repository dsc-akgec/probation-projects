import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:soberity_app/database/data.dart';

class NewHabit extends StatefulWidget {
  @override
  _NewHabitState createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {

  Data newhabit;
  String selected;
  String dateformat;
  List<String> menuitems = ["Money", "Time"];
  List<DropdownMenuItem<String>> menu = [];
  int itemselected = 0;

  List<DropdownMenuItem<String>> getmenu() {
    List<DropdownMenuItem<String>> items = new List();
    for (String item in menuitems) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

//To display ruppee symbol as prefix
  Widget prefixWidget() {
    if (selected == "Money")
      return Text("₹");
    else
      return Container(
        width: 0,
        height: 0,
      );
  }

//To display hours as suffix
  Widget suffixWidget() {
    if (selected == "Time")
      return Text("hours");
    else
      return Container(
        width: 0,
        height: 0,
      );
  }


  @override
  void initState() {
    menu = getmenu();
    selected = menu[0].value;
    newhabit = Data(name: '', cost: 0, lastinteraction: DateTime.now());
    dateformat = DateFormat.yMMMd().format(newhabit.lastinteraction);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Commit to Quit",
          style: TextStyle(fontFamily: 'Milkshake', fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "What addiction or bad habit do you want to quit?",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      TextField(
                        onChanged: (String value) {
                          newhabit.name = value;
                        },
                        onSubmitted: (String value) {
                          newhabit.name = value;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text("What does this habit cost you?"),
                      DropdownButton(
                        value: selected,
                        items: menu,
                        onChanged: (String value) {
                          selected = value;
                          if (value == "Money")
                            newhabit.money = 1;
                          else
                            newhabit.money = 0;
                          setState(() {});
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          newhabit.cost = double.parse(value);
                        },
                        onSubmitted: (String value) {
                          newhabit.cost = double.parse(value);
                        },
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.redAccent,
                        decoration: InputDecoration(
                            hintText: "Cost",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w400),
                            prefix: prefixWidget(),
                            prefixStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            suffix: suffixWidget(),
                            suffixStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        "When was the last time?",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      RawMaterialButton(
                        constraints: BoxConstraints(
                          minHeight: 40,
                          minWidth: 180,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            side:
                                BorderSide(color: Colors.redAccent, width: 3)),
                        child: Text(
                          dateformat,
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () async {
                          final selecteddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now(),
                            firstDate: DateTime(2018),
                          );
                          if (selecteddate != null) {
                            newhabit.lastinteraction = selecteddate;
                          }
                          final selectedtime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: newhabit.lastinteraction.hour,
                                minute: newhabit.lastinteraction.minute),
                          );
                          if (selectedtime != null) {
                            newhabit.lastinteraction = DateTime(
                                newhabit.lastinteraction.year,
                                newhabit.lastinteraction.month,
                                newhabit.lastinteraction.day,
                                selectedtime.hour,
                                selectedtime.minute,
                                newhabit.lastinteraction.second);
                            newhabit.quitdate = newhabit.lastinteraction;
                          }
                          dateformat = DateFormat.yMMMd()
                              .format(newhabit.lastinteraction);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RawMaterialButton(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if(newhabit.name=="" ||newhabit.cost==0.0)
                  showDialog(
                      context: context, builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text("Fill Completely"),
                        actions: <Widget>[
                          FlatButton(child: Text("OK"),onPressed: (){
                            Navigator.pop(context);
                          },),

                        ],
                       );
                      },);
                      else
                  Navigator.pop(context, newhabit);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                fillColor: Colors.redAccent,
                constraints: BoxConstraints(
                  minHeight: 50,
                  minWidth: double.infinity,
                ),
              ),
            ],
          )),
    );
  }
}
