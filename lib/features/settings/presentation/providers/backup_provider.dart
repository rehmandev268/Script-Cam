import 'package:flutter/material.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/drive_backup_service.dart';
import '../../../../core/services/google_auth_service.dart';
import '../../../../features/scripts/presentation/providers/scripts_provider.dart';
import '../../../../features/gallery/presentation/providers/gallery_provider.dart';
import '../../../../core/services/backup/manifest_handler.dart';
import 'ui_provider.dart';

class BackupProvider extends ChangeNotifier {
  final DriveBackupService _backupService = DriveBackupService();
  final GoogleAuthService authService = GoogleAuthService();

  bool _isAuthLoading = false;
  bool get isAuthLoading => _isAuthLoading;

  bool _isBackupInProgress = false;
  bool get isBackupInProgress => _isBackupInProgress;

  bool _isRestoreInProgress = false;
  bool get isRestoreInProgress => _isRestoreInProgress;

  double _backupProgress = 0.0;
  double get backupProgress => _backupProgress;

  String? _error;
  String? get error => _error;

  Future<void> signIn(UIProvider uiProvider) async {
    _isAuthLoading = true;
    _error = null;
    notifyListeners();
    try {
      final account = await authService.signIn();
      if (account == null) {
        _error = 'signInCancelled';
      } else {
        uiProvider.updateConnectedAccount(
          email: account.email,
          name: account.displayName ?? '',
          photoUrl: account.photoUrl ?? '',
        );
        AnalyticsService().logGoogleSignIn(email: account.email);
      }
    } catch (e) {
      _error = e.toString();
      debugPrint("BackupProvider: Error during signIn: $e");
      AnalyticsService().logGoogleSignInFailed(reason: e.toString());
    } finally {
      _isAuthLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(UIProvider uiProvider) async {
    _isAuthLoading = true;
    notifyListeners();
    try {
      await authService.signOut();
      uiProvider.clearConnectedAccount();
      AnalyticsService().logGoogleSignOut();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isAuthLoading = false;
      notifyListeners();
    }
  }

  Future<void> backupNow(
    ScriptsProvider scriptsProvider,
    GalleryProvider galleryProvider,
    UIProvider uiProvider,
  ) async {
    if (!authService.isSignedIn) return;

    _isBackupInProgress = true;
    _backupProgress = 0.0;
    _error = null;
    notifyListeners();

    final startTime = DateTime.now();
    AnalyticsService().logBackupStarted(
      scriptCount: scriptsProvider.scripts.length,
      videoCount: galleryProvider.videos.length,
    );

    try {
      await _backupService.backup(
        scripts: scriptsProvider.scripts,
        videos: galleryProvider.videos,
        settings: {
          'voiceSyncEnabled': uiProvider.voiceSyncEnabled,
          'mirrorTextEnabled': uiProvider.mirrorTextEnabled,
          'countdownDuration': uiProvider.countdownDuration,
          'autoBackupEnabled': uiProvider.autoBackupEnabled,
          'backupVideosEnabled': uiProvider.backupVideosEnabled,
          'wifiOnlyBackup': uiProvider.wifiOnlyBackup,
          'prompterFontSize': uiProvider.prompterFontSize,
          'prompterOpacity': uiProvider.prompterOpacity,
          'prompterScrollSpeed': uiProvider.prompterScrollSpeed,
          'prompterTextOrientation': uiProvider.prompterTextOrientation,
          'prompterWidth': uiProvider.prompterWidth,
          'prompterHeight': uiProvider.prompterHeight,
          'prompterX': uiProvider.prompterX,
          'prompterY': uiProvider.prompterY,
        },
        onProgress: (progress) {
          _backupProgress = progress;
          notifyListeners();
        },
      );
      uiProvider.updateLastBackupTime(DateTime.now().toIso8601String());
      AnalyticsService().logBackupCompleted(
        scriptCount: scriptsProvider.scripts.length,
        videoCount: galleryProvider.videos.length,
        durationSeconds: DateTime.now().difference(startTime).inSeconds,
      );
    } catch (e) {
      _error = e.toString();
      AnalyticsService().logBackupFailed(reason: e.toString());
    } finally {
      _isBackupInProgress = false;
      notifyListeners();
    }
  }

  Future<void> restoreNow(
    ScriptsProvider scriptsProvider,
    GalleryProvider galleryProvider,
    UIProvider uiProvider,
  ) async {
    if (!authService.isSignedIn) return;

    _isRestoreInProgress = true;
    _error = null;
    notifyListeners();
    AnalyticsService().logRestoreStarted();

    try {
      final manifest = await _backupService.restore();
      if (manifest != null) {
        final restoredScripts = ManifestHandler.getScripts(manifest);
        await scriptsProvider.importScriptsFromRestore(restoredScripts);

        final restoredVideos = ManifestHandler.getVideos(manifest);
        await galleryProvider.importVideosFromRestore(restoredVideos);

        final settings = ManifestHandler.getSettings(manifest);
        uiProvider.applyRestoredBackupSettings(settings);

        uiProvider.updateLastRestoreTime(DateTime.now().toIso8601String());
        AnalyticsService().logRestoreCompleted(
          scriptCount: restoredScripts.length,
          videoCount: restoredVideos.length,
        );
      }
    } catch (e) {
      _error = e.toString();
      AnalyticsService().logRestoreFailed(reason: e.toString());
    } finally {
      _isRestoreInProgress = false;
      notifyListeners();
    }
  }

  Future<void> checkSilentSignIn(
    ScriptsProvider scriptsProvider,
    GalleryProvider galleryProvider,
    UIProvider uiProvider,
  ) async {
    final account = await authService.signInSilently();
    if (account != null) {
      uiProvider.updateConnectedAccount(
        email: account.email,
        name: account.displayName ?? '',
        photoUrl: account.photoUrl ?? '',
      );
      notifyListeners();

      if (uiProvider.autoBackupEnabled) {
        final lastBackupStr = uiProvider.lastBackupTime;
        bool shouldBackup = false;

        if (lastBackupStr.isEmpty) {
          shouldBackup = true;
        } else {
          final lastBackup = DateTime.tryParse(lastBackupStr);
          if (lastBackup != null) {
            final difference = DateTime.now().difference(lastBackup);
            if (difference.inHours >= 24) {
              shouldBackup = true;
            }
          }
        }

        if (shouldBackup) {
          backupNow(scriptsProvider, galleryProvider, uiProvider);
        }
      }
    }
  }
}
