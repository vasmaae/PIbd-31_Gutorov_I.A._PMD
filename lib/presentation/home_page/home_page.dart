import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/details_page/details_page.dart';

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

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      BookData(
        title: 'Мы',
        author: 'Евгений Замятин',
        imageUrl: 'https://cdn.litres.ru/pub/c/cover_415/71008480.webp',
      ),
      BookData(
        title: '1984',
        author: 'Джордж Оруэлл',
        imageUrl: 'https://cdn.litres.ru/pub/c/cover_415/63422937.webp',
        tip: 'Популярно',
      ),
      BookData(
        title: "Конституция РФ",
        author: "Разное",
        imageUrl: "https://cdn.litres.ru/pub/c/cover_415/57306921.webp",
        tip: 'Переписанная',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final book = data[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _Card.fromData(
            book,
            onLike: (title, isLiked) => _showSnackBar(context, title, isLiked),
            onTap: () => _navToDetails(context, book),
          ),
        );
      },
    );
  }

  void _navToDetails(BuildContext context, BookData data) {
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
