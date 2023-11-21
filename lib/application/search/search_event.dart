part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class PerformSearch extends SearchEvent {
  final String query;

  const PerformSearch({required this.query, required String category});

  @override
  List<Object?> get props => [query];
}
