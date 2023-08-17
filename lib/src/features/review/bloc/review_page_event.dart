part of 'review_page_bloc.dart';

abstract class ReviewPageEvent extends Equatable {
  const ReviewPageEvent();

  @override
  List<Object> get props => [];
}

class ReviewPageTextAdded extends ReviewPageEvent {
  final String text;

  const ReviewPageTextAdded({required this.text});
  @override
  List<Object> get props => [text];
}

class ReviewPageEmojiAdded extends ReviewPageEvent {
  final int index;

  const ReviewPageEmojiAdded({required this.index});
  @override
  List<Object> get props => [index];
}

class ReviewPageSendReview extends ReviewPageEvent {
  const ReviewPageSendReview();
  @override
  List<Object> get props => [];
}
