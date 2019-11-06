import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  String about =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  Widget title(String letter, int pos) {
    List<Color> color = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow[600]
    ];
    return Text(
      letter,
      style: TextStyle(
          color: color[pos], fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget domains() {
    List<String> domains = [
      "Machine Learning",
      "Application Development",
      "Website Development",
      "Managerial"
    ];

    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow[600]
    ];
    int pos = 0;

    return Row(
      children: domains
          .map(
            (domain) => Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(2),
                color: colors[pos++],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.transparent,
                    constraints: BoxConstraints(
                      minHeight: 280,
                      maxHeight: 280,
                      minWidth: 200,
                      maxWidth: 200,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          domain,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        border(),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.justify,
                            )),
                      ],
                    )),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget heading(String header){
return Container(
            padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 10),
            child: Text(
              header,
              style: TextStyle(fontSize: 30),
            ),
          );
  }

  Widget apptitle() {
    return Row(
      children: <Widget>[
        title("D", 1),
        title("S", 2),
        title("C", 3),
      ],
    );
  }

  Widget border() {
    return Container(
      height: 1,
      width: 180,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: apptitle(),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          heading("About :"),
          Container(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            child: Text(
              about,
              textAlign: TextAlign.justify,
            ),
          ),
          heading("Domains"),
          Container(
            height: 300,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                domains(),
              ],
            ),
          ),
          heading("Developers :"),
          Padding(
            padding: EdgeInsets.all(10),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              constraints:
                  BoxConstraints(maxHeight: 50, maxWidth: 010, minHeight: 50),
              onPressed: () {},
              fillColor: Colors.blue,
              child: Text(
                "Contact Us",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
