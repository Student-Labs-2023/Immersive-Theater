import 'package:shebalin/src/theme/images.dart';

class Emoji {
  final bool isActive;
  final String icon;

  Emoji({required this.isActive, required this.icon});

  Emoji copyWith({
    bool? isActive,
    String? icon,
  }) {
    return Emoji(
      isActive: isActive ?? this.isActive,
      icon: icon ?? this.icon,
    );
  }

  static List<Emoji> emotions = [
    Emoji(
      isActive: false,
      icon: ImagesSources.angrySmile,
    ),
    Emoji(
      isActive: false,
      icon: ImagesSources.sarcasmSmile,
    ),
    Emoji(
      isActive: false,
      icon: ImagesSources.okSmile,
    ),
    Emoji(
      isActive: false,
      icon: ImagesSources.goodSmile,
    ),
    Emoji(
      isActive: false,
      icon: ImagesSources.perfectSmile,
    ),
  ];
}
