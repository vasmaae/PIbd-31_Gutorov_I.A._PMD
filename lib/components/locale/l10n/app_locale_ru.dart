// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get search => 'Поиск';

  @override
  String get liked => 'добавлена в избранное';

  @override
  String get disliked => 'удалена из избранного';

  @override
  String get load_error => 'Ошибка загрузки';

  @override
  String get retry => 'Повторить';

  @override
  String get books_not_found => 'Книги не найдены';
}
