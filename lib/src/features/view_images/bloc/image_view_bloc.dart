import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_view_event.dart';
part 'image_view_state.dart';

class ImageViewBloc extends Bloc<ImageViewEvent, ImageViewState> {
  final int initialIndex;
  ImageViewBloc(this.initialIndex)
      : super(ImageViewCurrentIndexState(initialIndex)) {
    on<ImageViewPageChanged>(_onImageViewPageChanged);
  }

  void _onImageViewPageChanged(
    ImageViewPageChanged event,
    Emitter<ImageViewState> emit,
  ) {
    emit(
      state.copyWith(
        index: event.index,
      ),
    );
  }
}
