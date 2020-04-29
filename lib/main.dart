import 'package:covid19_live/blocs/covidcountries/covid_countries_bloc.dart';
import 'package:covid19_live/blocs/covidsummary/covid_summary_bloc.dart';
import 'package:covid19_live/data/datasource/covid_datasource.dart';
import 'package:covid19_live/data/repositories/covid_repository.dart';
import 'package:covid19_live/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CovidRepository covidRepository = CovidRepository(covidDatasource: CovidDatasource());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Live',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CovidSummaryBloc(covidRepository: covidRepository),
          ),
          BlocProvider(
            create: (context) => CovidCountriesBloc(covidRepository: covidRepository),
          )
        ],
        child: HomePage(),
      )
    );
  }
}

