import '../../../models/sheet_model.dart';

abstract class QuoteState {}

class SheetLoadingState extends QuoteState {
}

class SheetErrorState extends QuoteState {
  final String message;
  SheetErrorState(this.message);
}

class SheetLoadedState extends QuoteState {
  final Sheet model;
  SheetLoadedState(this.model);
}