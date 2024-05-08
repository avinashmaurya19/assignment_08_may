

import 'package:flutter/material.dart';
import 'package:flutter_assignment_new/data/functions/functions.dart';
import 'package:flutter_assignment_new/data/models/country_group_model.dart';
import 'package:flutter_assignment_new/widgets/groupwidgets/group_grid_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../bloc/countrybloc/country_bloc.dart';
import '../widgets/sorting_grouping_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Country"),
      ),
      backgroundColor: Colors.grey.shade300,
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
            final sortedGroupedList = generateSortedGroupedList(state);
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SortGroupWidget()),
                MultiSliver(children: buildCountryGroups(sortedGroupedList)),
              ],
            );
          }
          return const Center();
        },
      ),
    );
  }

//   List<MapEntry<String, List<CountryModel>>> generateSortedGroupedList(
//     CountryLoadedState state,
//   ) {
//     return (generateCountryMap(state.groupingStatus, state.countryList)
//           ..forEach((key, value) {
//             value.sort((country1, country2) =>
//                 generateSorting(state.sortingStatus, country1, country2));
//           }))
//         .entries
//         .toList();
//   }

//   List<Widget> buildCountryGroups(
//     List<MapEntry<String, List<CountryModel>>> sortedGroupedList,
//   ) {
//     return sortedGroupedList
//         .map((e) => GroupGridWidget(groupTitle: e.key, countryList: e.value))
//         .toList();
//   }
}

List<CountryGroupModel> generateSortedGroupedList(CountryLoadedState state) {
  final countryMap =
      generateCountryMap(state.groupingStatus, state.countryList);

  countryMap.forEach((key, value) {
    value.sort((country1, country2) =>
        generateSorting(state.sortingStatus, country1, country2));
  });

  final countryGroups = countryMap.entries.map((entry) {
    return CountryGroupModel(entry.key, entry.value);
  }).toList();

  return countryGroups;
}

List<Widget> buildCountryGroups(List<CountryGroupModel> sortedGroupedList) {
  return sortedGroupedList.map((group) {
    return GroupGridWidget(
        groupTitle: group.groupTitle, countryList: group.countryList);
  }).toList();
}

