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
      required this.groupValue});

  final String groupValue;

  @override
  List<Object?> get props => [
        groupValue
      ];
}

class SortNamePopulationEvent extends CountryEvent {
   String option;
  List<CountryModel> filteredCountryList;

   SortNamePopulationEvent({required this.option,required this.filteredCountryList});
  @override
  List<Object?> get props => [
        option,
      ];
}
