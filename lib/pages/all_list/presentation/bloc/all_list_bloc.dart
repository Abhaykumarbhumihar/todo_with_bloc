import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_list_event.dart';
part 'all_list_state.dart';

class AllListBloc extends Bloc<AllListEvent, AllListState> {
  AllListBloc() : super(AllListInitial()) {
    on<AllListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
