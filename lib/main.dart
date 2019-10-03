import 'package:flutter/material.dart';

import 'my_plant.dart';
import 'new_plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());
final _store = Firestore.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
//    loadSampleImages();
//    getPlants();
  }

  void loadSampleImages() {
    for (int i = 900; i < 1000; i++) {
      try {
        final Image image1 =
            Image.network('https://picsum.photos/id/$i/800/600');
        final Image image2 =
            Image.network('https://picsum.photos/id/${i - 100}/800/600');
        if (image1 != null && image2 != null) {
          List<Image> relatedImages = [];
          relatedImages.add(image1);
          relatedImages.add(image2);
          myPlants.add(new MyPlant(
            photos: relatedImages,
            latinName: 'some latin name',
            dutchName: 'some dutch name',
            category: 'some category',
            note: 'some note',
          ));
          _incrementCounter();
        }
      } on Exception catch (e) {
        print('Error fetching image: $e');
      }
    }
    print(myPlants.length);
  }

  void getPlants() async {
    final plants = await _store.collection('plants').getDocuments();
    for (var plant in plants.documents) {
      final Image image1 = Image.network(plant.data['imageLink']);
      List<Image> relatedImages = [];
      relatedImages.add(image1);
      final myPlant = MyPlant(
        photos: relatedImages,
        latinName: plant.data['latinName'],
        dutchName: plant.data['dutchName'],
        category: plant.data['category'],
        note: plant.data['note'],
      );
      myPlants.add(myPlant);
    }
    print(' YEAH:::: ${myPlants.length}');
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      plantCounter++;
    });
  }

  void _toNewPlant() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewPlant(
        latinName: 'abc',
        dutchName: 'gezelig',
        category: 'Rare',
        note: 'wat..',
      );
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
        tooltip: 'Increment',
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
          .snapshots(), // a stream of QuerySnapshot which is FireStore object! <> Flutter's AsyncSnapshot
      builder: (context, snapshot) {
        // this is Flutter's AsyncSnapshot
        if (snapshot.hasData) {
          final plants = snapshot.data.documents;
          List<MyPlant> plantWidgets = [];
          for (var plant in plants) {
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
