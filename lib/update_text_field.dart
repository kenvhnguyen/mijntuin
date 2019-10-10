import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatableTextField extends StatelessWidget {
  UpdatableTextField({
    this.itemName,
    this.fieldName,
    this.controller,
    this.maxLines,
    this.inputDecoration,
  });
  final String itemName;
  final String fieldName;
  final TextEditingController controller;
  final int maxLines;
  final InputDecoration inputDecoration;

  final _store = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.body1,
      controller: controller,
      decoration: inputDecoration,
      maxLines: maxLines,
      onSubmitted: (value) {
        _store
            .collection('plants')
            .where('latinName', isEqualTo: itemName)
            .getDocuments()
            .then((querySnapshot) {
          print(querySnapshot.documents);
          for (var plant in querySnapshot.documents) {
            _updateDate(plant, fieldName, controller.text);
          }
        });
      },
    );
  }

  void _updateDate(DocumentSnapshot doc, String field, String value) async {
    await _store
        .collection('plants')
        .document(doc.documentID)
        .updateData({field: value});
  }
}
