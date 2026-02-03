import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:flutter_application_6/core/services/ads_service/rewarded_ad_helper.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_application_6/firebase_options.dart';
import 'dart:ui';

import 'package:flutter_application_6/core/constants/app_constants.dart';
import 'package:flutter_application_6/core/services/ads_service/ad_state.dart';
import 'package:flutter_application_6/core/services/gdpr_service.dart';
import 'package:flutter_application_6/core/utils/responsive_config.dart';
import 'package:flutter_application_6/core/theme/theme_provider.dart';
import 'package:flutter_application_6/core/providers/locale_provider.dart';

import 'package:flutter_application_6/features/scripts/data/models/script_model.dart';
import 'package:flutter_application_6/features/gallery/data/models/video_model.dart';
import 'package:flutter_application_6/features/scripts/presentation/providers/scripts_provider.dart';
import 'package:flutter_application_6/features/gallery/presentation/providers/gallery_provider.dart';
import 'package:flutter_application_6/features/premium/presentation/providers/premium_provider.dart';
import 'package:flutter_application_6/features/settings/presentation/providers/ui_provider.dart';
import 'package:flutter_application_6/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter_application_6/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:flutter_application_6/features/navigation/presentation/pages/root_navigation_screen.dart';
import 'package:flutter_application_6/widgets/common/no_internet_screen.dart';
import 'package:flutter_application_6/core/services/connectivity_service.dart';
import 'package:flutter_application_6/core/services/voice_sync_service.dart';
import 'package:flutter_application_6/core/services/analytics_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Future.wait([Hive.initFlutter(), MobileAds.instance.initialize()]);

  Hive.registerAdapter(ScriptAdapter());
  Hive.registerAdapter(VideoAdapter());

  late Box<Script> scriptBox;
  late Box<VideoRecord> videoBox;
  late Box settingsBox;

  try {
    final boxes = await Future.wait([
      Hive.openBox<Script>(HiveKeys.scriptsBox),
      Hive.openBox<VideoRecord>(HiveKeys.videosBox),
      Hive.openBox(HiveKeys.settingsBox),
    ]);
    scriptBox = boxes[0] as Box<Script>;
    videoBox = boxes[1] as Box<VideoRecord>;
    settingsBox = boxes[2];
  } catch (e) {
    debugPrint("Hive initialization failed: $e");
    
    await Hive.deleteBoxFromDisk(HiveKeys.scriptsBox);
    await Hive.deleteBoxFromDisk(HiveKeys.videosBox);
    await Hive.deleteBoxFromDisk(HiveKeys.settingsBox);

    final boxes = await Future.wait([
      Hive.openBox<Script>(HiveKeys.scriptsBox),
      Hive.openBox<VideoRecord>(HiveKeys.videosBox),
      Hive.openBox(HiveKeys.settingsBox),
    ]);
    scriptBox = boxes[0] as Box<Script>;
    videoBox = boxes[1] as Box<VideoRecord>;
    settingsBox = boxes[2];
  }

  binding.addPostFrameCallback((_) async {
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['80C589E82E84A18078D863AD0C946288']),
    );
    final canRequestAds = await GDPRService().initializeConsent();
    AdState.canRequestAds = canRequestAds;
    RewardedAdHelper.load();
    AnalyticsService().logAppOpen();
  });

  final premiumProvider = PremiumProvider();
  final uiProvider = UIProvider(settingsBox);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(settingsBox)),
        ChangeNotifierProvider(create: (_) => ScriptsProvider(scriptBox)),
        ChangeNotifierProvider(create: (_) => GalleryProvider(videoBox)),
        ChangeNotifierProvider.value(value: premiumProvider),
        ChangeNotifierProvider.value(value: uiProvider),
        ChangeNotifierProvider(create: (_) => VoiceSyncService()),
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
      ],
      child: const CinePromptApp(),
    ),
  );
}

class CinePromptApp extends StatelessWidget {
  const CinePromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          navigatorObservers: [AnalyticsService().observer],
          title: 'ScriptCam',
          debugShowCheckedModeBanner: false,

          locale: localeProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          themeMode: themeProvider.themeMode,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColors.lightBg,
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.lightSurface,
              error: AppColors.error,
              onPrimary: Colors.white,
            ),
            textTheme: GoogleFonts.manropeTextTheme(ThemeData.light().textTheme)
                .apply(
                  bodyColor: AppColors.textBlack,
                  displayColor: AppColors.textBlack,
                ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              iconTheme: const IconThemeData(color: AppColors.textBlack),
              titleTextStyle: GoogleFonts.manrope(
                color: AppColors.textBlack,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            cardTheme: CardThemeData(
              color: AppColors.lightCard,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: const BorderSide(color: AppColors.borderLight, width: 1),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: Size(120.w, 54.h),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textStyle: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.borderLight.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.all(20.r),
              hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.darkBg,
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.darkSurface,
              error: AppColors.error,
              onPrimary: Colors.white,
            ),
            textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme)
                .apply(
                  bodyColor: AppColors.textWhite,
                  displayColor: AppColors.textWhite,
                ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              iconTheme: const IconThemeData(color: AppColors.textWhite),
              titleTextStyle: GoogleFonts.manrope(
                color: AppColors.textWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            cardTheme: CardThemeData(
              color: AppColors.darkCard,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: const BorderSide(color: AppColors.borderDark, width: 1),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: Size(120.w, 54.h),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textStyle: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.darkSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.all(20.r),
              hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
            ),
          ),

          builder: (context, child) {
            ResponsiveLayout.init(context);

            return Consumer<ConnectivityService>(
              builder: (context, connectivity, _) {
                if (!connectivity.isConnected) {
                  return const NoInternetScreen();
                }
                return FrozenLayoutFix(child: child ?? const SizedBox());
              },
            );
          },

          home: Consumer<UIProvider>(
            builder: (context, uiProvider, _) {
              // First-time users: show language selection
              if (!uiProvider.languageSelected) {
                return const LanguageSelectionScreen();
              }
              // Then show onboarding if not completed
              if (uiProvider.showOnboarding) {
                return const OnboardingScreen();
              }
              // Finally show main app
              return const RootNavigationScreen();
            },
          ),
        );
      },
    );
  }
}

class FrozenLayoutFix extends StatefulWidget {
  final Widget child;

  const FrozenLayoutFix({super.key, required this.child});

  @override
  State<FrozenLayoutFix> createState() => _FrozenLayoutFixState();
}

class _FrozenLayoutFixState extends State<FrozenLayoutFix> {
  double? _frozenTopPadding;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    if (_frozenTopPadding == null && mediaQuery.viewPadding.top > 0) {
      _frozenTopPadding = mediaQuery.viewPadding.top;
    }
    if (_frozenTopPadding != null && _frozenTopPadding! > 0) {
      mediaQuery = mediaQuery.copyWith(
        padding: mediaQuery.padding.copyWith(top: _frozenTopPadding),
        viewPadding: mediaQuery.viewPadding.copyWith(top: _frozenTopPadding),
      );
    }

    return MediaQuery(data: mediaQuery, child: widget.child);
  }
}
