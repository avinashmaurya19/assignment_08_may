import 'package:flutter_assignment_new/bloc/sortgroup/sortgroup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'data/repositories/country_repository.dart';
import 'bloc/countrybloc/country_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
        create: (context) => CountryRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CountryBloc>(
              create: (context) => CountryBloc(
                countryRepository:
                    RepositoryProvider.of<CountryRepository>(context),
              ),
            ),
            BlocProvider<SortgroupBloc>(
              create: (context) => SortgroupBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: Colors.deepOrange,
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          ),
        ));
  }
}
