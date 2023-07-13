import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
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
          icon: Image.asset(ImagesSources.backIcon),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColor.whiteBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
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
            SizedBox(
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
                              isActive: emotions[index].isActive,
                              icon: emotions[index].icon,
                            ),
                          ))),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ReviewTextField(
              controller: _controller,
              label: "Что пошло не так?",
            ),
            const SizedBox(
              height: 16,
            ),
            AppButton.purpleButton(title: "Пропустить", onTap: _onTap)
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

class AppButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
  const AppButton.purpleButton({
    super.key,
    required this.title,
    required this.onTap,
  })  : textColor = AppColor.whiteText,
        backgroundColor = AppColor.purplePrimary,
        borderColor = AppColor.purplePrimary;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.06,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
