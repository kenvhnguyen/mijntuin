import 'package:flutter/material.dart';

import 'edit_plant.dart';

class MyPlant extends StatelessWidget {
  MyPlant({this.photo});
  final Image photo;
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
                  image: photo,
                  latinName: 'hey',
                  dutchName: 'goed',
                  category: 'Rare very',
                  note: 'yyyyy',
                );
              }));
            },
            child: Container(
              child: photo,
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Latin Name'),
              Text('Dutch Name'),
              Text('Category')
            ],
          )
        ],
      ),
    );
  }
}
