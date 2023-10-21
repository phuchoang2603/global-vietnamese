// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> getNumberOfFilteredLearntCards(
  List<LearntCardRecord>? learntCards,
  List<CardsRecord>? filteredCards,
) async {
  // filter cards in learntCards that's also in filteredCards
  if (learntCards == null || filteredCards == null) {
    return -1;
  }

  List<LearntCardRecord> filteredLearntCards = [];

  for (LearntCardRecord learntCard in learntCards) {
    for (CardsRecord filteredCard in filteredCards) {
      if (learntCard.cardRef == filteredCard) {
        filteredLearntCards.add(learntCard);
        break;
      }
    }
  }

  return filteredLearntCards.length;
}
