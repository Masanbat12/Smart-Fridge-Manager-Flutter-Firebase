# 🧊 Smart Fridge Manager  
### Flutter (Dart) + Firebase

A minimal and extensible Flutter application written in **Dart**, demonstrating clean architecture, real-time data handling, and Firebase integration.  
The project is intentionally scoped as a **foundation** rather than a full product, making it ideal for learning, experimentation, and open-source extension.

---

## 🚀 Features

- 📱 Flutter app using Material 3
- 🧠 Written in Dart (null-safety, async/await, streams)
- 🔐 Anonymous authentication with Firebase Auth
- ☁️ Real-time data storage with Cloud Firestore
- 👤 User-based data isolation (`/users/{uid}/products`)
- ➕ Add products
- ➖ Increase / decrease quantity
- 🗑️ Remove products
- 🔄 Live UI updates via Firestore streams

---

## 🧱 Project Structure
lib/
├── main.dart
├── product.dart
├── product_service.dart
└── products_page.dart


- **product.dart** – Product data model  
- **product_service.dart** – Firestore access & business logic  
- **products_page.dart** – UI + StreamBuilder  
- **main.dart** – App & Firebase initialization  

---

## 🛠️ Tech Stack

- Flutter
- Dart (async/await, streams, null-safety)
- Firebase Authentication
- Cloud Firestore

---

## ▶️ How to Run (Terminal)

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Emulator / Physical device / Chrome (Web)
- Firebase CLI
- FlutterFire CLI

Check setup:
```bash
flutter doctor

1️⃣ Clone the Repository:
git clone https://github.com/Masanbat12/Smart-Fridge-Manager-Flutter-Firebase.git
cd Smart-Fridge-Manager-Flutter-Firebase
2️⃣ Install Dependencies
flutter pub get

🔐 Firebase Setup (Required)
For security reasons, Firebase configuration files are not included in this repository.
##### Steps:
Create a Firebase project
Register your Android / iOS / Web app
##### Install FlutterFire CLI (once):
dart pub global activate flutterfire_cli
##### RUN:
flutterfire configure

3️⃣ Run the App
flutter run

Or for web:
flutter run -d chrome

🔒 Security
Firebase configuration files are excluded from version control
Each user is authenticated anonymously
Firestore rules enforce user-level data isolation
Example Firestore path:

/users/{uid}/products/{productId}


🌱 Project Scope & Extensibility
This project is intentionally designed as a minimal, clean foundation rather than a fully-featured application.
It demonstrates:
Proper Flutter project structure
Dart async programming with streams
Firebase Auth + Firestore integration
Real-time UI updates

Possible extensions:
Expiration dates & smart reminders
Barcode scanning (OpenFoodFacts API)
Product categories & images
Shared fridge (multi-user)
Push notifications
Offline-first support

### 🤝 Contributing
Contributions are welcome!
If you’d like to extend the project:
Fork the repository
Create a feature branch
Submit a Pull Request
Suggestions, improvements, and issues are encouraged.

##### 👨‍💻 Author
Masanbat
Developed as a portfolio mini-project prior to graduation,
focusing on clean code, maintainability, and extensibility.
