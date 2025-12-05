import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/like_bloc/like_event.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/like_bloc/like_state.dart';

const String _likedBoxName = 'liked_box';
const String _likedKey = 'liked';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  late final Future<Box> _likedBox;

  LikeBloc() : super(const LikeState(likedIds: [])) {
    _likedBox = _openBox();
    on<ChangeLikeEvent>(_onChangeLike);
    on<LoadLikesEvent>(_onLoadLikes);
  }

  Future<Box> _openBox() async {
    return await Hive.openBox(_likedBoxName);
  }

  Future<void> _onLoadLikes(
    LoadLikesEvent event,
    Emitter<LikeState> emit,
  ) async {
    try {
      final box = await _likedBox;
      final data = box.get(_likedKey, defaultValue: <int>[]).cast<int>();

      emit(state.copyWith(likedIds: List<int>.from(data)));
    } catch (e) {
      emit(state.copyWith(likedIds: []));
    }
  }

  Future<void> _onChangeLike(
    ChangeLikeEvent event,
    Emitter<LikeState> emit,
  ) async {
    try {
      final box = await _likedBox;
      final currentList = List<int>.from(
        box.get(_likedKey, defaultValue: <int>[]),
      );
      final updatedList = List<int>.from(currentList);

      if (updatedList.contains(event.id)) {
        updatedList.remove(event.id);
      } else {
        updatedList.add(event.id);
      }

      await box.put(_likedKey, updatedList);

      emit(state.copyWith(likedIds: updatedList));
    } catch (e) {}
  }

  @override
  Future<void> close() {
    return _likedBox.then((box) => box.close()).then((_) => super.close());
  }
}
