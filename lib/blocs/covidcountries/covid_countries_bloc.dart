import 'package:covid19_live/blocs/covidcountries/covid_countries_event.dart';
import 'package:covid19_live/blocs/covidcountries/covid_countries_state.dart';
import 'package:covid19_live/data/models/covid_country.dart';
import 'package:covid19_live/data/repositories/covid_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class CovidCountriesBloc extends Bloc<CovidCountriesEvent, CovidCountryState> {
  CovidRepository covidRepository;
  List<CovidCountry> covidCountries;

  CovidCountriesBloc({ @required this.covidRepository });

  @override
  CovidCountryState get initialState => CovidCountryLoading();

  @override
  Stream<CovidCountryState> mapEventToState(CovidCountriesEvent event) async* {
    if (event is FetchCovidCountryEvent) {
      yield* mapCovidCountryEventToState(event);
    } else if (event is CovidCountryFilterEvent) {
      yield* mapCovidCountryFilterEventToState(event);
    } else if (event is CovidCountryFilterCloseEvent) {
      yield CovidCountrySuccess(covidCountries: this.covidCountries);
    }
  }

  Stream<CovidCountryState> mapCovidCountryEventToState(FetchCovidCountryEvent event) async* {
    yield CovidCountryLoading();

    try {
      this.covidCountries = await covidRepository.fetchCovidCountries();
      yield CovidCountrySuccess(covidCountries: this.covidCountries);
    } catch(e) {
      yield CovidCountryFailure(message: e.toString());
    }
  }

  Stream<CovidCountryState> mapCovidCountryFilterEventToState(CovidCountryFilterEvent event) async* {
    yield CovidCountryLoading();
    List<CovidCountry> filteredCountries = covidRepository.fetchFilteredCovidCountries(event.text, event.countries);
    if (filteredCountries.length > 0) {
      yield CovidFilteredCountries(countries: filteredCountries);
    } else {
      yield CovidCountriesNotFound();
    }
  }
}
