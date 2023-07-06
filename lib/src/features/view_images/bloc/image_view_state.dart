part of 'image_view_bloc.dart';

abstract class ImageViewState extends Equatable {
  final int index;
  const ImageViewState(this.index);

  ImageViewState copyWith({int? index});
  @override
  List<Object> get props => [];
}

class ImageViewCurrentIndexState extends ImageViewState {
  const ImageViewCurrentIndexState(index) : super(index);
  @override
  ImageViewCurrentIndexState copyWith({
    int? index,
  }) {
    return ImageViewCurrentIndexState(
      index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}
