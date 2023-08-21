import 'package:shebalin/src/theme/images.dart';

class OnboardPerformance {
  final String title;
  final String subtitle;
  final String subtitleAccent;
  final String buttonTitle;
  final String image;

  OnboardPerformance({
    required this.subtitleAccent,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    required this.image,
  });

  static List<OnboardPerformance> outside = [
    OnboardPerformance(
      title: 'Доберитесь до стартовой точки спектакля',
      subtitle: 'Стартовая точка спектакля находится по адресу: ',
      subtitleAccent: '',
      buttonTitle: "Составить маршрут",
      image: ImagesSources.onboardMap,
    ),
    OnboardPerformance(
      title: 'Используйте наушники во время спектакля',
      subtitle:
          'Чтобы уменьшить внешний шум и погрузиться в настроение спектакля',
      subtitleAccent: '',
      buttonTitle: 'Далее',
      image: ImagesSources.onboardHeadPhones,
    ),
    OnboardPerformance(
      title: 'Треки переключаются автоматически',
      subtitle:
          'Чтобы переключить трек, дойдите до контрольной точки и дослушайте главу ',
      buttonTitle: 'Начать спектакль',
      image: ImagesSources.onboardNext,
      subtitleAccent: '',
    ),
  ];

  static List<OnboardPerformance> home = [
    OnboardPerformance(
      title: 'Используйте наушники во время спектакля',
      subtitle:
          'Чтобы уменьшить внешний шум и погрузиться в настроение спектакля',
      subtitleAccent: '',
      buttonTitle: 'Далее',
      image: ImagesSources.onboardHeadPhones,
    ),
    OnboardPerformance(
      title: 'Треки переключаются автоматически',
      subtitle: 'Весь спектакль будет воспроизводиться без пауз',
      buttonTitle: 'Начать спектакль',
      image: ImagesSources.onboardNext,
      subtitleAccent: '',
    ),
  ];
}
