import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'speaking_model.dart';
export 'speaking_model.dart';

class SpeakingWidget extends StatefulWidget {
  const SpeakingWidget({Key? key}) : super(key: key);

  @override
  _SpeakingWidgetState createState() => _SpeakingWidgetState();
}

class _SpeakingWidgetState extends State<SpeakingWidget> {
  late SpeakingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpeakingModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Speaking',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                  child: LinearPercentIndicator(
                    percent: 0.5,
                    lineHeight: 12.0,
                    animation: true,
                    progressColor: FlutterFlowTheme.of(context).primary,
                    backgroundColor: FlutterFlowTheme.of(context).lightGrey2,
                    barRadius: Radius.circular(10.0),
                    padding: EdgeInsets.zero,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn.',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_model.output != null && _model.output != '')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    child: FlutterFlowAudioPlayer(
                      audio: Audio.network(
                        _model.output!,
                        metas: Metas(
                          id: 'sample3.mp3-7de80ed2',
                          title: 'Check again',
                        ),
                      ),
                      titleTextStyle: FlutterFlowTheme.of(context).titleLarge,
                      playbackDurationTextStyle:
                          FlutterFlowTheme.of(context).labelMedium,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      playbackButtonColor: FlutterFlowTheme.of(context).primary,
                      activeTrackColor: FlutterFlowTheme.of(context).alternate,
                      elevation: 4.0,
                      playInBackground:
                          PlayInBackground.disabledRestoreOnForeground,
                    ),
                  ),
                Builder(
                  builder: (context) {
                    if (_model.isRecord) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          setState(() {
                            _model.isRecord = false;
                          });
                          _model.output = await _model.audioRecorder?.stop();

                          setState(() {});
                        },
                        child: Lottie.network(
                          'https://lottie.host/4fa71d21-93e6-4373-b2d8-5b8bcbc2fcbe/jHaDAJy5ix.json',
                          height: 120.0,
                          fit: BoxFit.contain,
                          animate: true,
                        ),
                      );
                    } else {
                      return FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 100.0,
                        borderWidth: 1.0,
                        buttonSize: 120.0,
                        fillColor: FlutterFlowTheme.of(context).primary,
                        icon: Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                          size: 48.0,
                        ),
                        onPressed: () async {
                          await requestPermission(microphonePermission);
                          if (await getPermissionStatus(microphonePermission)) {
                            _model.audioRecorder ??= Record();
                            if (await _model.audioRecorder!.hasPermission()) {
                              await _model.audioRecorder!.start();
                            } else {
                              showSnackbar(
                                context,
                                'You have not provided permission to record audio.',
                              );
                            }

                            setState(() {
                              _model.isRecord = true;
                            });
                          }
                        },
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Check it',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
