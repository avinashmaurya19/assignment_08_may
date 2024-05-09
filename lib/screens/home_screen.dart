import 'package:flutter/material.dart';
import 'package:flutter_assignment_new/data/models/country_group_model.dart';
import 'package:flutter_assignment_new/data/models/country_model.dart';
import 'package:flutter_assignment_new/widgets/group_grid_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/countrybloc/country_bloc.dart';
import '../widgets/sort_group_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//groups countries based on the selected option (continent, region, subregion, or ungrouped).
  Map<String, List<CountryModel>> groupCountriesByOption(
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

// compares two countries based on the selected sorting status (name, area, or population).
  int compareCountriesForSorting(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 48, 150, 253),
        title: const Text(
          "Country",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 188, 215, 241),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CountryInitialState) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CountryBloc>(context).add(LoadCountryEvent());
                },
                child: const Text('Get the Countries',
                    style: TextStyle(fontSize: 18)),
              ),
            );
          }

          if (state is CountryLoadedState) {
            final sortedGroupedList = generateSortedCountryGroups(state);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    // margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const SortGroupWidget(),
                  ),
                  ...sortedGroupedList.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(width: .1),
                        ),
                        child: GroupGridWidget(
                          groupTitle: e.groupTitle,
                          countryList: e.countryList,
                        ),
                      ),
                    );
                  })
                ],
              ),
            );
          }

          return const Center();
        },
      ),
    );
  }

//generates a sorted list of country groups based on the current state.
  List<CountryGroupModel> generateSortedCountryGroups(
      CountryLoadedState state) {
    final countryMap =
        groupCountriesByOption(state.groupingStatus, state.countryList);

    countryMap.forEach((key, value) {
      value.sort((country1, country2) =>
          compareCountriesForSorting(state.sortingStatus, country1, country2));
    });

    final countryGroups = countryMap.entries.map((e) {
      return CountryGroupModel(e.key, e.value);
    }).toList();

    return countryGroups;
  }
}
