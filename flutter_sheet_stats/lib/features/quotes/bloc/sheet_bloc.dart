import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_event.dart';
import 'package:flutter_sheet_stats/features/quotes/bloc/sheet_state.dart';
import 'package:flutter_sheet_stats/features/quotes/repository/sheet_repository.dart';

class SheetBloc extends Bloc<QuoteEvent, QuoteState> {
  final SheetRepository _repository;

  SheetBloc(this._repository) : super(SheetLoadingState()) {
    on<LoadSheetEvent>((event, emit) async {
      emit(SheetLoadingState());
      try{
        final model = await _repository.getQuote();
        emit(SheetLoadedState(model));
      }catch (e) {
        emit(SheetErrorState(e.toString()));
      }
    });
  }
}