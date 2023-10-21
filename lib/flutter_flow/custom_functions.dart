import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

int getNumberOfFilteredLearntCard(
  List<LearntCardRecord> learntCards,
  List<CardsRecord> filteredCards,
) {
  int numCard = 0;
  List<LearntCardRecord> lcr = [];
  for (LearntCardRecord learntCard in learntCards) {
    for (CardsRecord card in filteredCards) {
      if (learntCard.cardRef == card.reference) {
        lcr.add(learntCard);
        break;
      }
    }
  }
  print(lcr.length);
  return lcr.length;
}
