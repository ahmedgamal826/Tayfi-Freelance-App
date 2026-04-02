import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tayfi/widgets/tool_widgets/tool_details_app_bar.dart';
import 'package:tayfi/widgets/tool_widgets/tool_details_info_card.dart';

class VideoWebViewScreen extends StatefulWidget {
  const VideoWebViewScreen({
    super.key,
    required this.titleArabic,
    required this.titleEnglish,
    required this.usage,
    required this.advantage,
    required this.videoUrl,
  });

  final String titleArabic;
  final String titleEnglish;
  final String usage;
  final String advantage;
  final String videoUrl;

  @override
  State<VideoWebViewScreen> createState() => _VideoWebViewScreenState();
}

class _VideoWebViewScreenState extends State<VideoWebViewScreen> {
  YoutubePlayerController? _controller;
  String? _videoId;

  Future<void> _setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _reloadVideo() async {
    final controller = _controller;
    final videoId = _videoId;
    if (controller == null || videoId == null || videoId.isEmpty) return;
    controller.load(videoId);
  }

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if ((_videoId ?? '').isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: _videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: false,
          forceHD: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _setPortraitOrientation();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValidVideo = _controller != null;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF111111),
        appBar: ToolDetailsAppBar(
          titleArabic: widget.titleArabic,
          titleEnglish: widget.titleEnglish,
          onBack: () async {
            await _setPortraitOrientation();
            if (!mounted) return;
            Navigator.of(context).pop();
          },
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/homeBackgroundImage.jpg',
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black.withValues(alpha: 0.50)),
            SafeArea(
              top: false,
              child: hasValidVideo
                  ? YoutubePlayerBuilder(
                      onEnterFullScreen: () async {
                        await _setLandscapeOrientation();
                      },
                      onExitFullScreen: () async {
                        await _setPortraitOrientation();
                      },
                      player: YoutubePlayer(
                        controller: _controller!,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.redAccent,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.redAccent,
                          handleColor: Colors.red,
                        ),
                      ),
                      builder: (context, player) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final isLandscape =
                                constraints.maxWidth > constraints.maxHeight;
                            final horizontalPadding = isLandscape ? 16.0 : 12.0;
                            final verticalPadding = isLandscape ? 12.0 : 10.0;

                            Widget buildVideoCard(double aspectRatio) {
                              return AspectRatio(
                                aspectRatio: aspectRatio,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x55000000),
                                        blurRadius: 24,
                                        offset: Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        player,
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: FilledButton.tonalIcon(
                                            onPressed: _reloadVideo,
                                            icon: const Icon(
                                              Icons.refresh_rounded,
                                              size: 18,
                                            ),
                                            label: const Text('إعادة التشغيل'),
                                            style: FilledButton.styleFrom(
                                              backgroundColor: Colors.black
                                                  .withValues(alpha: 0.55),
                                              foregroundColor: Colors.white,
                                              visualDensity:
                                                  VisualDensity.compact,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            if (isLandscape) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.fromLTRB(
                                  horizontalPadding,
                                  verticalPadding,
                                  horizontalPadding,
                                  20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ToolDetailsInfoCard(
                                        titleArabic: widget.titleArabic,
                                        titleEnglish: widget.titleEnglish,
                                        usage: widget.usage,
                                        advantage: widget.advantage,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      flex: 4,
                                      child: buildVideoCard(16 / 9),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(
                                horizontalPadding,
                                verticalPadding,
                                horizontalPadding,
                                24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildVideoCard(5 / 4),
                                  const SizedBox(height: 14),
                                  ToolDetailsInfoCard(
                                    titleArabic: widget.titleArabic,
                                    titleEnglish: widget.titleEnglish,
                                    usage: widget.usage,
                                    advantage: widget.advantage,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'تعذر تشغيل الفيديو داخل التطبيق لأن الرابط غير صالح أو غير مدعوم.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
