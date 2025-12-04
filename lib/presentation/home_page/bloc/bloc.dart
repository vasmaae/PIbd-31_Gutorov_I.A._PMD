import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/big_book_repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/events.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BigBookRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(
    HomeLoadDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.nextPage == null) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    String? error;

    final data = await repository.loadData(
      onError: (e) => error = e,
      q: event.search,
      page: event.nextPage ?? 1,
    );

    if (event.nextPage != null) {
      data?.data?.insertAll(0, state.data?.data ?? []);
    }

    emit(
      state.copyWith(
        isLoading: false,
        isPaginationLoading: false,
        data: data,
        error: error,
      ),
    );
  }
}
