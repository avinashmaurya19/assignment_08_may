import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment_new/data/repositories/country_repository.dart';

import '../../data/models/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

// enum SortOption { name, population, area }

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  List<CountryModel> filtList = [];
  // SortOption _selectedSortOption = SortOption.name;

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

    on<SortNamePopulationEvent>(
      (event, emit) {
        filtList = event.filteredCountryList;
        filtList = _sortCountryList(event.option);
        // log(filtList.toString());
        emit(SortNamePopulationState(filteredCountryList: filtList));
      },
    );
  }

  List<CountryModel> _sortCountryList(String option) {
    switch (option) {
      case "Name":
        filtList.sort((a, b) => a.nameCommon.compareTo(b.nameCommon));
        break;
      case "population":
        filtList.sort((b, a) => a.population.compareTo(b.population));
        break;
      case "area":
        filtList.sort((b, a) => a.area.compareTo(b.area));
        break;
    }
    return filtList;
  }

  final CountryRepository countryRepository;
}
