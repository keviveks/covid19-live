import 'package:meta/meta.dart';
import 'package:covid19_live/data/datasource/covid_datasource.dart';
import 'package:covid19_live/data/models/covid_country.dart';
import 'package:covid19_live/data/models/covid_summary.dart';

class CovidRepository {
  CovidDatasource covidDatasource;

  CovidRepository({@required this.covidDatasource});

  Future<CovidSummary> fetchCovidSummary() async {
    return await covidDatasource.getSummary();
  }

  Future<List<CovidCountry>> fetchCovidCountries() async {
    return await covidDatasource.getCountries();
  }

  List<CovidCountry> fetchFilteredCovidCountries(String text, List<CovidCountry> countries) {
    return covidDatasource.filterCountries(text, countries);
  }
}
