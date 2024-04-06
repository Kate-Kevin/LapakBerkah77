part of 'autocomplete_bloc.dart';

abstract class AutocompleteEvent extends Equatable {
  const AutocompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAutoComplete extends AutocompleteEvent{
  final String searchInput;

  const LoadAutoComplete({this.searchInput = ''});

  @override
  List<Object> get props => [searchInput];
}