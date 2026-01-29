# 🧠 Thought

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-Language-blue?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android-green?logo=android)
![Status](https://img.shields.io/badge/Status-POC-orange)
![Privacy](https://img.shields.io/badge/Privacy-Local%20Only-success)
![License](https://img.shields.io/badge/License-TBD-lightgrey)

> A minimalist mobile app to capture, organize, and secure your thoughts — offline and distraction-free.

---

## ✨ Project Purpose

**Thought** is a **Proof of Concept (POC)** that also serves as a **portfolio / CV demo project**.

Its goals are to:
- demonstrate clean mobile architecture and UX decisions,
- showcase a privacy-first mindset,
- highlight full ownership of a product (idea → development → release).

The app focuses on capturing thoughts quickly and storing them **locally and securely**, without cloud services, accounts, or distractions.

---

## 🚀 Features

### Current Version (v1)

- 🔐 **PIN-based lock** (with fallback)
- ✍️ Add text-based thoughts
- 📋 Chronological list of thoughts
- 🗑️ Delete a thought (swipe gesture)
- ✏️ View and edit a thought
- 💾 Local storage
- 🌍 Language based on device settings
- ⚙️ Settings page:
  - replay introduction
  - change language
  - update PIN
  - reset all thoughts

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Hive** (local storage)

Architecture choices prioritize:
- simplicity
- readability
- ease of iteration
- future extensibility

---

## 🔒 Privacy & Security

- No cloud services
- No analytics or tracking
- No external authentication
- All data stored **locally on the device**
- Local encryption planned / in progress

Privacy is a **core design decision**, not an optional feature.

---

## 📱 Platforms

- ✅ Android (Google Play – internal testing)
- ⏳ iOS (not planned for now – POC project)

---

## 🧪 Project Status

- Proof of Concept
- Actively developed
- Stable and functional core
- Used as a **technical demonstration for CV / portfolio**

---

## 🎯 What This Project Demonstrates

From an engineering and product perspective, this project demonstrates:

- 📱 End-to-end mobile app development
- 🧩 State management and local persistence
- 🔐 Security-conscious design (lock, local-first, encryption roadmap)
- 🎨 UX decisions focused on minimalism and speed
- 🛠️ Iterative development with a clear roadmap
- 🚀 Ability to ship a working product (internal store distribution)

---

## 🧠 Key Engineering Decisions

- **Local-first architecture** to maximize privacy and offline usability
- **Hive** chosen for lightweight, fast local persistence
- **Minimal dependencies** to reduce complexity
- **Simple navigation flow** to keep cognitive load low
- **Security as default**, not behind a paywall or option

These decisions reflect a pragmatic, product-oriented engineering mindset.

---

## 🗺️ Roadmap (High-level)

- [ ] Full local encryption
- [ ] Search and filters
- [ ] Tagging and date-based organization
- [ ] Local export / backup
- [ ] Optional advanced modules (AI assistance, voice, drawings)

---

## 📦 Installation (Development)

```bash
git clone https://github.com/YOUR_USERNAME/thought.git
cd thought
flutter pub get
flutter run
```

---

## 🤝 Contributing

This project is primarily a **personal demo**, but:
- feedback is welcome
- ideas are appreciated
- issues can be opened for discussion

---

## 📄 License

Personal project — license to be defined

---

## 🙋‍♂️ Author

Built by **Baptiste RIFFARD**  
📍 Helsinki  
💻 Software Developer  
🧠 POC / Portfolio / Product-thinking demo
