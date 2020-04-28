import 'package:equatable/equatable.dart';

abstract class CovidSummaryEvent extends Equatable {}

class FetchCovidSummaryEvent extends CovidSummaryEvent {
  @override
  List<Object> get props => null;
}