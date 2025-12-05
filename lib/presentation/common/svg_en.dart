import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pibd_31_gutorov_i_a_pmd/components/resources.g.dart';

class SvgEn extends StatelessWidget {
  const SvgEn({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(R.ASSETS_SVG_EN_SVG);
  }
}
