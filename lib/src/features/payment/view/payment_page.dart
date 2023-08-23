import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/payment/bloc/payment_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_bar_close.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  static const String routeName = 'payment-web';
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLinkLoaded) {
          context.read<PaymentBloc>().add(PaymentOpenLink());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarBtnClose(
            icon: ImagesSources.closeIcon,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColor.whiteBackground,
          body: SafeArea(
            child: WebViewWidget(
              controller: context.watch<PaymentBloc>().controller,
            ),
          ),
        );
      },
    );
  }
}
