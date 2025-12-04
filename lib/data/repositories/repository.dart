import 'package:pibd_31_gutorov_i_a_pmd/domain/models/home_data.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class Repository {
  Future<HomeData?> loadData({OnErrorCallback? onError});
}
