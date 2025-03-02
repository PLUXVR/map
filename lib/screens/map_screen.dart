import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_test/bloc/location_cubit.dart';
import 'package:flutter_map_test/bloc/object_post_cubit.dart';
import 'package:flutter_map_test/models/object_post_model.dart';
import 'package:flutter_map_test/screens/screens.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final MapController _mapController = MapController();

  Future<void> _pickImageAndCreatePost(
      {required LatLng latLng, required BuildContext context}) async {
    File? image;

    final picker = ImagePicker();
    // Выбрать файл из галереии с качество 40 единиц
    // Получаем формат XFile? из него потом получим просто File
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      //Переходим в новый скрин (чтобы получить контект необходимо добавить его в _pickImageAndCreatePost)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              AddObjectScreen(latLng: latLng, image: image!)));
    } else {
      print("User didn't pick image");
    }
  }

  // Функция для возвращения листа маркеров
  List<Marker> _buildMarkers(
      BuildContext context, List<ObjectModel> objectPosts) {
    List<Marker> markers = [];
    objectPosts.forEach((post) {
      markers.add(Marker(
          width: 55,
          height: 55,
          point: LatLng(post.latitude, post.longitude),
          // Разобраться что это такое
          child: GestureDetector(
            onTap: () {
              // Go to details screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ObjectPostInfoScreen(
                    objectModel: post,
                  ),
                ),
              );
            },
            child: Container(
              child: Image.asset('assets/bpla.png'),
            ),
          )));
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (previousState, currentState) {
          if (currentState is LocationLoaded) {
            _mapController.move(
                LatLng(currentState.latitude, currentState.longitude), 14);
          }

          if (currentState is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red.withOpacity(0.6),
              content: const Text('Error, unable to fetch location'),
            ));
          }
        },
        child: BlocBuilder<ObjectPostCubit, ObjectPostState>(
          buildWhen: (prevState, currentState) =>
              (prevState.status != currentState.status),
          builder: (context, objectPostState) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onLongPress: (tapPosition, latLng) {
                  // При нажатии нам дается latlng и мы его передаем в AddObjectScreen

                  _pickImageAndCreatePost(latLng: latLng, context: context);
                },
                initialCenter: LatLng(59.9311, 30.3609),
                initialZoom: 15.3,
                maxZoom: 17,
                minZoom: 3.5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=655424ea6ac64f1787f12fce7eb7ad8d',
                  retinaMode: true,
                ),
                /////////Место под объеккты
                MarkerLayer(
                  markers: _buildMarkers(context, objectPostState.objectPosts),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
