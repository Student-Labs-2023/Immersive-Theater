import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shebalin/src/features/review/view/widgets/models/emoji.dart';

part 'review_page_event.dart';
part 'review_page_state.dart';

class ReviewPageBloc extends Bloc<ReviewPageEvent, ReviewPageState> {
  final List<Emoji> emotions;
  ReviewPageBloc(this.emotions)
      : super(const ReviewPageButtonDisabled(-1, '')) {
    on<ReviewPageTextAdded>(_onReviewPageTextAdded);
    on<ReviewPageEmojiAdded>(_onReviewPageEmojiAdded);
  }

  void _onReviewPageTextAdded(
    ReviewPageTextAdded event,
    Emitter<ReviewPageState> emit,
  ) {
    if (event.text.isNotEmpty || state.indexEmoji != -1) {
      return emit(ReviewPageButtonActive(state.indexEmoji, event.text));
    }
    return emit(ReviewPageButtonDisabled(state.indexEmoji, event.text));
  }

  void _onReviewPageEmojiAdded(
    ReviewPageEmojiAdded event,
    Emitter<ReviewPageState> emit,
  ) {
    final int index = event.index;
    final int currentIndex = state.indexEmoji;

    if (currentIndex != -1) {
      emotions[currentIndex] = emotions[currentIndex].copyWith(isActive: false);
    }

    if (state.text == '' && currentIndex == index) {
      return emit(const ReviewPageButtonDisabled(-1, ''));
    }
    if (currentIndex != index) {
      emotions[index] = emotions[index].copyWith(isActive: true);
      emit(ReviewPageButtonActive(event.index, state.text));
    } else {
      emit(ReviewPageButtonActive(-1, state.text));
    }
  }
}
