import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_test/bloc/object_post_cubit.dart';
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
  // Переменные для полей TextField
  String? name;
  String? description;
  // Submit для добавления элементов в ObjectModel
  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    // Создаем ObjectModel после того как проверили onSaved в полях, чтобы не передавался null
    // Делаем submit, заполняются name и description
    // и  после _formKey.currentState!.save(); создаем objectModel
    final ObjectModel objectModel = ObjectModel(
        image: widget.image,
        longitude: widget.latLng.longitude,
        latitude: widget.latLng.latitude,
        objectDescription: description,
        objectName: name);

    context.read<ObjectPostCubit>().addObjectPost(objectModel);

    Navigator.of(context).pop();
  }

  // Ключ для Form
  final _formKey = GlobalKey<FormState>();
  // FocusNode для перехода от поля ввода name к полю ввода description
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Добавить объект"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Картинка из галереи
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
                // Text Field
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Введите наименование объекта'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => {
                    name = value!.trim(),
                  },
                  onFieldSubmitted: (_) {
                    // Для перехода на следующее поле description
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  // Валидатор, делаем проверку, в конце возвращаем null -> Значит проверка пройдена
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите значение!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration:
                      const InputDecoration(hintText: 'Введите описание'),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _submit(context);
                  },
                  onSaved: (value) => {
                    description = value!.trim(),
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите описание!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pop экрана после нажатия на кнопку
          _submit(context);
        },
        child: const Icon(Icons.check, size: 30),
      ),
    );
  }
}
