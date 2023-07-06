import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/view_images/bloc/image_view_bloc.dart';
import 'package:shebalin/src/features/view_images/models/image_view_args.dart';
import 'package:shebalin/src/features/view_images/view/widgets/full_screen_image.dart';
import 'package:shebalin/src/theme/images.dart';

class ImagesViewPage extends StatelessWidget {
  static const routeName = '/images-view-page';

  const ImagesViewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ImageViewArgs;
    ImageViewBloc bloc = ImageViewBloc(args.position);
    return BlocProvider(
      create: (context) {
        return bloc;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(ImagesSources.backIcon),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: BlocBuilder<ImageViewBloc, ImageViewState>(
            builder: (context, state) {
              return Text(
                "${state.index + 1} из ${args.imageLinks.length}",
                style: const TextStyle(fontSize: 17),
              );
            },
          ),
        ),
        body: PageView.builder(
          controller: PageController(
            initialPage: args.position,
            keepPage: true,
            viewportFraction: 1,
          ),
          onPageChanged: (value) {
            bloc.add(ImageViewPageChanged(value));
          },
          itemCount: args.imageLinks.length,
          itemBuilder: (context, index) {
            return FulScreenImageLocation(
              imagePath: args.imageLinks[index],
            );
          },
        ),
      ),
    );
  }
}
