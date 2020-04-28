import 'package:covid19_live/blocs/covidcountries/covid_countries_event.dart';
import 'package:covid19_live/blocs/covidcountries/covid_countries_state.dart';
import 'package:covid19_live/data/repositories/covid_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class CovidCountriesBloc extends Bloc<CovidCountriesEvent, CovidCountryState> {
  CovidRepository covidRepository;

  CovidCountriesBloc({ @required this.covidRepository });

  @override
  CovidCountryState get initialState => CovidCountryLoading();

  @override
  Stream<CovidCountryState> mapEventToState(CovidCountriesEvent event) async* {
    if (event is FetchCovidCountryEvent) {
      yield* mapCovidCountryEventToState(event);
    }
  }

  Stream<CovidCountryState> mapCovidCountryEventToState(FetchCovidCountryEvent event) async* {
    yield CovidCountryLoading();

    try {
      var covidCountries = await covidRepository.fetchCovidCountries();
      CovidCountrySuccess(covidCountries: covidCountries);
    } catch(e) {
      yield CovidCountryFailure(message: e.toString());
    }
  }
}
