import 'package:shebalin/src/theme/images.dart';

class OnboardPerformance {
  final String title;
  final String subtitle;
  final String buttonTitle;
  final String image;

  OnboardPerformance({
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    required this.image,
  });

  static List<OnboardPerformance> list = [
    OnboardPerformance(
      title: 'Доберитесь до стартовой точки спектакля',
      subtitle:
          'Стартовая точка спектакля находится по адресу: улица Ленина, 4',
      buttonTitle: "Составить маршрут",
      image: ImagesSources.onboardMap,
    ),
    OnboardPerformance(
      title: 'Используйте наушники во время спектакля',
      subtitle:
          'Чтобы уменьшить внешний шум и погрузиться в настроение спектакля',
      buttonTitle: "Далее",
      image: ImagesSources.onboardHeadPhones,
    ),
    OnboardPerformance(
      title: 'Переключайте трек при достижении новой локации',
      subtitle: 'Чтобы переключить трек, нажмите кнопку Продолжить',
      buttonTitle: "Начать спектакль",
      image: ImagesSources.onboardNext,
    ),
  ];
}
