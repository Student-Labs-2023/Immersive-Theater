part of 'review_page_bloc.dart';

abstract class ReviewPageState extends Equatable {
  const ReviewPageState();

  @override
  List<Object> get props => [];
}

class ReviewPageInitial extends ReviewPageState {}

class ReviewPageEmptyTextField extends ReviewPageState {}

class ReviewPageNotEmptyTextField extends ReviewPageState {}

class ReviewPageFailure extends ReviewPageState {}
