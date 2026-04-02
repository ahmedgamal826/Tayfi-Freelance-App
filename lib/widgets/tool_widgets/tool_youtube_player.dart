// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class ToolYoutubePlayer extends StatefulWidget {
//   const ToolYoutubePlayer({super.key, required this.videoUrl});

//   final String videoUrl;

//   @override
//   State<ToolYoutubePlayer> createState() => _ToolYoutubePlayerState();
// }

// class _ToolYoutubePlayerState extends State<ToolYoutubePlayer>
//     with WidgetsBindingObserver {
//   YoutubePlayerController? _controller;
//   String? _videoId;
//   String? _errorMessage;
//   bool _isMuted = false;
//   bool _hasEmbedError = false;
//   bool _hasOpenedExternalFallback = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initializePlayer();
//   }

//   @override
//   void didUpdateWidget(covariant ToolYoutubePlayer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.videoUrl.trim() != widget.videoUrl.trim()) {
//       _disposeController();
//       _initializePlayer();
//     }
//   }

//   void _initializePlayer() {
//     _videoId = null;
//     _errorMessage = null;
//     _isMuted = false;
//     _hasEmbedError = false;
//     _hasOpenedExternalFallback = false;
//     final videoId = _extractVideoId(widget.videoUrl);
//     if (videoId == null || videoId.isEmpty) {
//       _errorMessage = 'رابط الفيديو القادم من الخادم غير صالح أو غير مدعوم.';
//       return;
//     }

//     _videoId = videoId;

//     _controller = YoutubePlayerController(
//       params: const YoutubePlayerParams(mute: true, showControls: true),
//     );
//     _controller!.loadVideoById(videoId: videoId);
//     _syncMuteState();
//   }

//   String? _extractVideoId(String rawUrlOrId) {
//     final normalizedValue = rawUrlOrId.trim();
//     if (normalizedValue.isEmpty) return null;

//     if (_isValidYoutubeVideoId(normalizedValue)) {
//       return normalizedValue;
//     }

//     final convertedVideoId = YoutubePlayerController.convertUrlToId(
//       normalizedValue,
//     );
//     if (_isValidYoutubeVideoId(convertedVideoId)) {
//       return convertedVideoId;
//     }

//     final parsedUri = Uri.tryParse(normalizedValue);
//     if (parsedUri != null) {
//       final videoIdFromQuery = parsedUri.queryParameters['v'];
//       if (_isValidYoutubeVideoId(videoIdFromQuery)) {
//         return videoIdFromQuery;
//       }

//       final pathSegments = parsedUri.pathSegments
//           .where((segment) => segment.isNotEmpty)
//           .toList();

//       if (parsedUri.host.contains('youtu.be') && pathSegments.isNotEmpty) {
//         final shortVideoId = pathSegments.first;
//         if (_isValidYoutubeVideoId(shortVideoId)) {
//           return shortVideoId;
//         }
//       }

//       if (pathSegments.length >= 2 &&
//           (pathSegments.first == 'embed' ||
//               pathSegments.first == 'shorts' ||
//               pathSegments.first == 'live')) {
//         final embeddedVideoId = pathSegments[1];
//         if (_isValidYoutubeVideoId(embeddedVideoId)) {
//           return embeddedVideoId;
//         }
//       }
//     }

//     return null;
//   }

//   bool _isValidYoutubeVideoId(String? candidateVideoId) {
//     if (candidateVideoId == null) return false;
//     return RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(candidateVideoId);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final controller = _controller;
//     if (controller == null) return;

//     if (state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.hidden ||
//         state == AppLifecycleState.paused) {
//       controller.pauseVideo();
//     }
//   }

//   Future<void> _syncMuteState() async {
//     final controller = _controller;
//     if (controller == null) return;
//     final isMuted = await controller.isMuted;
//     if (!mounted) return;
//     setState(() {
//       _isMuted = isMuted;
//     });
//   }

//   Future<void> _toggleMute() async {
//     final controller = _controller;
//     if (controller == null) return;

//     if (_isMuted) {
//       await controller.unMute();
//     } else {
//       await controller.mute();
//     }

//     if (!mounted) return;
//     setState(() {
//       _isMuted = !_isMuted;
//     });
//   }

//   Future<void> _openInYoutubeApp() async {
//     final videoId = _videoId;
//     if (videoId == null) return;

//     final youtubeUri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
//     final isOpened = await launchUrl(
//       youtubeUri,
//       mode: LaunchMode.externalApplication,
//     );

//     if (!isOpened && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'تعذر فتح الفيديو خارجيًا. تأكد من وجود تطبيق أو متصفح.',
//           ),
//         ),
//       );
//     }
//   }

//   bool _isHardYoutubeError(YoutubeError error) {
//     return error == YoutubeError.invalidParam ||
//         error == YoutubeError.videoNotFound ||
//         error == YoutubeError.cannotFindVideo ||
//         error == YoutubeError.notEmbeddable ||
//         error == YoutubeError.sameAsNotEmbeddable;
//   }

