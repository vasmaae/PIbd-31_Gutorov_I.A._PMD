import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/components/utils/debounce.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/details_page/details_page.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/events.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/state.dart';

part 'card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    scrollController.addListener(_onNextPageListener);
    super.initState();
  }

  void _onNextPageListener() {
    if (scrollController.offset > scrollController.position.maxScrollExtent) {
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading) {
        bloc.add(
          HomeLoadDataEvent(
            search: searchController.text,
            nextPage: bloc.state.data?.nextPage,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          // === Поиск ===
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: (search) {
                Debounce.run(
                  () => context.read<HomeBloc>().add(
                    HomeLoadDataEvent(search: search),
                  ),
                );
              },
            ),
          ),

          // === Основное содержимое через BlocBuilder ===
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // Ошибка загрузки (основной запрос)
              if (state.error != null) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 64),
                        const SizedBox(height: 16),
                        Text(
                          'Ошибка загрузки'
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.error ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.redAccent),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => context.read<HomeBloc>().add(
                            const HomeLoadDataEvent(search: ''),
                          ),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Основной лоадер
              if (state.isLoading) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // Пустой результат
              final items = state.data?.data ?? [];
              if (items.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'Книги не найдены'
                    ),
                  ),
                );
              }

              // Основной список
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16), // как во втором примере
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final data = items[index];

                      // Отступ снизу у каждой карточки, кроме последней (опционально)
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _Card.fromData(
                          data,
                          onLike: (title, isLiked) =>
                              _showSnackBar(context, title, isLiked),
                          onTap: () => _navToDetails(context, data),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.isPaginationLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() {
    context.read<HomeBloc>().add(
      HomeLoadDataEvent(search: searchController.text),
    );
    return Future.value(null);
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$title ${isLiked ? 'добавлена в избранное' : 'удалена из избранного'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }
}
