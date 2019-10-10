import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mijn_tuin/update_text_field.dart';

class NewPlant extends StatefulWidget {
  NewPlant({this.latinName, this.dutchName, this.category, this.note});
  final String latinName;
  final String dutchName;
  final String category;
  final String note;

  @override
  _NewPlantState createState() => _NewPlantState();
}

class _NewPlantState extends State<NewPlant> {
  static String defaultImageLink = 'https://picsum.photos/id/935/400/300';
  final Image image = Image.network(defaultImageLink);
  final TextEditingController latinTextEditingController =
      TextEditingController();
  final TextEditingController dutchTextEditingController =
      TextEditingController();
  final TextEditingController categoryTextEditingController =
      TextEditingController();
  final TextEditingController noteTextEditingController =
      TextEditingController();
  final _store = Firestore.instance;

  @override
  void initState() {
    super.initState();
    latinTextEditingController.value = TextEditingValue(text: widget.latinName);
    dutchTextEditingController.value = TextEditingValue(text: widget.dutchName);
    categoryTextEditingController.value =
        TextEditingValue(text: widget.category);
    noteTextEditingController.value = TextEditingValue(text: widget.note);
  }

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
              Expanded(child: image),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Latin: '),
                    Flexible(
                      child: new UpdatableTextField(
                        itemName: latinTextEditingController.text,
                        fieldName: 'latinName',
                        controller: latinTextEditingController,
                        inputDecoration: InputDecoration.collapsed(
                            hintText: 'Latin name of the plant'),
                        maxLines: 1,
                      ),
                    ),
                  ]),
                  Row(children: <Widget>[
                    Text('Nederlands: '),
                    Flexible(
                      child: UpdatableTextField(
                        itemName: widget.latinName,
                        fieldName: 'dutchName',
                        controller: dutchTextEditingController,
                        inputDecoration: InputDecoration.collapsed(
                            hintText: 'Dutch name of the plant'),
                        maxLines: 1,
                      ),
                    ),
                  ]),
                  Row(children: <Widget>[
                    Text('Category: '),
                    Flexible(
                        child: UpdatableTextField(
                      itemName: widget.latinName,
                      fieldName: 'category',
                      controller: categoryTextEditingController,
                      inputDecoration: InputDecoration.collapsed(
                          hintText: 'Category of the plant'),
                      maxLines: 1,
                    )),
                  ]),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: UpdatableTextField(
                  itemName: widget.latinName,
                  fieldName: 'note',
                  controller: noteTextEditingController,
                  inputDecoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'My note',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  maxLines: 50,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _store.collection('plants').add({
            'imageLink': defaultImageLink,
            'latinName': latinTextEditingController.text,
            'dutchName': dutchTextEditingController.text,
            'category': categoryTextEditingController.text,
            'note': noteTextEditingController.text
          });
        },
        tooltip: 'Save all',
        child: Icon(Icons.save),
      ), // This tr
    );
  }
}
