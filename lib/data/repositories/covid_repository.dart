import 'package:covid19_live/data/datasource/covid_datasource.dart';
import 'package:covid19_live/data/models/covid_country.dart';
import 'package:covid19_live/data/models/covid_summary.dart';

class CovidRepository {
  CovidDatasource _covidDatasource;

  CovidRepository() {
    _covidDatasource = CovidDatasource();
  }

  Future<CovidSummary> fetchCovidSummary() async {
    return await _covidDatasource.getSummary();
  }

  Future<List<CovidCountry>> fetchCovidCountries() async {
    return await _covidDatasource.getCountries();
  }

  List<CovidCountry> fetchFilteredCovidCountries(String text, List<CovidCountry> countries) {
    return _covidDatasource.filterCountries(text, countries);
  }
}
