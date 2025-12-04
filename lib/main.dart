import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/data/repositories/big_book_repository.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/bloc/bloc.dart';
import 'package:pibd_31_gutorov_i_a_pmd/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: RepositoryProvider<BigBookRepository>(
        lazy: true,
        create: (_) => BigBookRepository(),
        child: BlocProvider(
          lazy: false,
          create: (context) => HomeBloc(context.read<BigBookRepository>()),
          child: const HomePage(),
        ),
      ),
    );
  }
}
