import 'package:pibd_31_gutorov_i_a_pmd/data/dtos/book_dtos.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';

extension BooksMapper on BookDto {
  CardData toDomain() => CardData(
    title: title,
    authors: authors.map((e) => e.name).toList().join(', '),
    imageUrl: image,
    rating: rating?.average.toString(),
  );
}
