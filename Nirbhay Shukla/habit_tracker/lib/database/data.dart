class Data {
  String name;
  double cost;
  int money;
  DateTime quitdate;
  DateTime lastinteraction;
  Duration maxabstinenceperiod;
  Duration minabstinenceperiod;
  Duration previousabstinenceperiod;
  int resets;
  double spent;
  Data({this.name, this.cost, this.lastinteraction}) {
    quitdate = DateTime.now();
    maxabstinenceperiod = Duration(hours: 0);
    minabstinenceperiod = Duration(hours: 0);
    previousabstinenceperiod = Duration(hours: 0);
    resets = 0;
    spent = 0;
    money = 1;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = name;
    map['cost'] = cost;
    map['money'] = money;
    map['quitdate'] = quitdate.toString();
    map['lastinteraction'] = lastinteraction.toString();
    map['minabstinenceperiod'] = minabstinenceperiod.inSeconds;
    map['maxabstinenceperiod'] = maxabstinenceperiod.inSeconds;
    map['previousabstinenceperiod'] = previousabstinenceperiod.inSeconds;
    map['resets'] = resets;
    map['spent'] = spent;

    return map;
  }

  Data.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.cost = map['cost'];
    this.money = map['money'];
    this.quitdate = DateTime.parse(map['quitdate']);
    this.lastinteraction = DateTime.parse(map['lastinteraction']);
    this.minabstinenceperiod =
        new Duration(seconds: int.parse(map['minabstinenceperiod']));
    this.maxabstinenceperiod =
        new Duration(seconds: int.parse(map['maxabstinenceperiod']));
    this.previousabstinenceperiod =
        new Duration(seconds: int.parse(map['previousabstinenceperiod']));
    this.resets = map['resets'];
    this.spent = map['spent'];
  }
}
