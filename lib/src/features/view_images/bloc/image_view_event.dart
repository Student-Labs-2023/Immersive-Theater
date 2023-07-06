part of 'image_view_bloc.dart';

abstract class ImageViewEvent extends Equatable {
  const ImageViewEvent();

  @override
  List<Object> get props => [];
}

class ImageViewPageChanged extends ImageViewEvent {
  final int index;

  const ImageViewPageChanged(this.index);
  @override
  List<Object> get props => [index];
}
