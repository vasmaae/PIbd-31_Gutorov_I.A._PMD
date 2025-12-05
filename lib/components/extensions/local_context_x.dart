import 'package:flutter/cupertino.dart';
import 'package:pibd_31_gutorov_i_a_pmd/components/locale/l10n/app_locale.dart';

extension LocalContextX on BuildContext {
  AppLocale get locale => AppLocale.of(this)!;
}
