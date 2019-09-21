import 'package:flutter/material.dart';

class NewPlant extends StatelessWidget {
  NewPlant({this.latinName, this.dutchName, this.category, this.note});
  final Image image = Image.network('https://picsum.photos/id/935/400/300');
  final String latinName;
  final String dutchName;
  final String category;
  final String note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Plant'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              image,
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Latin Name: '),
                    Text(latinName),
                  ]),
                  Row(children: <Widget>[
                    Text('Dutch Name: '),
                    Text(dutchName),
                  ]),
                  Row(children: <Widget>[
                    Text('Category: '),
                    Text(category),
                  ]),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontFamily: "Poppin",
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'My note',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  maxLines: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
