import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_page_event.dart';
part 'review_page_state.dart';

class ReviewPageBloc extends Bloc<ReviewPageEvent, ReviewPageState> {
  String _text = '';
  ReviewPageBloc() : super(ReviewPageEmptyTextField()) {
    on<ReviewPageTextFieldChanged>(_onReviewPageTextFieldChanged);
  }

  void _onReviewPageTextFieldChanged(
    ReviewPageTextFieldChanged event,
    Emitter<ReviewPageState> emit,
  ) {
    _text = event.text;
    if (_text.isEmpty) {
      return emit(ReviewPageEmptyTextField());
    }
    emit(ReviewPageNotEmptyTextField());
  }
}
