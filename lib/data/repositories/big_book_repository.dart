import 'package:dio/dio.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/dtos/book_dtos.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/mappers/books_mapper.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';
import 'package:pibd_31_gutorov_i_a_pmd/domain/models/home_data.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BigBookRepository extends Repository {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  static const String _baseUrl = 'https://api.bigbookapi.com';

  @override
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    String? q,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      const String url = '$_baseUrl/search-books';

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'api-key': 'cec9bc4e37f9461d9ce6ee301a836152',
          if (q != null) 'query': q,
          'offset': (page - 1) * pageSize,
          'number': pageSize,
        },
      );

      var dto = SearchBooksResponseDto.fromJson(
        response.data as Map<String, dynamic>,
      );

      final List<CardData> data = dto.bookItems
          .map((e) => e[0])
          .map((e) => e.toDomain())
          .toList();

      return HomeData(data: data, nextPage: dto.currentPage + 1);
    } on DioException catch (e) {
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }
}
