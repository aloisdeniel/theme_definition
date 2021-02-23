import 'package:flutter/material.dart';

import 'app/state.dart';
import 'app/update.dart';

class ApplicationNotifier extends ChangeNotifier {
  ApplicationNotifier(ApplicationState initialState) : _state = initialState;
  ApplicationState _state;
  ApplicationState get state => _state;

  set state(ApplicationState newValue) {
    if (_state == newValue) {
      return;
    }
    _state = newValue;
    notifyListeners();
  }

  void dispatch(ApplicationUpdate update) async {
    try {
      await for (var state in update.execute(() => state, this.dispatch)) {
        this.state = state;
      }
    } catch (e) {
      print('Error during $update processing : $e');
    }
  }
}
