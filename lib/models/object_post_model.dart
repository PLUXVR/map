import 'dart:io';

// Класс для хранения данных об объекте
class ObjectModel {
  final String? objectName;
  final double latitude;
  final double longitude;
  final String? objectDescription;
  final File image;
// Конструктор класса, все поля обязательные
  ObjectModel({
    required this.image,
    required this.longitude,
    required this.latitude,
    required this.objectDescription,
    required this.objectName,
  });
}
