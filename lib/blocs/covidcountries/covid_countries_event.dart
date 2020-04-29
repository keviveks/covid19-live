import 'package:covid19_live/data/models/covid_country.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CovidCountriesEvent extends Equatable {}

class FetchCovidCountryEvent extends CovidCountriesEvent {
  @override
  List<Object> get props => null;
}

class CovidCountryUpdateEvent extends CovidCountriesEvent {
  final String country;

  CovidCountryUpdateEvent({ @required this.country });

  @override
  List<Object> get props => null;
}

class CovidCountryFilterEvent extends CovidCountriesEvent {
  final String text;
  final List<CovidCountry> countries;

  CovidCountryFilterEvent({ @required this.text, @required this.countries });

  @override
  List<Object> get props => null;
}

class CovidCountryFilterCloseEvent extends CovidCountriesEvent {
  @override
  List<Object> get props => null;
}
