import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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
import 'flash_card_view_model.dart';
export 'flash_card_view_model.dart';

class FlashCardViewWidget extends StatefulWidget {
  const FlashCardViewWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryRecord? category;

  @override
  _FlashCardViewWidgetState createState() => _FlashCardViewWidgetState();
}

class _FlashCardViewWidgetState extends State<FlashCardViewWidget>
    with TickerProviderStateMixin {
  late FlashCardViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasStackTriggered = false;
  final animationsMap = {
    'stackOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 330.ms,
          begin: Offset(250.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 330.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(0.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: 1.0,
          end: 0.4,
        ),
      ],
    ),
    'columnOnActionTriggerAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(0.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: 1.0,
          end: 0.4,
        ),
      ],
    ),
    'containerOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(0.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: 1.0,
          end: 0.4,
        ),
      ],
    ),
    'columnOnActionTriggerAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(0.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 450.ms,
          begin: 1.0,
          end: 0.4,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FlashCardViewModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.queriedCards = await queryCardsRecordOnce(
        queryBuilder: (cardsRecord) => cardsRecord.where(
          'category',
          isEqualTo: '/category/${widget.category?.reference.id}',
        ),
      );
      setState(() {
        _model.filteredCards =
            _model.queriedCards!.toList().cast<CardsRecord>();
      });
      while (_model.indexCardShown! < _model.filteredCards.length) {
        setState(() {
          _model.addToCardsShown(false);
        });
        setState(() {
          _model.indexCardShown = _model.indexCardShown! + 1;
        });
      }
      setState(() {
        _model.indexCardShown = 0;
      });
      await _model.getCurrentCardReviewStatus(context);
      await _model.updateLearningStatus(context);
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 54.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget.category?.name,
              'Category Name',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: Colors.black,
                  fontSize: 24.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineMediumFamily),
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 24.0, 15.0, 0.0),
            child: Container(
              width: double.infinity,
              height: 671.0,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                    child: Container(
                      height: 350.0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(
                              children: [
                                if (_model.cardFlipped)
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(2.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 18.0, 0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(120.0),
                                            child: Image.network(
                                              _model
                                                  .queriedCards![
                                                      _model.indexCardShown!]
                                                  .image,
                                              width: 150.0,
                                              height: 150.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    _model
                                                        .queriedCards?[_model
                                                            .indexCardShown!]
                                                        ?.wordVn,
                                                    'word_vn',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 36.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 20.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 40.0,
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.volumeDown,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    _model.soundPlayer1 ??=
                                                        AudioPlayer();
                                                    if (_model.soundPlayer1!
                                                        .playing) {
                                                      await _model.soundPlayer1!
                                                          .stop();
                                                    }
                                                    _model.soundPlayer1!
                                                        .setVolume(1.0);
                                                    _model.soundPlayer1!
                                                        .setUrl(_model
                                                            .queriedCards![_model
                                                                .indexCardShown!]
                                                            .pronunciation)
                                                        .then((_) => _model
                                                            .soundPlayer1!
                                                            .play());
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/uk_flag.png',
                                                    width: 30.0,
                                                    height: 30.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model
                                                          .queriedCards?[_model
                                                              .indexCardShown!]
                                                          ?.wordEn,
                                                      'word_en',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/fr_flag.png',
                                                    width: 30.0,
                                                    height: 30.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model
                                                          .queriedCards?[_model
                                                              .indexCardShown!]
                                                          ?.wordFr,
                                                      'word_fr',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).animateOnActionTrigger(
                                      animationsMap[
                                          'columnOnActionTriggerAnimation1']!,
                                    ),
                                  ).animateOnActionTrigger(
                                    animationsMap[
                                        'containerOnActionTriggerAnimation1']!,
                                  ),
                                if (!_model.cardFlipped)
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(2.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.isNewWord)
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 15.0, 15.0, 0.0),
                                              child: Container(
                                                width: 116.0,
                                                height: 38.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFFE5E9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '1e0n37qi' /* NEW WORD */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Color(
                                                                    0xFFDE4A61),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.isNewWord)
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 15.0, 15.0, 0.0),
                                              child: Container(
                                                width: 116.0,
                                                height: 38.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFFF2CC),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                10.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'p45dblon' /* REVIEWING */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Color(
                                                                    0xFFFF5E2B),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Flexible(
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    _model
                                                        .queriedCards?[_model
                                                            .indexCardShown!]
                                                        ?.wordVn,
                                                    'word_vn',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 36.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 20.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 40.0,
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.volumeDown,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    _model.soundPlayer2 ??=
                                                        AudioPlayer();
                                                    if (_model.soundPlayer2!
                                                        .playing) {
                                                      await _model.soundPlayer2!
                                                          .stop();
                                                    }
                                                    _model.soundPlayer2!
                                                        .setVolume(1.0);
                                                    _model.soundPlayer2!
                                                        .setUrl(_model
                                                            .queriedCards![_model
                                                                .indexCardShown!]
                                                            .pronunciation)
                                                        .then((_) => _model
                                                            .soundPlayer2!
                                                            .play());
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).animateOnActionTrigger(
                                      animationsMap[
                                          'columnOnActionTriggerAnimation2']!,
                                    ),
                                  ).animateOnActionTrigger(
                                    animationsMap[
                                        'containerOnActionTriggerAnimation2']!,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animateOnActionTrigger(
                        animationsMap['stackOnActionTriggerAnimation']!,
                        hasBeenTriggered: hasStackTriggered),
                  ),
                  if (!_model.cardFlipped)
                    FFButtonWidget(
                      onPressed: () async {
                        setState(() {
                          _model.cardFlipped = !_model.cardFlipped;
                        });
                      },
                      text: FFLocalizations.of(context).getText(
                        'tycf4f3f' /* Click to reveal meaning */,
                      ),
                      icon: Icon(
                        Icons.repeat_sharp,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 58.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .titleSmallFamily),
                            ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      showLoadingIndicator: false,
                    ),
                  if (_model.cardFlipped)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            final firestoreBatch =
                                FirebaseFirestore.instance.batch();
                            try {
                              _model.learntCardRef =
                                  await queryLearntCardRecordOnce(
                                queryBuilder: (learntCardRecord) =>
                                    learntCardRecord
                                        .where(
                                          'user_id',
                                          isEqualTo: currentUserReference,
                                        )
                                        .where(
                                          'card_ref',
                                          isEqualTo: _model
                                              .filteredCards[
                                                  _model.indexCardShown!]
                                              .reference,
                                        ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              if (_model.learntCardRef?.reference != null) {
                                if (_model.learntCardRef!.srGroup > 0) {
                                  firestoreBatch
                                      .update(_model.learntCardRef!.reference, {
                                    ...mapToFirestore(
                                      {
                                        'sr_group': FieldValue.increment(-(1)),
                                      },
                                    ),
                                  });
                                }

                                firestoreBatch
                                    .update(_model.learntCardRef!.reference, {
                                  ...mapToFirestore(
                                    {
                                      'review_date':
                                          FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                              } else {
                                firestoreBatch
                                    .set(LearntCardRecord.collection.doc(), {
                                  ...createLearntCardRecordData(
                                    cardRef: _model
                                        .filteredCards[_model.indexCardShown!]
                                        .reference,
                                    srGroup: 0,
                                    userId: currentUserReference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'review_date':
                                          FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                              }

                              await _model.nextCard(context);
                            } finally {
                              await firestoreBatch.commit();
                            }

                            setState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'a79dxdg5' /* I didn't know this word */,
                          ),
                          icon: Icon(
                            Icons.close,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 58.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF3E1D2),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: Color(0xFFFF5E2B),
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.learntCardRefCopy =
                                  await queryLearntCardRecordOnce(
                                queryBuilder: (learntCardRecord) =>
                                    learntCardRecord
                                        .where(
                                          'user_id',
                                          isEqualTo: currentUserReference,
                                        )
                                        .where(
                                          'card_ref',
                                          isEqualTo: _model
                                              .filteredCards[
                                                  _model.indexCardShown!]
                                              .reference,
                                        ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              if (_model.learntCardRef?.reference != null) {
                                await _model.learntCardRef!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'sr_group': FieldValue.increment(1),
                                    },
                                  ),
                                });

                                await _model.learntCardRef!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'review_date':
                                          FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                              } else {
                                await LearntCardRecord.collection.doc().set({
                                  ...createLearntCardRecordData(
                                    cardRef: _model
                                        .filteredCards[_model.indexCardShown!]
                                        .reference,
                                    srGroup: 3,
                                    userId: currentUserReference,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'review_date':
                                          FieldValue.serverTimestamp(),
                                    },
                                  ),
                                });
                              }

                              await _model.nextCard(context);

                              setState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'pv63az42' /* I know this word */,
                            ),
                            icon: Icon(
                              Icons.check,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 58.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFC7F3CF),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: Color(0xFF1AA152),
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ],
                    ),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 1.00),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Mastered ${_model.noMasteredCard.toString()} out of ${_model.filteredCards.length.toString()} words',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: LinearPercentIndicator(
                                  percent: valueOrDefault<double>(
                                    _model.noMasteredCard /
                                        _model.filteredCards.length,
                                    0.5,
                                  ),
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.92,
                                  lineHeight: 12.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).success,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  barRadius: Radius.circular(5.0),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Review ${_model.noReviewCard.toString()} out of ${_model.filteredCards.length.toString()} words',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: LinearPercentIndicator(
                                  percent: valueOrDefault<double>(
                                    _model.noReviewCard /
                                        _model.filteredCards.length,
                                    0.5,
                                  ),
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.92,
                                  lineHeight: 12.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor: Color(0xFFFFBE2B),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  barRadius: Radius.circular(5.0),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Learning ${_model.noLearningCard.toString()} out of ${_model.filteredCards.length.toString()} words',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: LinearPercentIndicator(
                                  percent: valueOrDefault<double>(
                                    _model.noLearningCard /
                                        _model.filteredCards.length,
                                    0.5,
                                  ),
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.92,
                                  lineHeight: 12.0,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).error,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  barRadius: Radius.circular(5.0),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
