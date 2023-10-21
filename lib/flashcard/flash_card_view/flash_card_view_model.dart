import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'flash_card_view_widget.dart' show FlashCardViewWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class FlashCardViewModel extends FlutterFlowModel<FlashCardViewWidget> {
  ///  Local state fields for this page.

  bool cardFlipped = false;

  List<CardsRecord> filteredCards = [];
  void addToFilteredCards(CardsRecord item) => filteredCards.add(item);
  void removeFromFilteredCards(CardsRecord item) => filteredCards.remove(item);
  void removeAtIndexFromFilteredCards(int index) =>
      filteredCards.removeAt(index);
  void insertAtIndexInFilteredCards(int index, CardsRecord item) =>
      filteredCards.insert(index, item);
  void updateFilteredCardsAtIndex(int index, Function(CardsRecord) updateFn) =>
      filteredCards[index] = updateFn(filteredCards[index]);

  List<bool> cardsShown = [];
  void addToCardsShown(bool item) => cardsShown.add(item);
  void removeFromCardsShown(bool item) => cardsShown.remove(item);
  void removeAtIndexFromCardsShown(int index) => cardsShown.removeAt(index);
  void insertAtIndexInCardsShown(int index, bool item) =>
      cardsShown.insert(index, item);
  void updateCardsShownAtIndex(int index, Function(bool) updateFn) =>
      cardsShown[index] = updateFn(cardsShown[index]);

  int? indexCardShown = 0;

  bool isNewWord = false;

  int noMasteredCard = 0;

  int noReviewCard = 0;

  int noLearningCard = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in FlashCardView widget.
  List<CardsRecord>? queriedCards;
  AudioPlayer? soundPlayer1;
  AudioPlayer? soundPlayer2;
  // Stores action output result for [Firestore Query - Query a collection] action in ButtonDontKnowWord widget.
  LearntCardRecord? learntCardRef;
  // Stores action output result for [Firestore Query - Query a collection] action in ButtonKnowWord widget.
  LearntCardRecord? learntCardRefCopy;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  Future nextCard(BuildContext context) async {
    indexCardShown = indexCardShown! + 1;
    await getCurrentCardReviewStatus(context);
    cardFlipped = false;
    await updateLearningStatus(context);
  }

  Future getCurrentCardReviewStatus(BuildContext context) async {
    LearntCardRecord? learntCardInfo;

    learntCardInfo = await queryLearntCardRecordOnce(
      queryBuilder: (learntCardRecord) => learntCardRecord
          .where(
            'card_ref',
            isEqualTo: filteredCards[indexCardShown!].reference,
          )
          .where(
            'user_id',
            isEqualTo: currentUserReference,
          ),
      singleRecord: true,
    ).then((s) => s.firstOrNull);
    if (learntCardInfo?.reference != null) {
      isNewWord = false;
    } else {
      isNewWord = true;
    }
  }

  Future updateLearningStatus(BuildContext context) async {
    List<LearntCardRecord>? reviewCards;
    List<LearntCardRecord>? masteredCards;

    reviewCards = await queryLearntCardRecordOnce(
      queryBuilder: (learntCardRecord) => learntCardRecord
          .where(
            'user_id',
            isEqualTo: currentUserReference,
          )
          .where(
            'sr_group',
            isLessThan: 3,
          ),
    );
    noReviewCard = functions.getNumberOfFilteredLearntCard(
        reviewCards!.toList(), filteredCards.toList());
    masteredCards = await queryLearntCardRecordOnce(
      queryBuilder: (learntCardRecord) => learntCardRecord
          .where(
            'user_id',
            isEqualTo: currentUserReference,
          )
          .where(
            'sr_group',
            isGreaterThanOrEqualTo: 3,
          ),
    );
    noMasteredCard = functions.getNumberOfFilteredLearntCard(
        masteredCards!.toList(), filteredCards.toList());
    noLearningCard = valueOrDefault<int>(
      filteredCards.length - noReviewCard - noMasteredCard,
      0,
    );
  }

  /// Additional helper methods are added here.
}
