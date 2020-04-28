import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:covid19_live/blocs/covidsummary/covid_summary_event.dart';
import 'package:covid19_live/blocs/covidsummary/covid_summary_state.dart';
import 'package:covid19_live/data/models/covid_summary.dart';
import 'package:covid19_live/data/repositories/covid_repository.dart';

class CovidSummaryBloc extends Bloc<CovidSummaryEvent, CovidSummaryState> {
  CovidRepository covidRepository;

  CovidSummaryBloc({ @required this.covidRepository });

  @override
  CovidSummaryState get initialState => CovidSummaryInitial();

  @override
  Stream<CovidSummaryState> mapEventToState(CovidSummaryEvent event) async* {
    if (event is CovidSummaryEvent) {
      yield* mapCovidSummaryEventToState(event);
    }
  }

  Stream<CovidSummaryState> mapCovidSummaryEventToState(FetchCovidSummaryEvent event) async* {
    yield CovidSummaryLoading();

    try {
      CovidSummary covidSummary = await covidRepository.fetchCovidSummary();
      yield CovidSummarySuccess(covidSummary: covidSummary);
    } catch(e) {
      yield CovidSummaryFailure(message: e.toString());
    }
  }
}
