# PsyNow

GeForce NOW environment customization suite - a Flutter rewrite of [SalsaNOW](https://github.com/dpadGuy/SalsaNOW).

## What is PsyNow?

PsyNow transforms your GeForce NOW cloud gaming sessions by providing:

- **Portable Applications** - Browser, file manager, text editor, and more
- **Custom Shell Environments** - Replace the default GFN desktop with Seelen UI or WinXShell
- **Full Steam Library** - Bypass NVIDIA's Steam proxy to access your complete game library
- **Persistent Shortcuts** - Keep your desktop organized across sessions

All applications are bundled directly into the executable - no internet downloads required during setup.

## Quick Start

1. Download the latest release
2. Run `psy_now.exe` on GeForce NOW
3. Click "Run Setup"
4. Your apps are installed to `C:\PsyNow`

## Repository Structure

```
PsyNow/
├── psy_now/              # Flutter application source
│   ├── lib/              # Dart source code
│   ├── assets/apps/      # Bundled application archives
│   └── README.md         # Detailed technical documentation
├── SalsaNOW/             # Original C# application (reference)
└── README.md             # This file
```

## Bundled Software

### Applications
| App | Purpose |
|-----|---------|
| 7-Zip | Archive management |
| Brave | Web browsing |
| Explorer++ | File exploration |
| Notepad++ | Text editing |
| qBittorrent | Torrent downloads |
| System Informer | Process monitoring |
| DepotDownloader | Steam game downloads |
| Epic Games | Epic store access |
| Steam Web App | Steam store interface |
| Ctrl+Tab | Window switching |

### Shell Environments
| Shell | Style |
|-------|-------|
| Seelen UI | Modern, minimal |
| WinXShell | Classic taskbar |

## How It Works

1. **Environment Detection** - Checks for `C:\Asgard` (GFN marker)
2. **Steam Proxy Shutdown** - POSTs to `127.10.0.231:9753/shutdown` to unlock full library
3. **App Extraction** - Unpacks bundled ZIPs/EXEs from Flutter assets to `C:\PsyNow`
4. **Shortcut Creation** - Places shortcuts on desktop
5. **Shell Launch** - Optionally starts Seelen UI or WinXShell
6. **Background Services** - Closes unwanted windows, syncs shortcuts

## Building from Source

```bash
cd psy_now
flutter pub get
flutter build windows --release
```

Executable output: `psy_now/build/windows/x64/runner/Release/psy_now.exe`

## Adding New Applications

1. Place the archive in `psy_now/assets/apps/`
2. Add entry to `lib/utils/constants.dart`:

```dart
BundledApp(
  name: 'App Name',
  assetPath: 'assets/apps/AppName.zip',
  exeName: 'app.exe',
  isZip: true,
  createShortcut: true,
),
```

3. Rebuild the application

## Credits

- Original [SalsaNOW](https://github.com/dpadGuy/SalsaNOW) by dpadGuy
- [SalsaNOWThings](https://github.com/dpadGuy/SalsaNOWThings) application packages
- Built with [Arcane UI Framework](https://github.com/ArcaneArts/arcane)

## License

MIT
