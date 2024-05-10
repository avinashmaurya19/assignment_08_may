part of 'sortgroup_bloc.dart';

class SortgroupState extends Equatable {
  const SortgroupState({
    // required this.sortValue, 
    required this.groupValue});

  // final String sortValue;
  final String groupValue;

  @override
  List<Object> get props => [
    // sortValue,
   groupValue];

  SortgroupState copyWith({
    // String? sortValue,
    String? groupValue,
  }) {
    return SortgroupState(
      // sortValue: sortValue ?? this.sortValue,
      groupValue: groupValue ?? this.groupValue,
    );
  }

}



