import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class CovidCountriesEvent extends Equatable {}

class FetchCovidCountryEvent extends CovidCountriesEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CovidCountryUpdateEvent extends CovidCountriesEvent {
  final String country;

  CovidCountryUpdateEvent({ @required this.country });

  @override
  // TODO: implement props
  List<Object> get props => null;

}
