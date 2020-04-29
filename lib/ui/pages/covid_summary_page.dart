import 'package:covid19_live/blocs/covidsummary/covid_summary_bloc.dart';
import 'package:covid19_live/blocs/covidsummary/covid_summary_event.dart';
import 'package:covid19_live/blocs/covidsummary/covid_summary_state.dart';
import 'package:covid19_live/ui/widgets/app_widgets.dart';
import 'package:covid19_live/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';

class CovidSummaryPage extends StatefulWidget {
  @override
  _CovidSummaryPageState createState() => _CovidSummaryPageState();
}

class _CovidSummaryPageState extends State<CovidSummaryPage> {
  double screenHeight, screenWidth;

  CovidSummaryBloc covidSummaryBloc;

  @override
  void initState() {
    super.initState();
    // covidSummaryBloc = CovidSummaryBloc(covidRepository: CovidRepository());
    covidSummaryBloc = BlocProvider.of<CovidSummaryBloc>(context);
    covidSummaryBloc.add(FetchCovidSummaryEvent());
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          height: screenHeight,
          child: BlocBuilder<CovidSummaryBloc, CovidSummaryState>(
            builder: (context, state) {
              if (state is CovidSummaryInitial) {
                return loadingWidget();
              } else if (state is CovidSummaryLoading) {
                return loadingWidget();
              } else if (state is CovidSummarySuccess) {
                return summaryWidget(state);
              } else if (state is CovidSummaryFailure) {
                return errorWidget(state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget summaryWidget(CovidSummarySuccess state) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
          alignment: Alignment.center,
          child: NeuText(
            "Covid VIRUS SUMMARY",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 2.3,
              fontFamily: "RussoOne",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
          alignment: Alignment.center,
          child: Text(
            Helper.milliSecondsToDate(state.covidSummary.updated),
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              letterSpacing: 4.5,
              fontFamily: "RussoOne",
            ),
          ),
        ),
        NeuCard(
          child: Text(
            "${state.covidSummary.deaths}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              fontFamily: "RussoOne",
              letterSpacing: 2.5,
            ),
          ),
          alignment: Alignment.center,
          bevel: 25.0,
          decoration: NeumorphicDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[850],
          ),
          margin: EdgeInsets.only(top: 30.0),
          width: 150.0,
          height: 150.0,
          curveType: CurveType.concave,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.0),
          alignment: Alignment.center,
          child: NeuText(
            "TOTAL DEATH",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,

              fontSize: 25.0,
            ),
          ),
        ),
        //////
        Container(
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.center,
          child: Text(
            state.covidSummary.cases.toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              fontFamily: "RussoOne",
              letterSpacing: 4.5,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30.0),
          alignment: Alignment.center,
          child: NeuText(
            "TOTAL CASE",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),

        //
        Container(
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.center,
          child: Text(
            state.covidSummary.recovered.toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              fontFamily: "RussoOne",
              letterSpacing: 4.5,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: NeuText(
            "TOTAL RECOVERED",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}
