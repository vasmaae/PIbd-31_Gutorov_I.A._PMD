import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/like_bloc/like_event.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/like_bloc/like_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _likedPrefsKey = 'liked';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(const LikeState(likedIds: [])) {
    on<ChangeLikeEvent>(_onChangeLike);
    on<LoadLikesEvent>(_onLoadLikes);
  }

  Future<void> _onLoadLikes(
    LoadLikesEvent event,
    Emitter<LikeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs
        .getStringList(_likedPrefsKey)
        ?.map((e) => int.tryParse(e)!)
        .toList();

    emit(state.copyWith(likedIds: data));
  }

  Future<void> _onChangeLike(
    ChangeLikeEvent event,
    Emitter<LikeState> emit,
  ) async {
    final updatedList = List<int>.from(state.likedIds ?? []);

    if (updatedList.contains(event.id)) {
      updatedList.remove(event.id);
    } else {
      updatedList.add(event.id);
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      _likedPrefsKey,
      updatedList.map((e) => e.toString()).toList(),
    );

    emit(state.copyWith(likedIds: updatedList));
  }
}
