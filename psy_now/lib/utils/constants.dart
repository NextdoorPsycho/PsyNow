/// App constants for PsyNow
class AppConstants {
  AppConstants._();

  // App name
  static const String appName = 'PsyNow';

  // GeForce NOW environment detection
  static const String gfnEnvironmentPath = r'C:\Asgard';

  // Default install directory (will be created on first run)
  static const String defaultInstallDir = r'C:\PsyNow';

  // Config file name
  static const String configFileName = 'PsyNowConfig.ini';

  // Steam server proxy
  static const String steamServerUrl = 'http://127.10.0.231:9753/shutdown';
  static const String steamServerPath =
      r'C:\Program Files (x86)\Steam\lockdown\server\server.exe';
  static const String steamProtocol = 'steam://open/library';

  // Window titles to close
  static const String customExplorerTitle = 'CustomExplorer';
  static const String winXShellTitle = 'WinXShell';

  // Core shortcuts that cannot be removed
  static const List<String> coreShortcuts = [
    'Explorer++.lnk',
  ];

  // Directory names
  static const String shortcutsDir = 'Shortcuts';
  static const String backupShortcutsDir = 'Backup Shortcuts';

  // Bundled apps configuration
  static const List<BundledApp> bundledApps = [
    // File manager
    BundledApp(
      name: '7-Zip',
      assetPath: 'assets/apps/7-Zip.zip',
      exeName: '7zFM.exe',
      isZip: true,
      createShortcut: true,
    ),
    // Web browser
    BundledApp(
      name: 'Brave',
      assetPath: 'assets/apps/Brave.zip',
      exeName: 'brave.exe',
      isZip: true,
      createShortcut: true,
    ),
    // File explorer replacement
    BundledApp(
      name: 'Explorer++',
      assetPath: 'assets/apps/Explorer++.exe',
      exeName: 'Explorer++.exe',
      isZip: false,
      createShortcut: true,
      runAfterInstall: true,
    ),
    // Steam depot downloader
    BundledApp(
      name: 'DepotDownloader',
      assetPath: 'assets/apps/DepotDownloader-windows-x64.zip',
      exeName: 'DepotDownloader.exe',
      isZip: true,
      createShortcut: true,
    ),
    // Text editor
    BundledApp(
      name: 'Notepad++',
      assetPath: 'assets/apps/Notepad++.zip',
      exeName: 'notepad++.exe',
      isZip: true,
      createShortcut: true,
    ),
    // Torrent client
    BundledApp(
      name: 'qBittorrent',
      assetPath: 'assets/apps/qBittorrent.zip',
      exeName: 'qbittorrent.exe',
      isZip: true,
      createShortcut: true,
    ),
    // System monitor
    BundledApp(
      name: 'System Informer',
      assetPath: 'assets/apps/System.Informer.zip',
      exeName: 'SystemInformer.exe',
      isZip: true,
      createShortcut: true,
    ),
    // Epic Games portable launcher
    BundledApp(
      name: 'Epic Games Portable',
      assetPath: 'assets/apps/EpicGames.Portable.zip',
      exeName: 'EpicGamesLauncher.exe',
      isZip: true,
      createShortcut: true,
    ),
    // Epic Games installer for GFN
    BundledApp(
      name: 'Epic Games Installer',
      assetPath: 'assets/apps/EpicGamesInstallerGFN.exe',
      exeName: 'EpicGamesInstallerGFN.exe',
      isZip: false,
      createShortcut: true,
    ),
    // Alt-Tab replacement
    BundledApp(
      name: 'Ctrl+Tab',
      assetPath: 'assets/apps/ctrl_tab.exe',
      exeName: 'ctrl_tab.exe',
      isZip: false,
      createShortcut: false,
      runAfterInstall: true,
    ),
    // Steam Web App
    BundledApp(
      name: 'Steam Web App',
      assetPath: 'assets/apps/SWA.zip',
      exeName: 'SWA.exe',
      isZip: true,
      createShortcut: true,
    ),
  ];

  // Shell environments (separate from apps)
  static const List<BundledApp> shellEnvironments = [
    BundledApp(
      name: 'Seelen UI',
      assetPath: 'assets/apps/seelenui.zip',
      exeName: 'seelen-ui.exe',
      isZip: true,
      createShortcut: false,
      runAfterInstall: true,
    ),
    BundledApp(
      name: 'Seelen UI Config',
      assetPath: 'assets/apps/SeelenUiConfig.zip',
      exeName: '',
      isZip: true,
      createShortcut: false,
    ),
    BundledApp(
      name: 'WinXShell',
      assetPath: 'assets/apps/WinXShell_x64.zip',
      exeName: 'WinXShell.exe',
      isZip: true,
      createShortcut: false,
      runAfterInstall: true,
    ),
    BundledApp(
      name: 'WinXShell Steam',
      assetPath: 'assets/apps/WinXShell_Steam.zip',
      exeName: 'WinXShell.exe',
      isZip: true,
      createShortcut: false,
    ),
    BundledApp(
      name: 'WinXShell Ubisoft',
      assetPath: 'assets/apps/WinXShell_Ubisoft.zip',
      exeName: 'WinXShell.exe',
      isZip: true,
      createShortcut: false,
    ),
  ];
}

/// Configuration for a bundled app
class BundledApp {
  final String name;
  final String assetPath;
  final String exeName;
  final bool isZip;
  final bool createShortcut;
  final bool runAfterInstall;

  const BundledApp({
    required this.name,
    required this.assetPath,
    required this.exeName,
    required this.isZip,
    this.createShortcut = false,
    this.runAfterInstall = false,
  });
}
