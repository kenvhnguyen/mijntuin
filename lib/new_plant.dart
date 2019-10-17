import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mijn_tuin/take_picture_screen.dart';
import 'package:mijn_tuin/update_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

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
  final Image defaultImage = Image.network(defaultImageLink);
  File _image;
  Widget imagePlaceHolder;

  @override
  void initState() {
    super.initState();
    latinTextEditingController.value = TextEditingValue();
    dutchTextEditingController.value = TextEditingValue();
    categoryTextEditingController.value = TextEditingValue();
    noteTextEditingController.value = TextEditingValue();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    print(fileName);
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageReference.putFile(_image);
    Navigator.pop(context);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    firebaseStorageReference.getDownloadURL().then((value) {
      _store.collection('plants').add({
        'imageLink': value,
        'latinName': latinTextEditingController.text,
        'dutchName': dutchTextEditingController.text,
        'category': categoryTextEditingController.text,
        'note': noteTextEditingController.text
      });
    });
  }

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
  Widget build(BuildContext context) {
    void saySomething(String message) {
      setState(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      });
    }

    Future takeImage() async {
      final cameras = await availableCameras();
      if (cameras != null) {
        final imagePath = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakePictureScreen(
              camera: cameras.first,
            ),
          ),
        );
        imagePath.then((value) {
          setState(() {
            _image = File(value);
            imagePlaceHolder = Image.file(_image);
          });
        });
      }
    }

    imagePlaceHolder =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        icon: Icon(
          Icons.camera_alt,
          size: 60,
          color: Colors.blueGrey[200],
        ),
        onPressed: () {
          takeImage();
        },
      ),
      SizedBox(
        width: 80,
      ),
      IconButton(
        icon: Icon(
          Icons.photo_library,
          size: 60,
          color: Colors.blueGrey[200],
        ),
        onPressed: () {
          getImage();
        },
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Plant'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              if (_image != null) {
                uploadImage(context);
              } else {
//                saySomething("Please select a photo for your plant");
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: _image != null ? Image.file(_image) : imagePlaceHolder,
                ),
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
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          uploadImage(context);
//        },
//        tooltip: 'Save all',
//        child: Icon(Icons.save),
//      ), // This tr
    );
  }
}
