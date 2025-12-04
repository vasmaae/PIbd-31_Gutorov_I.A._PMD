import 'package:dio/dio.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/dtos/book_dtos.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/mappers/books_mapper.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';

class BigBookRepository extends Repository {
  static final Dio _dio = Dio();

  static const String _baseUrl = 'https://api.bigbookapi.com';

  @override
  Future<List<CardData>?> loadData({OnErrorCallback? onError}) async {
    try {
      const String url =
          '$_baseUrl/search-books?api-key=cec9bc4e37f9461d9ce6ee301a836152';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
      );
      final List<CardData> data = SearchBooksResponseDto.fromJson(
        response.data as Map<String, dynamic>,
      ).bookItems.map((e) => e[0]).map((e) => e.toDomain()).toList();

      return data;
    } on DioException catch (e) {
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }
}
