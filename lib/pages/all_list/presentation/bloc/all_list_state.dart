part of 'all_list_bloc.dart';

sealed class AllListState extends Equatable {
  const AllListState();
}

final class AllListInitial extends AllListState {
  @override
  List<Object> get props => [];
}
