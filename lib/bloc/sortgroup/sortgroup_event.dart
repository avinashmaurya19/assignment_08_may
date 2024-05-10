part of 'sortgroup_bloc.dart';

sealed class SortgroupEvent extends Equatable {
  const SortgroupEvent();

  @override
  List<Object> get props => [];
}

// class OnChangeSortOption extends SortgroupEvent {
//   final String sortOption;
//   const OnChangeSortOption(this.sortOption);
// }

class OnChangeGroupOption extends SortgroupEvent {
  final String groupValue;
  const OnChangeGroupOption(this.groupValue);
}
