import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountries() async {
  final response =
      await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response, parse the JSON.
    List<dynamic>? parsedJson = jsonDecode(response.body);

    if (parsedJson == null) {
      throw Exception('Failed to parse JSON response.');
    }

    List<Country> countries =
        parsedJson.map((json) => Country.fromJson(json)).toList();
    return countries;
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load Countries: ${response.statusCode}');
  }
}

class Flags {
  final String png;
  const Flags({
    required this.png,
  });
}

class Name {
  final String common;
  const Name({
    required this.common,
  });
  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      common: json['common'] ?? '',
    );
  }
}

class Country {
  Map<String, String> flags;
  Name name;
  List<String> capital;
  String region;
  int population;

  Country({
    required this.flags,
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flags: Map<String, String>.from(json['flags'] ?? {}),
      name: Name.fromJson(json['name']),
      capital: List<String>.from(json['capital'] ?? []),
      region: json['region'] ?? '',
      population: json['population'] ?? 0,
    );
  }
}
