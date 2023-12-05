import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map_test/models/object_post_model.dart';
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
  String? name;
  String? description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Добавить объект"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Координаты объекта: '),
              ),
              Text('Ширина: ${widget.latLng.latitude}'),
              Text('Долгота: ${widget.latLng.longitude}'),
              TextField(onChanged: (value) {
                name = value;
              }),
              TextField(onChanged: (value) {
                description = value;
              }),
              // ElevatedButton(
              //     onPressed: () => Navigator.of(context).pop(),
              //     child: const Text('Pop!'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Сохраняем объекты после создания и показываем на карте

          // if (description != null && name != null) {
          // if description != "" && name != ""}

          final ObjectModel objectModel = ObjectModel(
              image: widget.image,
              longitude: widget.latLng.longitude,
              latitude: widget.latLng.latitude,
              objectDescription: description ?? 'Empty',
              objectName: name ?? 'Empty');

          // Pop экрана после нажатия на кнопку
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check, size: 30),
      ),
    );
  }
}
