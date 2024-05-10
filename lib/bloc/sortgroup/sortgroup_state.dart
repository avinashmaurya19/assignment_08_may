part of 'sortgroup_bloc.dart';

class SortgroupState extends Equatable {
  const SortgroupState({
    required this.groupValue});

  final String groupValue;

  @override
  List<Object> get props => [
   groupValue];

  SortgroupState copyWith({
    String? groupValue,
  }) {
    return SortgroupState(
      groupValue: groupValue ?? this.groupValue,
    );
  }

}



