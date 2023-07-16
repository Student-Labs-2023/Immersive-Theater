import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_subtitle.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/animated_title.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/features/review/view/widgets/emoji.dart';
import 'package:shebalin/src/features/review/view/widgets/review_bottom_sheet.dart';
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
  late final ReviewPageBloc reviewbloc;

  @override
  void didChangeDependencies() {
    reviewbloc = context.read<ReviewPageBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                MainScreen.routeName,
                (route) => false,
              ),
            ),
          ),
          backgroundColor: AppColor.whiteBackground,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: BlocConsumer<ReviewPageBloc, ReviewPageState>(
              listener: (context, state) => {
                if (state is ReviewPageReviewSended)
                  {
                    showModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return const ReviewBottomSheet();
                      },
                    )
                  }
              },
              builder: (context, state) {
                return Column(
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
                      child: Emojies(
                        onTapEmoji: _onEmojiTap,
                        emotions: reviewbloc.emotions,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ReviewTextField(
                      label: 'Что пошло не так?',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: state is ReviewPageButtonActive ? 1 : 0.4,
                      child: AppButton.primaryButton(
                        title: 'Отправить отзыв',
                        onTap: state is ReviewPageButtonActive ? _onTap : null,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _onTap() {
    reviewbloc.add(const ReviewPageSendReview());
  }

  void _onEmojiTap(int index) {
    reviewbloc.add(ReviewPageEmojiAdded(index: index));
  }
}
