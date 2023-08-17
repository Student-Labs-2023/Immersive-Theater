import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';

class ReviewTextField extends StatelessWidget {
  final String label;
  const ReviewTextField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
        color: AppColor.accentBackground,
      ),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.19),
      child: TextField(
        enabled:
            context.watch<ReviewPageBloc>().state is! ReviewPageReviewSended,
        onChanged: (text) {
          context.read<ReviewPageBloc>().add(ReviewPageTextAdded(text: text));
        },
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: double.maxFinite.floor(),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.transparent,
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.lightGray),
          ),
        ),
      ),
    );
  }
}
