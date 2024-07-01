import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../res/style/dimensions.dart';
import '../../res/style/media_query.dart';

/// This class is used to share global variable and class across the app
class App {
  factory App() => instance;

  App._();

  /// Singleton factory
  static final App instance = App._();

  /// App local logger for printing in in the log
  // static AppLocalLogger logger = AppLocalLogger('App');

  /// Global app style
  /// [appQuery] to get the width and height of the device
  static late AppQuery appQuery;

  /// [appSpacer] to get the global dimension defined in the design system
  static late AppSpacer appSpacer;

  /// [appTextStyle] to get the global text style defined in the design system
  // static late AppTextStyle appTextStyle;

  /// [appCopy] to get all the copy for the app
  // static AppCopy appCopy = AppCopy();

  /// [appNavigator] to navigate between page in the app
  // static final AppNavigator appNavigator = AppNavigator();

  static bool _resourcesReady = false;

  static BuildContext? rootBuildContext;

  // List<MoodModel> allMoodList = [];

  // AppLifecycleHandler? appLifecycleHandler;
  // ShakeDetector? _shakeDetector;

  /// Init global app style that can be used across the app
  static void initGlobalResources(BuildContext context) {
    if (_resourcesReady) {
      return;
    }

    appQuery = AppQuery()..init(context);
    appSpacer = AppSpacer(context: context);
    // appTextStyle = AppTextStyle();

    _resourcesReady = true;
  }

  void init() {
    // appLifecycleHandler ??= AppLifecycleHandler(
    //   resumeCallBack: () => _onAppResume(),
    //   pausedCallBack: () => _onAppPaused(),
    // );

    // _enableShakeDetector();
  }

  // void dispose() {
  //   _shakeDetector?.stopListening();
  // }

  // void _enableShakeDetector() {
  //   _shakeDetector = ShakeDetector.autoStart(
  //     onPhoneShake: launchBugTracker,
  //     minimumShakeCount: 5,
  //   );
  // }

  // void launchBugTracker() {
  //   if (appNavigator.stack.last.routeData.path.ignoreCaseIgnoreSpace(
  //       appNavigator.appRoutesMap.match(LocalBugTrackerRoute())?.path ?? '')) {
  //     return;
  //   } else {
  //     showCupertinoModalPopup<String>(
  //       context: appNavigator.currentContext,
  //       builder: (BuildContext context) => CupertinoActionSheet(
  //         title: AppText.sectionHeader(
  //           'Bug Tracker',
  //           textAlign: TextAlign.center,
  //         ),
  //         message: AppText.caption(
  //           'Which bug tracker do you want to open?',
  //           textAlign: TextAlign.center,
  //         ),
  //         actions: <Widget>[
  //           CupertinoActionSheetAction(
  //             child: const Text('Global Bug Tracker'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               appNavigator.push(LocalBugTrackerRoute());
  //             },
  //           ),
  //           CupertinoActionSheetAction(
  //             child: const Text('Audio Player Bug Tracker'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               appNavigator
  //                   .push(LocalBugTrackerRoute(audioPayerBugTracker: true));
  //             },
  //           ),
  //         ],
  //         cancelButton: CupertinoActionSheetAction(
  //           isDefaultAction: true,
  //           onPressed: () => Navigator.pop(context, null),
  //           child: const Text('Cancel'),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // static void setStatusBarColor({bool white = true}) {
  //   if (white) {
  //     SystemChrome.setSystemUIOverlayStyle(kStatusBarWhite);
  //   } else {
  //     SystemChrome.setSystemUIOverlayStyle(kStatusBarBlack);
  //   }
  // }

  // Future<void> _onAppResume() async {
  //   _shakeDetector?.startListening();
  // }
  //
  // Future<void> _onAppPaused() async {
  //   _shakeDetector?.stopListening();
  // }
}
