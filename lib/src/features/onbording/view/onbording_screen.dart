import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onbording/model/onboard.dart';

import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
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
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onboard> onbordingData = [
    Onboard(
      progress: 0.5,
      image: ImagesSources.onbording,
      title: 'Дом Актера\n Представляет',
      description:
          'Всего в экскурсии X точек. Еще какой-нибудь интересный текст',
    ),
    Onboard(
      progress: 1.0,
      image: ImagesSources.secondOnbording,
      title: 'Дом Актера\n Представляет',
      description:
          'Всего в экскурсии X точек. Еще какой-нибудь интересный текст',
    )
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          itemCount: onbordingData.length,
          controller: _pageController,
          itemBuilder: (context, index) => OnbordingContent(
            imageName: onbordingData[index].image,
            text: onbordingData[index].description,
            progress: onbordingData[index].progress,
            title: onbordingData[index].title,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 72,
              width: 72,
              child: CircularProgressIndicator(
                color: accentTextColor,
                value: _pageIndex == 0 ? 0.5 : 1.0,
                strokeWidth: 5,
              ),
            ),
            FloatingActionButton(
              elevation: 5,
              onPressed: _pageIndex == 1
                  ? () => Navigator.of(context)
                      .popAndPushNamed(MainScreen.routeName)
                  : () => _pageController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      ),
              backgroundColor: accentTextColor,
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
