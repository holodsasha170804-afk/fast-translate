<div align="center">
  <img src="icons/fast-translate-icon.svg" width="80" alt="Fast Translate icon">

  <h1>Fast Translate</h1>

  <p><strong>Translate without switching context.</strong></p>
  <p>Instant translation, built into your GNOME desktop.</p>

  <a href="#installation"><img src="https://img.shields.io/badge/GNOME-45--50-3584e4?style=flat-square" alt="GNOME 45–50"></a>
  <a href="#translation-services"><img src="https://img.shields.io/badge/Google_Translate_%26_DeepL-3584e4?style=flat-square" alt="Google Translate and DeepL"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-3584e4?style=flat-square" alt="MIT License"></a>

  <p>
    <a href="#features">Features</a> ·
    <a href="#installation">Installation</a> ·
    <a href="#usage">Usage</a> ·
    <a href="#configuration">Configuration</a> ·
    <a href="#development">Development</a>
  </p>
</div>

<p align="center">
  <img src="screenshots/fast-translate-banner-animated-slow.gif" width="100%" alt="Fast Translate for GNOME — Translate in place">
</p>

Fast Translate is a GNOME Shell extension that brings Google Translate and DeepL directly to your desktop. Translate selected text in any application, use the top-bar translator, or send translations straight to your clipboard — without opening a browser or switching windows.

## Quick Translate

Select text, press <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>E</kbd>, and get the translation.

Choose between two modes:

| Floating window | Background mode |
| :--- | :--- |
| View the translation in a compact popup without stealing focus or dimming the screen. | Translate silently, copy the result to your clipboard, and paste it wherever you need it. Optional completion notification. |

## Features

| | |
| :--- | :--- |
| **Quick Translate** — System-wide translation with a configurable keyboard shortcut. | **Native GNOME interface** — Translate directly from the top-bar popup. |
| **Background translation** — Clipboard-to-clipboard translation without interruptions. | **Inline language selection** — Change source and target languages without opening preferences. |
| **Read aloud** — Listen to the original text or the translation. | **Multiple providers** — Choose between Google Translate and DeepL Free or Pro. |
| **Clipboard automation** — Optional auto-paste, auto-translate and auto-copy. | **Desktop integration** — Dark/light panel icons, high-DPI scaling and optional notifications. |

## Installation

### Requirements

- GNOME Shell 45–50
- Internet connection for translation and speech
- DeepL API key (optional, only required when using DeepL)
- For read aloud: `gst-play-1.0` (commonly provided by `gstreamer1.0-plugins-base-apps`) and GStreamer MP3/audio output plugins

### Install from source

On a supported GNOME desktop with Git, Node.js/npm, GNOME extension tools, GLib schema tools, gettext and Python 3 with venv support:

```bash
git clone https://github.com/holodsasha170804-afk/fast-translate.git
cd fast-translate
npm run deploy
```

Enable Fast Translate in the GNOME Extensions app if necessary. If schema changes are not visible or the extension does not reload correctly, log out and back in.

> [!NOTE]
> The [GNOME Extensions listing](https://extensions.gnome.org/extension/5124/translate-assistant/) belongs to the upstream project. Use the source installation above for this fork; the listing is not a confirmed distribution channel for this version.

## Usage

### Top-bar translator

Click the Fast Translate icon in the GNOME top bar. Type or paste text with <kbd>Ctrl</kbd> + <kbd>V</kbd>, choose the source and target languages, and click **Translate**.

<p align="center">
  <img src="screenshots/main.webp" width="340" alt="Fast Translate top-bar popup">
</p>

Enable **Auto Paste** and **Auto Translate** to translate copied text automatically when opening the popup. **Auto Copy** copies the translated result to your clipboard.

### Keyboard shortcut

1. Select text in an application.
2. Press <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>E</kbd>.
3. Read the translation in the floating window or paste the result with <kbd>Ctrl</kbd> + <kbd>V</kbd> in background mode.

The extension sends a single virtual Ctrl+C to the active application and translates the resulting clipboard text. The shortcut can be changed or cleared in preferences.

### Read aloud

Click the speaker icon in either text block to hear the original text or translation. Click again to stop, or click the other speaker to switch playback.

Speech is available for nonempty text up to 500 Unicode characters. Longer text is neither truncated nor sent for speech. Temporary audio is removed when playback finishes or stops.

## Configuration

Open the Fast Translate preferences in the GNOME Extensions app to customize your workflow.

| Setting | Description |
| :--- | :--- |
| Translation service | Google Translate or DeepL (Free / Pro) |
| DeepL API | API key and endpoint; hidden when Google Translate is active |
| Languages | Default source and target languages |
| Quick Translate | Configurable shortcut; defaults to Ctrl+Alt+E |
| Clipboard | Auto-paste, auto-translate and auto-copy |
| Background mode | Silent clipboard translation and optional completion notification |
| Appearance | Dark/light panel icons and notifications |

### Translation services

| | Google Translate | DeepL |
| :--- | :--- | :--- |
| API key | Not required | Required |
| Setup | Ready by default | [Obtain an API key](https://www.deepl.com/pro-api) |
| Availability | Unofficial free endpoint; subject to network-based rate limits | Free or Pro API plan |

> [!TIP]
> If Google Translate returns HTTP 429, retry later or switch to DeepL with your own API key.

### Privacy and network access

Translation requests send text to the selected online provider. The extension reads the clipboard when Quick Translate, Paste, Ctrl+V in its input, or enabled Auto Paste requires it. Results are copied back when requested or when clipboard automation is enabled.

Read aloud uses the unofficial Google Translate online speech service, even when DeepL handles translation. Clicking a speaker sends the selected text to Google; automatic language detection may also send text to Google. Service availability and supported languages may change.

## Development

Run the following commands from the project directory:

```bash
npm run build             # Build the extension package
npm run apply             # Install the existing package and reload
npm run deploy            # Build, install and reload
npm test                  # Fast test suite
npm run test:integration  # Nested GNOME Shell integration tests
```

Use the provided scripts instead of running `gnome-extensions pack` or `gnome-extensions install` directly inside the repository. The scripts isolate packaging and installation in temporary directories. `npm run apply` checks that the package is up to date before installing it.

For troubleshooting:

```bash
journalctl -f -o cat /usr/bin/gnome-shell
```

See [AGENTS.md](AGENTS.md) for development and testing conventions.

## Contributing

Bug reports, suggestions and pull requests are welcome. Open an [issue](https://github.com/holodsasha170804-afk/fast-translate/issues) or create a focused branch, test your changes, and submit a pull request.

## Credits

Fast Translate builds on [Translate Assistant by Lorenzo Carbonell Cerezo (atareao)](https://github.com/atareao/translate-assistant) and the [Fast Translate fork by tazztone](https://github.com/tazztone/translate-assistant). Improvements across the forks include Google Translate support, configurable Quick Translate, background translation, inline language selection, high-DPI scaling and integration tests.

Thanks to the original contributors: [Philipp Kiemle](https://github.com/daPhipz), [Fabrício Müller](https://github.com/fabricio8800), [Heimen Stoffels](https://github.com/Vistaus), [Lorenzo Carbonell](https://github.com/atareao), and everyone who has contributed to the project.

[Support tazztone's upstream work](https://buymeacoffee.com/tazztone).

## License

[MIT](LICENSE) — © Lorenzo Carbonell Cerezo (atareao) and contributors.
