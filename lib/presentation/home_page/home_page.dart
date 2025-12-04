import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/big_book_repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/details_page/details_page.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/dialogs/show_dialog.dart';

part 'card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _color = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _color, title: Text(widget.title)),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<CardData>?> data;

  @override
  void initState() {
    data = BigBookRepository().loadData(
      onError: (e) => showErrorDialog(context, error: e!),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          data = _reload();
        });
      },
      child: FutureBuilder<List<CardData>?>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text('Ошибка загрузки: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () => setState(() => data = _reload()),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          final books = snapshot.data ?? <CardData>[];

          if (books.isEmpty) {
            return const Center(child: Text('Книги не найдены'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _Card.fromData(
                  book,
                  onLike: (title, isLiked) =>
                      _showSnackBar(context, title, isLiked),
                  onTap: () => _navToDetails(context, book),
                ),
              );
            },
          );
        },
      ),
    );
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

  Future<List<CardData>?> _reload() {
    return BigBookRepository().loadData(
      onError: (e) => showErrorDialog(context, error: e!),
    );
  }
}
