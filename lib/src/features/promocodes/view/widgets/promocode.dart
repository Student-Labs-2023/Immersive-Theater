import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 34,
                    icon: Image.asset(ImagesSources.close),
                    splashRadius: 24,
                  ),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset(ImagesSources.ticketOutline),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'К сожалению, у вас еще нет \n активных промокодов',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black.withOpacity(0.3)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: (() {}),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(accentTextColor),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(328, 48)),
                    ),
                    child: Text(
                      'Активировать промокод',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
