import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:covid19_live/data/models/covid_country.dart';

abstract class CovidCountryState extends Equatable {}

class CovidCountryInitial extends CovidCountryState {
  @override
  List<Object> get props => null;
}

class CovidCountryLoading extends CovidCountryState {
  @override
  List<Object> get props => null;
}

class CovidCountrySuccess extends CovidCountryState {
  final List<CovidCountry> covidCountries;

  CovidCountrySuccess({ @required this.covidCountries });

  @override
  List<Object> get props => null;
}

class CovidCountryFailure extends CovidCountryState {
  final String message;

  CovidCountryFailure({ @required this.message });

  @override
  List<Object> get props => null;
}
