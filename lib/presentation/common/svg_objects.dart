import 'package:flutter_svg/flutter_svg.dart';
import 'package:pibd_31_gutorov_i_a_pmd/components/resources.g.dart';

abstract class SvgObjects {
  static void init() {
    final pics = <String>[R.ASSETS_SVG_RU_SVG, R.ASSETS_SVG_EN_SVG];
    for (final String p in pics) {
      final loader = SvgAssetLoader(p);
      svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
