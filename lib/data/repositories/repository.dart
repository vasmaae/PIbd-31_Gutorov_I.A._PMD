import 'package:pibd_31_gutorov_i_a_pmd/domain/models/card_data.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class Repository {
  Future<List<CardData>?> loadData({OnErrorCallback? onError});
}
