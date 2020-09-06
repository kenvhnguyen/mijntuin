import 'package:flutter/material.dart';

import 'my_plant.dart';
import 'new_plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());
final _store = Firestore.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Mijn Tuin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int plantCounter = 0;
  List<MyPlant> myPlants = [];

  @override
  void initState() {
    super.initState();
  }

  void _toNewPlant() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewPlant();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AllMyPlants(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toNewPlant,
        tooltip: 'add new plant to your garden',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AllMyPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // clearly declare the type here so we can access the content of snapshot.data
      stream: _store
          .collection('plants')
//          .orderBy('date', descending: false)
          .snapshots(), // a stream of QuerySnapshot which is FireStore object! <> Flutter's AsyncSnapshot
      builder: (context, snapshot) {
        // this is Flutter's AsyncSnapshot
        if (snapshot.hasData) {
          final plants = snapshot.data.documents;
          List<MyPlant> plantWidgets = [];
          for (var plant in plants) {
            final plantId = plant.documentID;
            final imageLink = plant.data['imageLink'];
            final image = Image.network(imageLink);
            final List<Image> photos = [];
            photos.add(image);
            final latinName = plant.data['latinName'];
            final dutchName = plant.data['dutchName'];
            final category = plant.data['category'];
            final note = plant.data['note'];
            plantWidgets.add(
              MyPlant(
                plantId: plantId,
                photos: photos,
                dutchName: dutchName,
                latinName: latinName,
                category: category,
                note: note,
              ),
            );
          }
          return Expanded(
            child: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: plantWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }
}
