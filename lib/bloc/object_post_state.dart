part of 'object_post_cubit.dart';

enum ObjectPostStatus {
  initial,
  error,
  loading,
  loaded,
  postAdded,
  postRemoved
}

class ObjectPostState extends Equatable {
  final List<ObjectModel> objectPosts;

  final ObjectPostStatus status;
  // named constructor
  const ObjectPostState({required this.objectPosts, required this.status});
  //  props необходимо для Equatable
  @override
  List<Object> get props => [objectPosts, status];
  // С помощью метода будем копировать State
  ObjectPostState copyWith({
    List<ObjectModel>? objectPosts,
    ObjectPostStatus? status,
  }) {
    return ObjectPostState(
      objectPosts: objectPosts ?? this.objectPosts,
      status: status ?? this.status,
    );
  }
}
