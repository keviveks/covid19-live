import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:covid19_live/data/models/covid_summary.dart';

abstract class CovidSummaryState extends Equatable {}

class CovidSummaryInitial extends CovidSummaryState {
  @override
  List<Object> get props => null;
}

class CovidSummaryLoading extends CovidSummaryState {
  @override
  List<Object> get props => null;
}

class CovidSummarySuccess extends CovidSummaryState {
  final CovidSummary covidSummary;

  CovidSummarySuccess({ @required this.covidSummary });

  @override
  List<Object> get props => null;
}

class CovidSummaryFailure extends CovidSummaryState {
  final String message;

  CovidSummaryFailure({ @required this.message });

  @override
  List<Object> get props => null;
}
