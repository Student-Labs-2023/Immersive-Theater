import 'package:flutter/material.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/promocodes/view/own_promocodes_screen.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';
import 'package:shebalin/src/features/user/view/widgets/ticket.dart';
import 'package:shebalin/src/theme/theme.dart';


class InputPromocodePanelPage extends StatefulWidget {
  const InputPromocodePanelPage({super.key});

  @override
  State<InputPromocodePanelPage> createState() => _InputPromocodePanelPageState();

  static _InputPromocodePanelPageState? of(BuildContext context) {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _InputPromocodePanelPageState? result =
        context.findAncestorStateOfType<_InputPromocodePanelPageState>();
    return result;
  }
}

class _InputPromocodePanelPageState extends State<InputPromocodePanelPage> {
  final _inputTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 52),
            child: Text(
              'Введите промокод',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            height: 40,
            width: 328,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: searchBarRadius,
            ),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 12)),
                Expanded(
                  child: TextField(
                    controller: _inputTextController,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: bodySmallFontSize,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'XXXX-XXXX-XXXX-XXXX',
                      hintStyle:
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()),);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(accentTextColor),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(328, 48)),
            ),
            child: Text(
              'Применить',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
