import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';

class MockRepository extends Repository {
  @override
  Future<List<CardData>?> loadData({OnErrorCallback? onError}) async {
    final data = [
      CardData(
        title: 'Мы',
        authors: 'Евгений Замятин',
        imageUrl: 'https://cdn.litres.ru/pub/c/cover_415/71008480.webp',
      ),
      CardData(
        title: '1984',
        authors: 'Джордж Оруэлл',
        imageUrl: 'https://cdn.litres.ru/pub/c/cover_415/63422937.webp',
        rating: '1231231231231',
      ),
      CardData(
        title: "Конституция РФ",
        authors: "Разное",
        imageUrl: "https://cdn.litres.ru/pub/c/cover_415/57306921.webp",
        rating: '123123123',
      ),
    ];
    return data;
  }
}
