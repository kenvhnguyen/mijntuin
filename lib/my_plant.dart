import 'package:flutter/material.dart';

import 'edit_plant.dart';

class MyPlant extends StatelessWidget {
  MyPlant({this.imageId});
  final int imageId;
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
                return EditPlant();
              }));
            },
            child: Container(
              child: Image.network('https://picsum.photos/id/$imageId/133/100'),
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
