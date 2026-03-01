
# 🎨 Prisma QR — Scan • Generate • Share

<p align="center">
    <img src="assets/branding/branding.png" width="640" />
</p>

**Prisma QR** is a modern **Flutter-based QR code application** for seamless scanning and generation. Built with GetX for reactive state management and designed with a beautiful dark/light theme system.

Think of it as your all-in-one QR companion with history tracking and smart format detection.

![GitHub stars](https://img.shields.io/github/stars/jydv402/prisma_qr?style=social)
![GitHub forks](https://img.shields.io/github/forks/jydv402/prisma_qr?style=social)
![License](https://img.shields.io/github/license/jydv402/prisma_qr?cacheBust=2)
![Platform](https://img.shields.io/badge/platform-flutter-blue)

---

## ✨ Features

- 📷 **Scan QR Codes** — Lightning-fast QR code scanning using device camera with real-time detection
- ✨ **Generate QR Codes** — Create custom QR codes for URLs, Wi-Fi credentials, contacts, and plain text
- 🧠 **Smart Format Detection** — Automatically recognizes URL, Wi-Fi, Contact (vCard), and Text formats
- 📜 **History Management** — Complete history of all scanned and generated QR codes with timestamps
- 🌗 **Dark/Light Themes** — Beautiful theme system with automatic dark mode support
- 📳 **Haptic Feedback** — Optional vibration and sound feedback on successful scans
- 📋 **Auto-Copy** — Automatically copy scanned content to clipboard
- 📤 **Share & Export** — Share QR codes as images or text with other apps
- ✏️ **Rename & Organize** — Custom naming for your saved QR codes for easy identification

---

## 📸 Screenshots

<p float="left">
    <img src="assets/screenshots/scanner.png" width="250" style="padding-right: 10px; padding-bottom: 10px;"/>
    <img src="assets/screenshots/maker.png" width="250" style="padding-right: 10px; padding-bottom: 10px;"/>
    <img src="assets/screenshots/history.png" width="250" style="padding-bottom: 10px;"/>
</p>

---

## 💡 Use Cases

- 🛒 Quickly scan product QR codes to access websites, promotions, or product information
- 📶 Generate Wi-Fi QR codes for easy guest network sharing at home or office
- 👤 Create vCard QR codes for professional networking and contact sharing
- 🔍 Maintain a searchable history of all scanned codes for future reference
- 📊 Generate URL QR codes for marketing materials, flyers, and business cards
- 🎫 Share event tickets, boarding passes, and digital credentials instantly
- 📦 Create inventory or asset tracking labels with encoded identifiers

---

## 📂 Project Structure

The project follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── controllers/
│   ├── bottom_nav_controller.dart    # Bottom navigation state
│   ├── history_controller.dart       # Scan/generate history management
│   ├── qr_maker_controller.dart      # QR generation logic
│   ├── qr_scanner_controller.dart    # Camera scanning logic
│   └── settings_controller.dart      # App settings state
├── elements/
│   ├── build_bottom_button.dart      # Reusable action buttons
│   ├── build_divider.dart            # Themed dividers
│   ├── build_navigation_row.dart     # Navigation list items
│   └── build_section_header.dart     # Section headers
├── models/
│   └── qr_code_model.dart            # QR code data model
├── routes/
│   └── app_routes.dart               # GetX routing configuration
├── screens/
│   ├── main_screen.dart              # Main app container
│   ├── qr_display.dart               # QR code detail view
│   ├── qr_maker_history_screen.dart  # Maker & recent history
│   ├── qr_scanner_screen.dart        # Camera scanner view
│   ├── scan_saved_history_screen.dart # Full history view
│   └── settings_screen.dart          # Settings page
├── services/
│   ├── history_service.dart          # History persistence
│   └── settings_service.dart         # Settings persistence
├── theme/
│   └── app_theme.dart                # Light/dark theme definitions
├── widgets/
│   ├── bottom_nav_bar.dart           # Floating navigation bar
│   ├── confirmation_bottom_sheet.dart # Delete confirmation
│   ├── history_item.dart             # History list tile
│   ├── rename_bottom_sheet.dart      # Rename dialog
│   ├── scan_frame.dart               # Scanner overlay frame
│   └── scan_result_bottom_sheet.dart # Scan result display
└── main.dart                         # App entry point
```

---

## 🧩 Built With

| Technology | Purpose |
|------------|---------|
| **Flutter SDK** | Cross-platform UI framework for beautiful native apps |
| **GetX** | State management, navigation, and dependency injection |
| **mobile_scanner** | High-performance QR/barcode scanning with ML Kit |
| **qr_flutter** | QR code generation with customizable styling |
| **shared_preferences** | Persistent local storage for settings and history |
| **share_plus** | Cross-platform sharing functionality |
| **url_launcher** | Open URLs, emails, and phone numbers from scanned codes |
| **vibration** | Haptic feedback on scan success |
| **flutter_ringtone_player** | Sound feedback on scan success |
| **intl** | Date/time formatting for history timestamps |
| **timeago** | Relative time display (e.g., "2 hours ago") |
| **uuid** | Unique ID generation for history records |

---

## 🔧 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jydv402/prisma-qr.git
   ```

2. **Navigate to the project directory**
   ```bash
   cd prisma-qr
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

Contributions are welcome and appreciated!

To get started:

1. Fork this repository
2. Create a new branch (`git checkout -b feature/prisma-xyz`)
3. Make your changes
4. Commit and push (`git commit -m "Add xyz feature"` → `git push origin feature/prisma-xyz`)
5. Open a Pull Request

---

## 🛡 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 📣 Support & Feedback

If you find Prisma QR useful:

- 🌟 Star the repo
- 🐞 Report any issues
- 📢 Spread the word with your friends
- 💡 Suggest new features

---

> **Built with ❤️ using Flutter** — creating beautiful, fast apps for any platform.
