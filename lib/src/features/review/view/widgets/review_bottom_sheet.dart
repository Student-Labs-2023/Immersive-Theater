import 'package:flutter/material.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/ui/app_resize_handler.dart';
import 'package:shebalin/src/theme/ui/app_subtitle.dart';

class ReviewBottomSheet extends StatelessWidget {
  final VoidCallback onPerfModeComplete;
  const ReviewBottomSheet({
    super.key,
    required this.onPerfModeComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 44,
            spreadRadius: 0,
            offset: const Offset(0, -12),
            color: AppColor.blackText.withOpacity(0.12),
          )
        ],
        color: AppColor.whiteBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 34),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppResizeHandler(),
            const SizedBox(
              height: 20,
            ),
            const AppTitle(title: 'Спасибо за отзыв!'),
            const SizedBox(
              height: 16,
            ),
            const AppSubtitle(
              subtitle: 'Вы делаете наше приложение лучше',
              subtitleAccent: '',
            ),
            const SizedBox(
              height: 40,
            ),
            AppButton.primaryButton(
              title: 'Вернуться на главный экран',
              onTap: onPerfModeComplete,
            )
          ],
        ),
      ),
    );
  }
}
