# Fisimate

Aplikasi mobile LMS fisika gamifikasi untuk siswa, dibangun dengan **Flutter**
(GetX). Seluruh data (materi, soal, rumus, leaderboard, profil) diambil dari
backend [fisimate-api](../fisimate-api).

> Simulasi interaktif **Unity** (mobil, balok — gerak, gaya, gesekan), yang
> sedianya di-embed lewat `flutter_unity_widget`, **untuk sementara
> dinonaktifkan** — layar simulasi menampilkan placeholder. Lihat
> [docs/MIGRATION.md](docs/MIGRATION.md) untuk alasan & cara mengaktifkan
> lagi.

## Quick start

```bash
flutter pub get
cp .env.example .env   # isi GEMINI_API_KEY untuk fitur chatbot
flutter run
```

Detail lengkap ada di [docs/SETUP.md](docs/SETUP.md).

## Dokumentasi

- [docs/SETUP.md](docs/SETUP.md) — setup & menjalankan lokal
- [docs/MIGRATION.md](docs/MIGRATION.md) — catatan revival & modernisasi

## Stack

Flutter 3.44 (AGP 8.11.1 / Gradle 8.14.3 / Kotlin 2.2.20) · GetX (state
management & routing) · Dio/http (REST client ke fisimate-api) · Gemini AI
(chatbot) · flutter_secure_storage
