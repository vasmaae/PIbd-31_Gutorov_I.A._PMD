import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/components/locale/l10n/app_locale.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/big_book_repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/home_page.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/like_bloc/like_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/locale_bloc/locale_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/locale_bloc/locale_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Book Store',
            locale: state.currentLocale,
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
              useMaterial3: true,
            ),
            home: RepositoryProvider<BigBookRepository>(
              lazy: true,
              create: (_) => BigBookRepository(),
              child: BlocProvider<LikeBloc>(
                lazy: false,
                create: (context) => LikeBloc(),
                child: BlocProvider(
                  lazy: false,
                  create: (context) =>
                      HomeBloc(context.read<BigBookRepository>()),
                  child: const HomePage(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
