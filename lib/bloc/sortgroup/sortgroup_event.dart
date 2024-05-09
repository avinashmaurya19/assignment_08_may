part of 'sortgroup_bloc.dart';

sealed class SortgroupEvent extends Equatable {
  const SortgroupEvent();

  @override
  List<Object> get props => [];
}

class OnChangeSortOption extends SortgroupEvent {
  final String sortValue;
  const OnChangeSortOption(this.sortValue);
}

class OnChangeGroupOption extends SortgroupEvent {
  final String groupValue;
  const OnChangeGroupOption(this.groupValue);
}
