import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sortgroup_event.dart';
part 'sortgroup_state.dart';

class SortgroupBloc extends Bloc<SortgroupEvent, SortgroupState> {
  SortgroupBloc()
      : super(SortgroupState(
            // sortValue: 'Name',
            groupValue: 'Continent')) {
    // on<OnChangeSortOption>((event, emit) {
    //   emit(state.copyWith(sortValue: event.sortOption));
    // });
    on<OnChangeGroupOption>((event, emit) {
      emit(state.copyWith(groupValue: event.groupValue));
    });

   
  }
}
