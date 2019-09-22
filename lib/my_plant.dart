import 'package:flutter/material.dart';

import 'edit_plant.dart';

class MyPlant extends StatelessWidget {
  MyPlant(
      {this.photos, this.latinName, this.dutchName, this.category, this.note});
  final String latinName;
  final String dutchName;
  final String category;
  final String note;
  final List<Image> photos;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditPlant(
                  image: photos[0],
                  latinName: latinName,
                  dutchName: dutchName,
                  category: category,
                  note: note,
                );
              }));
            },
            child: Container(
              child: photos[1],
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Latin Name: $latinName'),
              Text('Dutch Name: $dutchName'),
              Text('Category: $category')
            ],
          )
        ],
      ),
    );
  }
}
