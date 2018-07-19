import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Sygic Maps in Flutter'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new MapWithDynamicMarkers(),
    );
  }
}

class MapWithDynamicMarkers extends StatefulWidget {
  @override
  MapWithMarkersState createState() {
    return new MapWithMarkersState();
  }
}

class MapWithMarkersState extends State<MapWithDynamicMarkers> {
  final List<LatLng> _markers = [];

  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(51.506292, -0.114374),
        zoom: 13.0,
        onTap: (LatLng point) {
          setState(() {
            if (5 <= _markers.length)
              _markers.clear();
            else
              _markers.add(point);
          });
        },
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://maps.api.sygic.com/tile/{apiKey}/{z}/{x}/{y}",
          additionalOptions: {
            'apiKey': 'ffDgde5rCn6jjR35GJWD82hUC',
          },
        ),
        new MarkerLayerOptions(
          markers: _markers.map((point) => _buildMarker(point)).toList(),
        ),
      ],
    );
  }

  Marker _buildMarker(LatLng latLng) {
    return new Marker(
      point: latLng,
      width: 60.0,
      height: 55.0,
      anchor: AnchorPos.top,
      builder: (BuildContext context) => const Icon(
            Icons.person_pin_circle,
            size: 60.0,
            color: Colors.red,
          ),
    );
  }
}
