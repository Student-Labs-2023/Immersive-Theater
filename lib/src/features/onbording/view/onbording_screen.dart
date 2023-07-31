import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/page_indicator.dart';
import 'package:shebalin/src/features/onbording/model/onboard.dart';

import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

import 'widgets/onbording_content.dart';
import '../../../theme/theme.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/onbording-screen';

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  double? _pageIndex = 0;
  final List<Onboard> onbordingData = [
    Onboard(
      progress: 0,
      image: ImagesSources.onbording,
      title: 'Дом актера представляет',
      description:
          'Спектакли в мобильном приложении от независимой театральной площадки в Омске',
    ),
    Onboard(
      progress: 1,
      image: ImagesSources.secondOnbording,
      title: 'Иммерсивный опыт',
      description:
          'Наслаждайтесь спектаклями в городе, проходя по интересным местам Омска',
    ),
    Onboard(
      progress: 2,
      image: ImagesSources.thirdOnbording,
      title: 'Историческая ценность',
      description:
          'Узнайте больше о своем городе и познакомьтесь с новыми персонажами',
    )
  ];
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        if (_pageController.page != null) {
          _pageIndex = _pageController.page;
        } else {
          _pageIndex = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController carController = CarouselController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 5,
            ),
            CarouselSlider.builder(
              carouselController: carController,
              options: CarouselOptions(
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enlargeCenterPage: true,
                autoPlay: false,
                height: MediaQuery.of(context).size.height * 0.8,
                viewportFraction: 1,
              ),
              itemCount: 3,
              itemBuilder: (context, index, pindex) {
                _pageIndex = onbordingData[index].progress;
                return Column(
                  children: [
                    OnbordingContent(
                      imageName:
                          onbordingData[index % onbordingData.length].image,
                      text: onbordingData[index % onbordingData.length]
                          .description,
                      title: onbordingData[index % onbordingData.length].title,
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    PageIndicator(
                      count: 3,
                      currentIndex: index % onbordingData.length,
                      elementHeight: 4,
                      elementWidth: 60,
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      "Пропустить",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColor.greyText),
                    ),
                    onTap: () =>
                        Navigator.of(context).pushNamed(MainScreen.routeName),
                  ),
                  FloatingActionButton(
                    onPressed: () => carController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.linear,
                    ),
                    backgroundColor: AppColor.purplePrimary,
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
