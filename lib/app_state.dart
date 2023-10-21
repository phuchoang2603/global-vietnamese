import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<DocumentReference> _flashcards = [];
  List<DocumentReference> get flashcards => _flashcards;
  set flashcards(List<DocumentReference> _value) {
    _flashcards = _value;
  }

  void addToFlashcards(DocumentReference _value) {
    _flashcards.add(_value);
  }

  void removeFromFlashcards(DocumentReference _value) {
    _flashcards.remove(_value);
  }

  void removeAtIndexFromFlashcards(int _index) {
    _flashcards.removeAt(_index);
  }

  void updateFlashcardsAtIndex(
    int _index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    _flashcards[_index] = updateFn(_flashcards[_index]);
  }

  void insertAtIndexInFlashcards(int _index, DocumentReference _value) {
    _flashcards.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
