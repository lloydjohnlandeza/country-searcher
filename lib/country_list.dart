import 'package:expense_tracker/api/country_service.dart';
import 'package:expense_tracker/country_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CountryList extends StatefulWidget {
  CountryList({
    super.key,
  });

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Future<List<Country>>? countries;
  @override
  void initState() {
    super.initState();
    countries = fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchCountry(),
        SizedBox(
          height: 30,
        ),
        Flexible(
          child: SizedBox(
              width: 300,
              child: FutureBuilder<List<Country>>(
                future: countries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Country> countries = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 1.1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return CountryCard(
                            countryName: countries[index].name.common);
                      },
                    );
                  } else {
                    return Text('No data available.');
                  }
                },
              )),
        ),
      ],
    );
  }
}

class SearchCountry extends StatefulWidget {
  SearchCountry({super.key});

  @override
  State<SearchCountry> createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  Timer? _debounce;
  var countries = [];

  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      var test = fetchCountries();
      debugPrint(test.toString());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search for a country...',
          border: OutlineInputBorder(),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
