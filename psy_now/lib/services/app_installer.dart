import 'dart:io';

import 'package:archive/archive.dart';
import 'package:fast_log/fast_log.dart';
import 'package:flutter/services.dart';
import 'package:psy_now/services/config_service.dart';
import 'package:psy_now/services/environment_service.dart';
import 'package:psy_now/services/shortcut_service.dart';
import 'package:psy_now/utils/constants.dart';

/// Service for installing bundled applications from local assets
class AppInstaller {
  final String globalDirectory;
  final ConfigService config;
  final void Function(String message)? onLog;
  final void Function(String appName, double progress)? onProgress;

  AppInstaller({
    required this.globalDirectory,
    required this.config,
    this.onLog,
    this.onProgress,
  });

  /// Install all bundled apps
  Future<void> installAll() async {
    for (final app in AppConstants.bundledApps) {
      await installApp(app);
    }

    // Mark shortcuts as created if this was the first run
    if (!config.skipShortcutsCreation) {
      await config.setSkipShortcutsCreation(true);
    }
  }

  /// Install a single bundled app
  Future<bool> installApp(BundledApp app) async {
    final desktopPath = EnvironmentService.getDesktopPath();
    final shortcutPath = '$desktopPath${Platform.pathSeparator}${app.name}.lnk';

    String appDir;
    String exePath;

    if (app.isZip) {
      appDir = '$globalDirectory${Platform.pathSeparator}${app.name}';
      exePath = '$appDir${Platform.pathSeparator}${app.exeName}';
    } else {
      appDir = globalDirectory;
      exePath = '$globalDirectory${Platform.pathSeparator}${app.exeName}';
    }

    try {
      // Check if already installed
      if (app.isZip) {
        final dirExists = await Directory(appDir).exists();
        if (dirExists) {
          onLog?.call('[!] ${app.name} already exists');
          _maybeCreateShortcut(shortcutPath, exePath);
          _maybeRunApp(app, exePath);
          return true;
        }
      } else {
        final fileExists = await File(exePath).exists();
        if (fileExists) {
          onLog?.call('[!] ${app.name} already exists');
          _maybeCreateShortcut(shortcutPath, exePath);
          _maybeRunApp(app, exePath);
          return true;
        }
      }

      onLog?.call('[+] Installing ${app.name}...');
      onProgress?.call(app.name, 0.0);

      // Load asset from bundle
      final ByteData assetData;
      try {
        assetData = await rootBundle.load(app.assetPath);
      } catch (e) {
        error('[AppInstaller] Asset not found: ${app.assetPath}');
        onLog?.call('[!] Asset not found: ${app.assetPath}');
        return false;
      }

      final bytes = assetData.buffer.asUint8List();
      onProgress?.call(app.name, 0.5);

      if (app.isZip) {
        // Extract ZIP archive
        await _extractZip(bytes, appDir, app.name);
      } else {
        // Copy single executable
        final file = File(exePath);
        await file.writeAsBytes(bytes);
      }

      onProgress?.call(app.name, 1.0);
      onLog?.call('[+] Installed ${app.name}');

      _maybeCreateShortcut(shortcutPath, exePath);
      _maybeRunApp(app, exePath);

      return true;
    } catch (e) {
      error('[AppInstaller] Error installing ${app.name}: $e');
      onLog?.call('[!] Error installing ${app.name}: $e');
      return false;
    }
  }

  Future<void> _extractZip(List<int> bytes, String destDir, String appName) async {
    final archive = ZipDecoder().decodeBytes(bytes);

    await Directory(destDir).create(recursive: true);

    int processed = 0;
    final total = archive.length;

    for (final file in archive) {
      final filePath = '$destDir${Platform.pathSeparator}${file.name}';

      if (file.isFile) {
        final outFile = File(filePath);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      } else {
        await Directory(filePath).create(recursive: true);
      }

      processed++;
      onProgress?.call(appName, 0.5 + (0.5 * processed / total));
    }
  }

  void _maybeCreateShortcut(String shortcutPath, String targetPath) {
    if (!config.skipShortcutsCreation) {
      ShortcutService.createShortcut(shortcutPath, targetPath);
    }
  }

  void _maybeRunApp(BundledApp app, String exePath) {
    if (app.runAfterInstall) {
      info('[AppInstaller] Starting ${app.name}');
      Process.start(exePath, [], mode: ProcessStartMode.detached);
    }
  }
}
