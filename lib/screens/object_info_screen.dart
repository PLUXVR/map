import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_test/bloc/object_post_cubit.dart';
import 'package:flutter_map_test/models/object_post_model.dart';

// Экран отрисовывается поверх maps и автоматически будет сгенерирована кнока назад
class ObjectPostInfoScreen extends StatelessWidget {
  final ObjectModel objectModel;

  ObjectPostInfoScreen({required this.objectModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(objectModel.objectName!),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(objectModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            objectModel.objectName!,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            objectModel.objectDescription!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                // Delete Post
                context.read<ObjectPostCubit>().removeObjectPost(objectModel);

                Navigator.of(context).pop();
              },
              child: const Text('Удалить объект')),
        ],
      )),
    );
  }
}
