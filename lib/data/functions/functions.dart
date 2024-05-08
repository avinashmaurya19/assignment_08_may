
import '../models/country_model.dart';

Map<String, List<CountryModel>> generateCountryMap(
  String groupOption,
  List<CountryModel> countryList,
) {
  final Map<String, List<CountryModel>> groupedCountryMap = {};

  switch (groupOption) {
    case 'Continent':
      for (var country in countryList) {
        final key = country.continents;
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
        
      }
      break;

    case 'Region':
      for (var country in countryList) {
        final key = country.region;
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    case 'Subregion':
      for (var country in countryList) {
        final key = country.subregion;
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    case 'Ungrouped':
      for (var country in countryList) {
        final key = country.unGrouped;
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
      break;

    default:
      for (var country in countryList) {
        final key = country.unGrouped;
        groupedCountryMap.putIfAbsent(key, () => []).add(country);
      }
  }

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
