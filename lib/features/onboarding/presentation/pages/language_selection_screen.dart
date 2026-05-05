import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../settings/presentation/providers/ui_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguageCode;

  @override
  void initState() {
    super.initState();
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedLanguageCode = localeProvider.locale.languageCode;
  }

  void _onLanguageSelected(String code) {
    setState(() {
      _selectedLanguageCode = code;
    });
  }

  void _continue() {
    if (_selectedLanguageCode != null) {
      final localeProvider = Provider.of<LocaleProvider>(
        context,
        listen: false,
      );
      localeProvider.changeLocale(Locale(_selectedLanguageCode!));

      final uiProvider = Provider.of<UIProvider>(context, listen: false);
      uiProvider.completeLanguageSelection();

      // No need to manually navigate. The UIProvider update will cause main.dart
      // to rebuild and switch 'home' to OnboardingScreen automatically.
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                l10n.selectLanguage,
                style: GoogleFonts.manrope(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                l10n.selectLanguageDesc,
                style: TextStyle(fontSize: 16.sp, color: AppColors.textGrey),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: LocaleProvider.supportedLanguages.length,
                  itemBuilder: (context, index) {
                    final lang = LocaleProvider.supportedLanguages[index];
                    final code = lang['code']!;
                    final nativeName = lang['nativeName']!;
                    final name = lang['name']!;
                    final isSelected = _selectedLanguageCode == code;

                    return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _onLanguageSelected(code),
                            borderRadius: BorderRadius.circular(16.r),
                            child: Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(
                                              alpha: 0.2,
                                            )
                                          : Colors.grey.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getLanguageEmoji(code),
                                        style: TextStyle(fontSize: 24.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nativeName,
                                          style: GoogleFonts.manrope(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isSelected
                                                ? AppColors.primary
                                                : null,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColors.primary,
                                      size: 24.sp,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedLanguageCode != null ? _continue : null,
                  child: Text(l10n.continueButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLanguageEmoji(String code) {
    switch (code) {
      case 'en':
        return '🇬🇧';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'pt':
        return '🇵🇹';
      case 'zh':
        return '🇨🇳';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      case 'ar':
        return '🇸🇦';
      case 'hi':
        return '🇮🇳';
      case 'ur':
        return '🇵🇰';
      default:
        return '🌐';
    }
  }
}
