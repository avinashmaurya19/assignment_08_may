// import 'dart:collection';

// import 'package:collection/collection.dart';

// import '../models/country_model.dart';

// Map<String, List<CountryModel>> generateCountryMap(
//   String groupOption,
//   List<CountryModel> countryList,
// ) {
//   final Map<String, List<CountryModel>> groupedCountryMap;

//   switch (groupOption) {
//     case 'Continent':
//       groupedCountryMap =
//           groupBy(countryList, (CountryModel country) => country.continents);

//       final sortedKeyCountryMap = SplayTreeMap<String, List<CountryModel>>.from(
//           groupedCountryMap, (key1, key2) => key1.compareTo(key2));

//       return sortedKeyCountryMap;

//     case 'Region':
//       groupedCountryMap =
//           groupBy(countryList, (CountryModel country) => country.region);

//       final sortedKeyCountryMap = SplayTreeMap<String, List<CountryModel>>.from(
//           groupedCountryMap, (key1, key2) => key1.compareTo(key2));

//       return sortedKeyCountryMap;

//     case 'Subregion':
//       groupedCountryMap =
//           groupBy(countryList, (CountryModel country) => country.subregion);

//       final sortedKeyCountryMap = SplayTreeMap<String, List<CountryModel>>.from(
//           groupedCountryMap, (key1, key2) => key1.compareTo(key2));

//       return sortedKeyCountryMap;

//     case 'Ungrouped':
//       groupedCountryMap =
//           groupBy(countryList, (CountryModel country) => country.unGrouped);

//       final sortedKeyCountryMap = SplayTreeMap<String, List<CountryModel>>.from(
//           groupedCountryMap, (key1, key2) => key1.compareTo(key2));

//       return sortedKeyCountryMap;

//     default:
//       groupedCountryMap =
//           groupBy(countryList, (CountryModel country) => country.unGrouped);

//       final sortedKeyCountryMap = SplayTreeMap<String, List<CountryModel>>.from(
//           groupedCountryMap, (key1, key2) => key1.compareTo(key2));

//       return sortedKeyCountryMap;
//   }
// }

// int generateSorting(
//   String sortingStatus,
//   CountryModel country1,
//   CountryModel country2,
// ) {
//   switch (sortingStatus) {
//     case 'Name':
//       return country1.nameCommon.compareTo(country2.nameCommon);
//     case 'Area':
//       return country2.area.compareTo(country1.area);
//     case 'Population':
//       return country2.population.compareTo(country1.population);
//     default:
//       return country1.nameCommon.compareTo(country2.nameCommon);
//   }
// }

import '../models/country_model.dart';

Map<String, List<CountryModel>> generateCountryMap(
  String groupOption,
  List<CountryModel> countryList,
) {
  final Map<String, List<CountryModel>> groupedCountryMap = {};

  switch (groupOption) {
    case 'Continent':
      for (var country in countryList) {
        final key = country.continents ?? 'Unknown';
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
        
      }
      break;

    case 'Region':
      for (var country in countryList) {
        final key = country.region ?? 'Unknown';
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    case 'Subregion':
      for (var country in countryList) {
        final key = country.subregion ?? 'Unknown';
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    case 'Ungrouped':
      for (var country in countryList) {
        final key = country.unGrouped ?? 'Unknown';
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    default:
      for (var country in countryList) {
        final key = country.unGrouped ?? 'Unknown';
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
  }

  // Sort keys alphabetically
  // final sortedKeys = groupedCountryMap.keys.toList()..sort();
  // final sortedCountryMap = <String, List<CountryModel>>{};
  // for (var key in groupedCountryMap.keys) {
  //   sortedCountryMap[key] = groupedCountryMap[key]!;
  // }

  // return sortedCountryMap;
  return groupedCountryMap;
}

int generateSorting(
  String sortingStatus,
  CountryModel country1,
  CountryModel country2,
) {
  switch (sortingStatus) {
    case 'Name':
      return country1.nameCommon.compareTo(country2.nameCommon);
    case 'Area':
      return country2.area.compareTo(country1.area);
    case 'Population':
      return country2.population.compareTo(country1.population);
    default:
      return country1.nameCommon.compareTo(country2.nameCommon);
  }
}
