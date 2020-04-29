import 'package:covid19_live/blocs/covidcountries/covid_countries_bloc.dart';
import 'package:covid19_live/blocs/covidcountries/covid_countries_event.dart';
import 'package:covid19_live/blocs/covidcountries/covid_countries_state.dart';
import 'package:covid19_live/data/models/covid_country.dart';
import 'package:covid19_live/ui/pages/covid_country_details_page.dart';
import 'package:covid19_live/ui/widgets/app_widgets.dart';
import 'package:covid19_live/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidCountriesPage extends StatefulWidget {
  @override
  _CovidCountriesPageState createState() => _CovidCountriesPageState();
}

class _CovidCountriesPageState extends State<CovidCountriesPage> {
  double screenHeight, screenWidth;
  bool isSearching = false;
  List<CovidCountry> countryList = [];
  CovidCountriesBloc covidCountriesBloc;
  TextEditingController searchTextCntrlr = TextEditingController();

  @override
  void initState() {
    super.initState();
    covidCountriesBloc = BlocProvider.of<CovidCountriesBloc>(context);
    covidCountriesBloc.add(FetchCovidCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height.toDouble();
    screenWidth = MediaQuery.of(context).size.width.toDouble();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkbg,
        title: !isSearching
            ? Text(
                "COVID19 LIVE",
                style: TextStyle(
                    fontFamily: "RussoOne",
                    letterSpacing: 1.7,
                    color: Colors.teal),
              )
            : TextField(
                controller: searchTextCntrlr,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search by Country",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  covidCountriesBloc.add(CovidCountryFilterEvent(
                    text: value,
                    countries: this.countryList,
                  ));
                },
              ),
        centerTitle: true,
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    covidCountriesBloc.add(CovidCountryFilterCloseEvent());
                    setState(() {
                      searchTextCntrlr.text = "";
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.darkbg,
          height: screenHeight,
          child: BlocBuilder<CovidCountriesBloc, CovidCountryState>(
            builder: (context, state) {
              if (state is CovidCountryLoading) {
                return loadingWidget();
              } else if (state is CovidCountrySuccess) {
                this.countryList = state.countries;
                return buildCovidCountriesList(state.countries);
              } else if (state is CovidCountryFailure) {
                return errorWidget(state.message);
              } else if (state is CovidFilteredCountries) {
                return buildCovidCountriesList(state.countries);
              } else if (state is CovidCountriesNotFound) {
                return errorWidget("No Countries Found");
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCovidCountriesList(List<CovidCountry> countriesList) {
    return Container(
      margin: EdgeInsets.only(bottom: 118.0),
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        shrinkWrap: true,
        itemCount: countriesList.length,
        itemBuilder: (context, position) {
          CovidCountry coronaCountry = countriesList[position];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                navigateTodetailsPage(context, coronaCountry);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                child: Material(
                  elevation: 10.0,
                  shadowColor: Colors.grey,
                  color: AppColors.upDark,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // name
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            coronaCountry.country.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.cy,
                              fontSize: 20.0,
                              fontFamily: "RussoOne",
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        // cases
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Cases : ${coronaCountry.cases.toString()}",
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // deaths
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Deaths : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: coronaCountry.deaths.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "RussoOne",
                                          color: AppColors.white,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            // today deaths
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Today : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: coronaCountry.todayDeaths
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "RussoOne",
                                          color: coronaCountry.todayDeaths == 0
                                              ? AppColors.teal
                                              : AppColors.red,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateTodetailsPage(BuildContext context, CovidCountry country) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CovidCountryDetailsPage(country: country);
    }));
  }
}
