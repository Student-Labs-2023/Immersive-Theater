part of 'review_page_bloc.dart';

abstract class ReviewPageEvent extends Equatable {
  const ReviewPageEvent();

  @override
  List<Object> get props => [];
}

class ReviewPageTextFieldChanged extends ReviewPageEvent {
  final String text;

  const ReviewPageTextFieldChanged({required this.text});
  @override
  List<Object> get props => [text];
}
