# 🧊 Smart Fridge Manager- Flutter &  Firebase
#### Designed and implemented a minimal, extensible mobile application serving as a foundation for future open-source contributions and feature expansion.

אפליקציית Flutter לניהול מוצרים במקרר, עם חיבור ל־Firebase (Authentication + Firestore).
כל משתמש מקבל מקרר פרטי משלו באמצעות התחברות אנונימית.
## 🚀 תכונות עיקריות

- 📱 אפליקציית Flutter עם Material 3
- 🔐 התחברות אנונימית עם Firebase Authentication
- ☁️ שמירת נתונים ב־Firebase Firestore
- 👤 הפרדה מלאה בין משתמשים (`/users/{uid}/products`)
- ➕ הוספת מוצרים
- ➖ הגדלה / הקטנה של כמות
- 🗑️ מחיקת מוצרים
- 🔄 עדכון בזמן אמת באמצעות `StreamBuilder`


## 🌱 Project Scope & Extensibility

This project was intentionally designed as a **minimal, clean foundation** rather than a fully-featured product.

Its goal is to demonstrate:
- Proper Flutter project structure
- Firebase Authentication & Firestore integration
- Real-time data handling
- User-based data separation

The codebase is **open for extension** and can easily be expanded by the community.

Possible extensions include (but are not limited to):
- Expiration dates & smart alerts
- Barcode scanning (OpenFoodFacts integration)
- Categories & product images
- Cloud Functions for automation
- Advanced authentication (Google / Email)
- Offline-first support

## 🛠️ Tech Stack

- Flutter (UI framework)
- Dart (strongly typed, async-first language)
- Firebase Authentication
- Cloud Firestore

---

## 🧱 ארכיטקטורה
lib/
├── main.dart
├── product.dart
├── product_service.dart
├── firebase_options.dart

- **Product** – מודל נתונים
- **ProductService** – שכבת גישה ל־Firestore
- **Firebase Auth** – זיהוי משתמש אנונימי
- **Firestore Path**:/users/{uid}/products/{productId}


---

## 🛠️ טכנולוגיות

- Flutter
- Dart
- Firebase Core
- Firebase Authentication
- Cloud Firestore

---
<img width="950" height="383" alt="image" src="https://github.com/user-attachments/assets/67529719-2099-4696-b863-b46f5f2065a6" />
<img width="956" height="253" alt="image" src="https://github.com/user-attachments/assets/8aceb23e-6424-4900-ae00-7a30b0e6425e" />

## 📦 Dependencies (pubspec.yaml)

```yaml
dependencies:
flutter:
  sdk: flutter
firebase_core: ^latest
firebase_auth: ^latest
cloud_firestore: ^latest

### install & run:
git clone https://github.com/your-username/fridge-manager.git
cd fridge-manager
- install package:
  flutter pub get

## 🔐 Firebase Setup

For security reasons, Firebase configuration files are not included in this repository.

To run the project locally:
1. Create a Firebase project
2. Register your Android / iOS / Web app
3. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
הגדרת Firebase
צור פרויקט ב־Firebase Console
הוסף אפליקציית Android / iOS
הרץ:
flutterfire configure
יווצר קובץ:
lib/firebase_options.dart

##### run:
flutter run

🔐 Authentication

האפליקציה משתמשת בהתחברות אנונימית:
await FirebaseAuth.instance.signInAnonymously();
כל משתמש מקבל uid ייחודי והנתונים נשמרים רק תחתיו.


## 🤝 Contributing

This repository is open for learning and experimentation.

If you'd like to extend the project:
- Fork the repository
- Add new features or improvements
- Submit a Pull Request

Suggestions, issues, and improvements are welcome.

