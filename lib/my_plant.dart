import 'package:flutter/material.dart';

import 'edit_plant.dart';

class MyPlant extends StatefulWidget {
  MyPlant(
      {@required this.plantId,
      this.photos,
      this.latinName,
      this.dutchName,
      this.category,
      this.note});
  final String plantId;
  final String latinName;
  final String dutchName;
  final String category;
  final String note;
  final List<Image> photos;

  @override
  _MyPlantState createState() => _MyPlantState();
}

class _MyPlantState extends State<MyPlant> {
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
                  plantId: widget.plantId,
                  image: widget.photos[0],
                  latinName: widget.latinName,
                  dutchName: widget.dutchName,
                  category: widget.category,
                  note: widget.note,
                );
              }));
            },
            child: Container(
              child: widget.photos[0],
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${widget.latinName}'),
              Text('${widget.dutchName}'),
              Text('${widget.category}')
            ],
          )
        ],
      ),
    );
  }
}