//   String _buildEmbedErrorMessage(YoutubeError error) {
//     switch (error) {
//       case YoutubeError.invalidParam:
//         return 'رابط الفيديو غير مكتمل أو غير صالح للتشغيل داخل التطبيق.';
//       case YoutubeError.videoNotFound:
//       case YoutubeError.cannotFindVideo:
//         return 'هذا الفيديو غير متاح أو تم حذفه.';
//       case YoutubeError.notEmbeddable:
//       case YoutubeError.sameAsNotEmbeddable:
//         return 'مالك الفيديو لا يسمح بتشغيله داخل التطبيقات. يمكنك فتحه على يوتيوب.';
//       case YoutubeError.html5Error:
//         return 'حدثت مشكلة تشغيل من YouTube. جرّب مرة أخرى أو افتح الفيديو على يوتيوب.';
//       case YoutubeError.none:
//       case YoutubeError.unknown:
//         return 'تعذر تشغيل الفيديو داخل التطبيق. يمكنك فتحه على يوتيوب.';
//     }
//   }

//   void _disposeController() {
//     _controller?.close();
//     _controller = null;
//     _videoId = null;
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _disposeController();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = _controller;
//     final videoId = _videoId;

//     if (controller == null) {
//       return _PlayerFrame(
//         child: _PlayerMessage(
//           icon: Icons.error_outline_rounded,
//           message:
//               _errorMessage ??
//               'تعذر تشغيل الفيديو لأن الرابط غير صالح أو غير مدعوم.',
//         ),
//       );
//     }

//     if (_hasEmbedError) {
//       return _PlayerFrame(
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             const _PlayerMessage(
//               icon: Icons.warning_amber_rounded,
//               message:
//                   'هذا الفيديو غير متاح للتشغيل داخل التطبيق. يمكنك فتحه على يوتيوب.',
//             ),
//             if (videoId != null)
//               PositionedDirectional(
//                 top: 12,
//                 end: 12,
//                 child: FilledButton.tonalIcon(
//                   onPressed: _openInYoutubeApp,
//                   style: FilledButton.styleFrom(
//                     backgroundColor: Colors.black.withValues(alpha: 0.60),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   icon: const Icon(Icons.open_in_new_rounded, size: 18),
//                   label: const Text('افتح على يوتيوب'),
//                 ),
//               ),
//           ],
//         ),
//       );
//     }

//     return _PlayerFrame(
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           YoutubePlayerControllerProvider(
//             controller: controller,
//             child: YoutubeValueBuilder(
//               controller: controller,
//               builder: (context, value) {
//                 final isInitializing =
//                     value.playerState == PlayerState.unknown &&
//                     value.metaData.videoId.isEmpty &&
//                     !value.hasError;
//                 return Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     YoutubePlayer(controller: controller),
//                     if (isInitializing) const _PlayerLoadingOverlay(),
//                     if (value.hasError)
//                       Builder(
//                         builder: (context) {
//                           WidgetsBinding.instance.addPostFrameCallback((_) {
//                             if (!mounted || _hasEmbedError) return;
//                             if (_isHardYoutubeError(value.error)) {
//                               setState(() {
//                                 _hasEmbedError = true;
//                               });

//                               if (!_hasOpenedExternalFallback) {
//                                 _hasOpenedExternalFallback = true;
//                                 _openInYoutubeApp();
//                               }
//                             }
//                           });

//                           return _PlayerMessage(
//                             icon: Icons.warning_amber_rounded,
//                             message: _buildEmbedErrorMessage(value.error),
//                           );
//                         },
//                       ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           if (videoId != null)
//             PositionedDirectional(
//               top: 12,
//               end: 12,
//               child: FilledButton.tonalIcon(
//                 onPressed: _openInYoutubeApp,
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.black.withValues(alpha: 0.60),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//                 icon: const Icon(Icons.open_in_new_rounded, size: 18),
//                 label: const Text('افتح على يوتيوب'),
//               ),
//             ),
//           PositionedDirectional(
//             bottom: 12,
//             start: 12,
//             child: FilledButton.tonalIcon(
//               onPressed: _toggleMute,
//               style: FilledButton.styleFrom(
//                 backgroundColor: Colors.black.withValues(alpha: 0.60),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 10,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               icon: Icon(
//                 _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
//               ),
//               label: Text(_isMuted ? 'إلغاء الكتم' : 'كتم الصوت'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PlayerFrame extends StatelessWidget {
//   const _PlayerFrame({required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x55000000),
//             blurRadius: 24,
//             offset: Offset(0, 12),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: ColoredBox(color: Colors.black, child: child),
//       ),
//     );
//   }
// }

// class _PlayerLoadingOverlay extends StatelessWidget {
//   const _PlayerLoadingOverlay();

//   @override
//   Widget build(BuildContext context) {
//     return const ColoredBox(
//       color: Color(0x88000000),
//       child: Center(child: CircularProgressIndicator(color: Colors.white)),
//     );
//   }
// }

// class _PlayerMessage extends StatelessWidget {
//   const _PlayerMessage({required this.icon, required this.message});

//   final IconData icon;
//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: const Color(0xCC000000),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon, color: Colors.white, size: 34),
//               const SizedBox(height: 10),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
