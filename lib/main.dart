import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_constants.dart';
import 'core/utils/responsive_config.dart';
import 'core/utils/toast_service.dart';
import 'core/services/ad_manager.dart';
import 'core/theme/theme_provider.dart';

import 'features/scripts/data/models/script_model.dart';
import 'features/gallery/data/models/video_model.dart';
import 'features/scripts/presentation/providers/scripts_provider.dart';
import 'features/gallery/presentation/providers/gallery_provider.dart';
import 'features/premium/presentation/providers/premium_provider.dart';
import 'features/settings/presentation/providers/ui_provider.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'features/navigation/presentation/pages/root_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ScriptAdapter());
  Hive.registerAdapter(VideoAdapter());

  final scriptBox = await Hive.openBox<Script>(HiveKeys.scriptsBox);
  final videoBox = await Hive.openBox<VideoRecord>(HiveKeys.videosBox);
  final settingsBox = await Hive.openBox(HiveKeys.settingsBox);

  await MobileAds.instance.initialize();
  AdHelper.loadInterstitialAd();
  ShowcaseView.register();

  final premiumProvider = PremiumProvider();
  final appOpenAdManager = AppOpenAdManager()..loadAd();

  WidgetsBinding.instance.addObserver(
    AppLifecycleReactor(
      appOpenAdManager: appOpenAdManager,
      provider: premiumProvider,
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
        ChangeNotifierProvider(create: (_) => UIProvider(settingsBox)),
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
          navigatorKey: ToastService.navigatorKey,
          title: 'ScriptFlow',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,

          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColors.lightBg,
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.lightSurface,
            ),
            textTheme: GoogleFonts.manropeTextTheme(
              ThemeData.light().textTheme,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.lightBg,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.textBlack),
              titleTextStyle: TextStyle(
                color: AppColors.textBlack,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.darkBg,
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.darkSurface,
            ),
            textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.darkBg,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.textWhite),
              titleTextStyle: TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          home: Builder(
            builder: (context) {
              // Initialize Responsive Layout with Context
              ResponsiveLayout.init(context);
              return Consumer<UIProvider>(
                builder: (context, uiProvider, _) {
                  return uiProvider.showOnboarding
                      ? const OnboardingScreen()
                      : const RootNavigationScreen();
                },
              );
            },
          ),
        );
      },
    );
  }
}
