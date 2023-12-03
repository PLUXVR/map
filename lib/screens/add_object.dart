import 'dart:io';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AddObjectScreen extends StatefulWidget {
  final LatLng latLng;
  final File image;
  // Возможно придется добавить поле
  AddObjectScreen({required this.latLng, required this.image});

  @override
  _AddObjectScreenState createState() => _AddObjectScreenState();
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Добавить объект"),
        // leading: ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: FileImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              child:
                  Text('${widget.latLng.latitude} ${widget.latLng.latitude}'),
            ),
            TextField(),
            TextField(),
            // ElevatedButton(
            //     onPressed: () => Navigator.of(context).pop(),
            //     child: const Text('Pop!'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.check, size: 30),
      ),
    );
  }
}
