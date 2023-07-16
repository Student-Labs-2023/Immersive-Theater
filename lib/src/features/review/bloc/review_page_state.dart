part of 'review_page_bloc.dart';

abstract class ReviewPageState extends Equatable {
  final int indexEmoji;
  final String text;
  const ReviewPageState(this.indexEmoji, this.text);

  @override
  List<Object> get props => [];
}

class ReviewPageButtonDisabled extends ReviewPageState {
  const ReviewPageButtonDisabled(int indexEmoji, String text)
      : super(indexEmoji, text);
  ReviewPageButtonDisabled copyWith({
    int? indexEmoji,
    String? text,
  }) {
    return ReviewPageButtonDisabled(
      indexEmoji ?? this.indexEmoji,
      text ?? this.text,
    );
  }

  @override
  List<Object> get props => [indexEmoji, text];
}

class ReviewPageButtonActive extends ReviewPageState {
  const ReviewPageButtonActive(int indexEmoji, String text)
      : super(indexEmoji, text);
  ReviewPageButtonActive copyWith({
    int? indexEmoji,
    String? text,
  }) {
    return ReviewPageButtonActive(
      indexEmoji ?? this.indexEmoji,
      text ?? this.text,
    );
  }

  @override
  List<Object> get props => [indexEmoji, text];
}

class ReviewPageReviewSended extends ReviewPageState {
  const ReviewPageReviewSended(super.indexEmoji, super.text);
}

class ReviewPageFailure extends ReviewPageState {
  ReviewPageFailure(super.indexEmoji, super.text);
}
