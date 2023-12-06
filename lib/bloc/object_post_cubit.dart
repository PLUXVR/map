import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map_test/models/object_post_model.dart';
part 'object_post_state.dart';

class ObjectPostCubit extends Cubit<ObjectPostState> {
  ObjectPostCubit()
      : super(
            ObjectPostState(objectPosts: [], status: ObjectPostStatus.initial));

  void addObjectPost(ObjectModel objectModel) {
    emit(state.copyWith(status: ObjectPostStatus.loading));

    List<ObjectModel> objectPosts = state.objectPosts;
    objectPosts.add(objectModel);

    emit(state.copyWith(
        objectPosts: objectPosts, status: ObjectPostStatus.loaded));
  }
}
