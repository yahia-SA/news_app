# 📰 Flutter News App
# Create By Yahia_SA

A multilingual Flutter news application built using Clean Architecture and Bloc. It allows users to browse and search for the latest news articles in a responsive and user-friendly interface.

---

## 🚀 Features

- 🔍 Search for news articles
- 🌐 Localization (English, Arabic) with `easy_localization`
- 🧱 Clean Architecture (Domain, Data, Presentation layers)
- 📡 API integration using Dio
- 🧠 State management with Bloc
- 🖼 Cached images using `cached_network_image`
- 📱 Responsive UI with `flutter_screenutil`
- 🎨 Light & dark theme ready (optional)
- 💬 Proper error and loading state handling

---

## 📦 Tech Stack

| Tech              | Purpose                                |
|-------------------|----------------------------------------|
| Flutter           | Cross-platform UI                      |
| Bloc              | State management                       |
| Dio               | HTTP client for API calls              |
| Easy Localization | Multilingual support                   |
| ScreenUtil        | Responsive sizing                      |
| CachedNetworkImage| Image caching                          |

---

## 🧱 Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── extensions/
│   ├── netwrok/
│   ├── routing/
│   ├── services/
│   ├── themes/
├── features/
│   └── news/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│           ├── bloc/
│           ├── widgets/
│           ├── pages/
├── main.dart
```

The app is structured using **Clean Architecture**:
- **Domain**: Business logic (entities, use cases)
- **Data**: Data models and API logic
- **Presentation**: UI, widgets, state management

---

## 🛠 Setup

### Requirements

- Flutter SDK (>=3.10.0)
- Android Studio / VS Code / Xcode
- Internet access

### Installation

```bash
git clone https://github.com/yahia-SA/flutter-news-app.git
cd flutter-news-app
flutter pub get
```

---

## 🌐 Localization Setup

After updating translation files:

```bash
flutter pub run easy_localization:generate -S assets/langs -f keys -o locale_keys.g.dart
```

---

## 🧪 Running the App

```bash
flutter run
```

Make sure to run it on an Android/iOS device or emulator.

---

## ❗ Known Limitations

- No video support is included in this version.
- External URLs are not opened or rendered.

---

## 🤝 Contributing

Contributions, suggestions, and pull requests are welcome!

---

## 📄 License

This project is open source under the [MIT License](https://choosealicense.com/licenses/mit/).
