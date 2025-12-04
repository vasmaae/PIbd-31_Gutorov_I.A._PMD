import 'package:flutter/material.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/dialogs/error_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String error,
}) async => showDialog(context: context, builder: (_) => ErrorDialog(error));
