import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AudioPanelState extends ChangeNotifier {
  PanelController panelController = PanelController();

  void openPanel() {
    panelController.open();
    notifyListeners();
  }

  void closePanel() {
    panelController.open();
    notifyListeners();
  }
}
