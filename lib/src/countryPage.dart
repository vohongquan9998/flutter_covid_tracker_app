import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/models/country_virus_model.dart';
import 'package:flutter_covid_tracker_app/src/chartPage.dart';

class CountriesInfoScreen extends StatefulWidget {
  static const routeName = '/countries-info-screen';

  final countryVirusData;
  CountriesInfoScreen({this.countryVirusData});
  @override
  CountriesInfoScreenState createState() => CountriesInfoScreenState();
}

class CountriesInfoScreenState extends State<CountriesInfoScreen> {
  CountryVirusData locationData;
  List<CountryVirusData> countriesData = [];
  List<CountryVirusData> countriesForDisplay = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateCountriesUI(widget.countryVirusData);
    super.initState();
  }

  void updateCountriesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        print('null:data');
        return;
      }
      for (var eachData in virusData) {
        final countryData = CountryVirusData(
          country: eachData['country'] ?? 'None',
          confirmedCases: eachData['cases'] ?? 0,
          recovered: eachData['recovered'] ?? 0,
          deaths: eachData['deaths'] ?? 0,
          flagUrl: eachData['countryInfo']['flag'] ?? ">>",
        );
        countriesData.add(countryData);
      }
      countriesForDisplay = countriesData;
    });
  }

  Widget buildList() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0),
        itemCount: countriesForDisplay.length,
        itemBuilder: (ctx, index) => buildCard(index),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: yMargin(2)),
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: 'Search Countries',
            labelStyle: TextStyle(color: Colors.red)),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            countriesForDisplay = countriesData.where((c) {
              var cName = c.country.toLowerCase();
              return cName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  Widget buildCard(int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChartsScreen(
            countryName: '${countriesForDisplay[index].country}',
            cases: double.parse('${countriesForDisplay[index].confirmedCases}'),
            deaths: double.parse('${countriesForDisplay[index].deaths}'),
            recovered: double.parse('${countriesForDisplay[index].recovered}'),
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Cases: ${countriesForDisplay[index].confirmedCases}",
                  style: TextStyle(color: Colors.red),
                ),
                Container(
                  child: Image.network(countriesForDisplay[index].flagUrl),
                  height: yMargin(5),
                ),
                Text(
                  "${index + 1}.  ${countriesForDisplay[index].country}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: yMargin(2.5), fontFamily: "Titillium"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: yMargin(4)),
        child: Column(
          children: <Widget>[
            _searchBar(),
            buildList(),
          ],
        ),
      ),
    );
  }
}
