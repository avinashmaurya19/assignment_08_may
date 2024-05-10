part of 'country_bloc.dart';

@immutable
abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class LoadCountryEvent extends CountryEvent {
  @override
  List<Object?> get props => [];
}

class ChangeGroupEvent extends CountryEvent {
  const ChangeGroupEvent(
      {
      // required this.sortValue,
      required this.groupValue});

  // final String sortValue;
  final String groupValue;

  @override
  List<Object?> get props => [
        // sortValue,
        groupValue
      ];
}

class ChangeSortEvent extends CountryEvent {
  const ChangeSortEvent({required this.sortValue});
  final String sortValue;

  @override
  List<Object?> get props => [
        sortValue,
      ];
}

class SortNamePopulationEvent extends CountryEvent {
  final String option;

  SortNamePopulationEvent({required this.option});
   @override
  List<Object?> get props => [
        option,
      ];
}