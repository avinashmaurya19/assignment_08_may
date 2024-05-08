part of 'sortgroup_bloc.dart';

sealed class SortgroupEvent extends Equatable {
  const SortgroupEvent();

  @override
  List<Object> get props => [];
}

class onChangeSortOption extends SortgroupEvent {
  String sortValue;
  onChangeSortOption(this.sortValue);
}

class onChangeGroupOption extends SortgroupEvent {
  String groupValue;
  onChangeGroupOption(this.groupValue);
}
