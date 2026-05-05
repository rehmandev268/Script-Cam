import 'package:flutter/material.dart';
import 'package:flutter_application_6/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/responsive_config.dart';
import '../../../../widgets/common/adaptive_app_bar.dart';
import '../providers/premium_provider.dart';
import 'purchase_success_screen.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isRestoring = false;
  bool _selectedLifetime = false;

  String _weeklySubtitle(PremiumProvider provider, AppLocalizations l10n) {
    final weeklyPrice = provider.weeklyProduct?.price;
    if (weeklyPrice != null && weeklyPrice.isNotEmpty) {
      return l10n.weeklyTrialThenPrice(weeklyPrice);
    }
    return l10n.weeklyTrialStorePrice;
  }

  @override
  void initState() {
    super.initState();
    AnalyticsService().logPremiumScreenViewed();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<PremiumProvider>().refreshProducts();
    });
  }

  String? _lifetimeOriginalPrice(PremiumProvider provider) {
    // Google Play Billing provides the current sell price.
    // We do not hardcode or infer an "original" price.
    return null;
  }

  String _lifetimeDiscountLabel() {
    return "20% OFF";
  }

  Future<void> _restore(PremiumProvider provider) async {
    setState(() => _isRestoring = true);
    await provider.restorePurchases();
    if (mounted) setState(() => _isRestoring = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Consumer<PremiumProvider>(
      builder: (context, provider, _) {
        if (provider.isPremium) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PurchaseSuccessScreen()),
              );
            }
          });
        }
        final selectedProduct = _selectedLifetime
            ? provider.lifetimeProduct
            : provider.weeklyProduct;

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
          appBar: AdaptiveAppBar(
            title: l10n.premium,
            showBackButton: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.unlockCreatorPro,
                        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        l10n.premiumDescription,
                        style: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
                      ),
                      if (provider.productsLoaded &&
                          provider.weeklyProduct == null &&
                          provider.lifetimeProduct == null)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            l10n.storePricingUnavailable,
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: ListView(
                      children: [
                        _planTile(
                          title: l10n.weeklyPlan,
                          subtitle: _weeklySubtitle(provider, l10n),
                          price: provider.weeklyProduct?.price ?? '',
                          isSelected: !_selectedLifetime,
                          onTap: () => setState(() => _selectedLifetime = false),
                        ),
                        SizedBox(height: 10.h),
                        _planTile(
                          title: l10n.lifetimePlan,
                          subtitle: l10n.lifetimeOneTimeUnlock,
                          badge: "20% OFF",
                          price: provider.lifetimeProduct?.price ?? '',
                          originalPrice: _lifetimeOriginalPrice(provider) ?? '',
                          marketingLine: _lifetimeDiscountLabel(),
                          isSelected: _selectedLifetime,
                          onTap: () => setState(() => _selectedLifetime = true),
                        ),
                        SizedBox(height: 10.h),
                        _feature(l10n.unlimitedRecordings),
                        _feature(l10n.removeAds),
                        _feature(l10n.unlimitedScripts),
                        _feature(l10n.voiceSync),
                        _feature(l10n.remoteControl),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isPurchasing ||
                            _isRestoring ||
                            selectedProduct == null
                        ? null
                        : () => provider.buyPremium(
                            isLifetimePlan: _selectedLifetime,
                          ),
                    child: provider.isPurchasing
                        ? SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            _selectedLifetime
                                ? l10n.upgradeForLifetime
                                : l10n.startFreeTrial,
                          ),
                  ),
                ),
                TextButton(
                  onPressed: provider.isPurchasing || _isRestoring
                      ? null
                      : () => _restore(provider),
                  child: _isRestoring
                      ? SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: const CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.restorePurchaseLink),
                ),
                Text(
                  _selectedLifetime
                      ? l10n.lifetimeNoRecurringBilling
                      : l10n.freeTrialCancelAnytime,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                    height: 1.4,
                  ),
                ),
                if (selectedProduct == null)
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      _selectedLifetime
                          ? l10n.lifetimePriceNotLoaded
                          : l10n.weeklyPriceNotLoaded,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _feature(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }

  Widget _planTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    String price = '',
    String originalPrice = '',
    String? marketingLine,
    String? badge,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.borderDark.withValues(alpha: 0.6),
              width: isSelected ? 2 : 1,
            ),
            color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        if (badge != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              badge,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                    ),
                    if (marketingLine != null && marketingLine.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        marketingLine,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (price.isNotEmpty || originalPrice.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (originalPrice.isNotEmpty)
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (price.isNotEmpty)
                        Text(
                          price,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected ? AppColors.primary : null,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
