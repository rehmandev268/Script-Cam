import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/services/ads_service/interstitial_ad_helper.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/constants/app_constants.dart';
import 'core/services/ads_service/ad_state.dart';
import 'core/services/ads_service/app_open_ad_manager.dart';
import 'core/services/gdpr_service.dart';
import 'core/utils/responsive_config.dart';
import 'core/theme/theme_provider.dart';

import 'features/scripts/data/models/script_model.dart';
import 'features/gallery/data/models/video_model.dart';
import 'features/scripts/presentation/providers/scripts_provider.dart';
import 'features/gallery/presentation/providers/gallery_provider.dart';
import 'features/premium/presentation/providers/premium_provider.dart';
import 'features/settings/presentation/providers/ui_provider.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'features/navigation/presentation/pages/root_navigation_screen.dart';
import 'widgets/common/app_lifecycle_reactor.dart';
import 'core/services/voice_sync_service.dart';
import 'core/services/analytics_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([Hive.initFlutter(), MobileAds.instance.initialize()]);

  Hive.registerAdapter(ScriptAdapter());
  Hive.registerAdapter(VideoAdapter());

  final boxes = await Future.wait([
    Hive.openBox<Script>(HiveKeys.scriptsBox),
    Hive.openBox<VideoRecord>(HiveKeys.videosBox),
    Hive.openBox(HiveKeys.settingsBox),
  ]);

  final scriptBox = boxes[0] as Box<Script>;
  final videoBox = boxes[1] as Box<VideoRecord>;
  final settingsBox = boxes[2];

  binding.addPostFrameCallback((_) async {
    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['80C589E82E84A18078D863AD0C946288']),
    );
    final canRequestAds = await GDPRService().initializeConsent();
    AdState.canRequestAds = canRequestAds;

    InterstitialAdHelper.load();

    AnalyticsService().logAppOpen();
  });

  final premiumProvider = PremiumProvider();
  final uiProvider = UIProvider(settingsBox);
  final appOpenAdManager = AppOpenAdManager()..loadAd();

  WidgetsBinding.instance.addObserver(
    AppLifecycleReactor(
      appOpenAdManager: appOpenAdManager,
      premiumProvider: premiumProvider,
      uiProvider: uiProvider,
    ),
  );

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
        ChangeNotifierProvider(create: (_) => ThemeProvider(settingsBox)),
        ChangeNotifierProvider(create: (_) => ScriptsProvider(scriptBox)),
        ChangeNotifierProvider(create: (_) => GalleryProvider(videoBox)),
        ChangeNotifierProvider.value(value: premiumProvider),
        ChangeNotifierProvider.value(value: uiProvider),
        ChangeNotifierProvider(create: (_) => VoiceSyncService()),
      ],
      child: const CinePromptApp(),
    ),
  );
}

class CinePromptApp extends StatelessWidget {
  const CinePromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          navigatorObservers: [AnalyticsService().observer],
          title: 'ScriptCam',
          debugShowCheckedModeBanner: false,
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
              fillColor: AppColors.borderLight.withOpacity(0.3),
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

            return FrozenLayoutFix(child: child ?? const SizedBox());
          },

          home: Consumer<UIProvider>(
            builder: (context, uiProvider, _) {
              // Only redirect to onboarding for first-time users
              if (uiProvider.showOnboarding) {
                return const OnboardingScreen();
              }
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
