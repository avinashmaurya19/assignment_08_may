import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment_new/data/repositories/country_repository.dart';

import '../../data/models/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

enum SortOption { name, population, area }

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  List<CountryModel> countryList = [];
  SortOption _selectedSortOption = SortOption.name;

  CountryBloc({required this.countryRepository})
      : super(CountryInitialState()) {
    on<LoadCountryEvent>((event, emit) async {
      emit(CountryLoadingState());
      try {
        List<CountryModel> countryList = await countryRepository.getCountries();
        emit(
          CountryLoadedState(
            countryList: countryList,
            sortingStatus: 'Name',
            groupingStatus: 'Continent',
          ),
        );
      } catch (error) {
        emit(CountryErrorState(error: error.toString()));
      }
    });
    on<ChangeGroupEvent>(
      (event, emit) {
        log("group called");
        emit((state as CountryLoadedState).copyWith(
          groupingStatus: event.groupValue,
          //  sortingStatus:
          // event.sortValue
        ));
      },
    );

    on<ChangeSortEvent>(
      (event, emit) {
        log("sort log called");
        emit((state as CountryLoadedState).copyWith(
          sortingStatus: event.sortValue,
          //  sortingStatus:
          // event.sortValue
        ));
      },
    );

    on<SortNamePopulationEvent>(
      (event, emit) {
        SortOption option = SortOption.values.firstWhere(
          (element) => element.name == event.option,
          orElse: () => SortOption.name,
        );
        _selectedSortOption = option;
        List<CountryModel> filteredCountryList = _sortCountryList(option);

        emit(SortNamePopulationState(filteredCountryList: filteredCountryList));
      },
    );
  }

  List<CountryModel> _sortCountryList(SortOption option) {
    switch (option) {
      case SortOption.name:
        countryList.sort((a, b) => a.nameCommon.compareTo(b.nameCommon));
        break;
      case SortOption.population:
        countryList.sort((b, a) => a.population.compareTo(b.population));
        break;
      case SortOption.area:
        countryList.sort((b, a) => a.area.compareTo(b.area));
        break;
    }
    return countryList;
  }

  final CountryRepository countryRepository;
}
