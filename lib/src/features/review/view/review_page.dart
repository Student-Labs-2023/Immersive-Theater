import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/features/review/view/widgets/emoji.dart';
import 'package:shebalin/src/features/review/view/widgets/models/emoji.dart';
import 'package:shebalin/src/features/review/view/widgets/review_field.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final String performanceTitle = 'Шебалин в Омске';
  late TextEditingController _controller;
  late final List<Emoji> emotions;
  int? _currentIndex;

  @override
  void initState() {
    emotions = Emoji.emotions;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            ImagesSources.closePerformance,
            color: AppColor.blackText,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColor.whiteBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Column(
          children: [
            const AppTitle(title: 'Оцените спектакль'),
            const SizedBox(
              height: 16,
            ),
            AppSubtitle(
              subtitle: 'Как у вас прошёл спектакль .',
              subtitleAccent: '«$performanceTitle».',
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    emotions.length,
                    ((index) => GestureDetector(
                          onTap: () => _onEmojiTap(index),
                          child: EmojiWidget(
                            key: Key(index.toString()),
                            isActive: emotions[index].isActive,
                            icon: emotions[index].icon,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ReviewTextField(
              controller: _controller,
              label: 'Что пошло не так?',
            ),
            const SizedBox(
              height: 24,
            ),
            AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _currentIndex != null || _controller.text.isNotEmpty
                    ? 1
                    : 0.4,
                child: AppButton.purpleButton(
                  title: 'Отправить отзыв',
                  onTap: _onTap,
                ))
          ],
        ),
      ),
    );
  }

  void _onTap() {}

  void _onEmojiTap(int index) {
    if (_currentIndex != null) {
      emotions[_currentIndex!] = emotions[_currentIndex!]
          .copyWith(isActive: !emotions[_currentIndex!].isActive);
    }
    setState(() {});
    if (index != _currentIndex) {
      emotions[index] =
          emotions[index].copyWith(isActive: !emotions[index].isActive);
      _currentIndex = index;
    } else {
      _currentIndex = null;
    }
  }
}
