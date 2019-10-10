import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mijn_tuin/update_text_field.dart';

class EditPlant extends StatefulWidget {
  EditPlant({
    this.image,
    this.latinName,
    this.dutchName,
    this.category,
    this.note,
  });
  final Image image;
  final String latinName;
  final String dutchName;
  final String category;
  final String note;

  @override
  _EditPlantState createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  final TextEditingController latinTextEditingController =
      TextEditingController();
  final TextEditingController dutchTextEditingController =
      TextEditingController();
  final TextEditingController categoryTextEditingController =
      TextEditingController();
  final TextEditingController noteTextEditingController =
      TextEditingController();
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
        title: Text('Edit Plant'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(child: widget.image),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('Latin: '),
                    Flexible(
                      child: new UpdatableTextField(
                        itemName: widget.latinName,
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
    );
  }
}
