<div align="center">

# Fisimate

**Aplikasi mobile LMS fisika gamifikasi untuk siswa.**

Belajar fisika lewat materi interaktif, bank soal dan rumus, chatbot AI, serta
leaderboard yang dibungkus dalam pengalaman gamified.

[![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![State: GetX](https://img.shields.io/badge/State-GetX-8A2BE2)](https://pub.dev/packages/get)
[![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white)](#)
[![Style: flutter_lints](https://img.shields.io/badge/style-flutter__lints-40C4FF)](https://pub.dev/packages/flutter_lints)

<br />

<img src="https://res.cloudinary.com/dz2sbzpor/image/upload/v1773945287/FISIMATE_nlerom.png" alt="Preview Fisimate" width="100%" />

</div>

---

## Daftar Isi

- [Fisimate](#fisimate)
  - [Daftar Isi](#daftar-isi)
  - [Tentang](#tentang)
  - [Fitur](#fitur)
  - [Arsitektur](#arsitektur)
  - [Tech Stack](#tech-stack)
  - [Prasyarat](#prasyarat)
  - [Quick Start](#quick-start)
  - [Struktur Proyek](#struktur-proyek)
  - [Dokumentasi](#dokumentasi)
  - [Roadmap](#roadmap)
  - [Kontribusi](#kontribusi)

## Tentang

Fisimate adalah aplikasi siswa dari platform LMS fisika gamifikasi. Seluruh
konten seperti materi, soal, rumus, leaderboard, dan profil diambil dari backend
[**fisimate-api**](../fisimate-api), sehingga app fokus pada penyajian dan
interaksi. Aplikasi dibangun dengan **Flutter** dan pola modular **GetX**
(state management, routing, dan dependency injection).

> [!NOTE]
> Simulasi fisika interaktif berbasis **Unity** (mobil dan balok untuk gerak,
> gaya, gesekan), yang sedianya disematkan lewat `flutter_unity_widget`, saat
> ini **dinonaktifkan sementara**. Layar simulasi menampilkan placeholder. Lihat
> [docs/MIGRATION.md](docs/MIGRATION.md) untuk alasan dan cara mengaktifkannya
> kembali.

## Fitur

| Fitur             | Deskripsi                                                       |
| ----------------- | --------------------------------------------------------------- |
| 📚 **Bank Materi** | Katalog materi fisika dengan viewer modul (PDF dan konten kaya) |
| 🧮 **Bank Rumus**  | Kumpulan rumus fisika yang bisa ditelusuri                      |
| ❓ **Bank Soal**   | Latihan soal dengan skoring gamifikasi                          |
| 🤖 **Chatbot AI**  | Asisten belajar dan generator soal (via backend)                |
| 🏆 **Leaderboard** | Peringkat siswa berbasis poin                                   |
| 🎮 **Simulasi**    | Simulasi fisika interaktif *(sementara dinonaktifkan)*          |
| 👤 **Profil**      | Kelola profil, foto, dan kata sandi                             |
| 🔐 **Auth**        | Registrasi dan login siswa dengan penyimpanan token aman        |

## Arsitektur

Proyek mengikuti pola **feature-first** ala GetX. Setiap modul di
`lib/app/modules/` bersifat mandiri dengan tiga tanggung jawab terpisah:

```
modules/<fitur>/
├── bindings/      # Dependency injection (lazyPut controller & service)
├── controllers/   # Logika bisnis & reactive state (GetxController)
└── views/         # UI (GetView / widget)
```

Lapisan lintas-fitur:

- **`config/`** berisi konfigurasi API, service global, dan state aplikasi
- **`data/`** dan **`models/`** berisi response API dan model domain
- **`domain/services/`** membungkus pemanggilan backend
- **`routes/`** mendeklarasikan route dan halaman terpusat (`app_pages.dart`)
- **`theme/`**, **`widgets/`**, **`helpers/`**, **`utils/`** menyimpan komponen reusable

## Tech Stack

| Kategori         | Teknologi                                                                           |
| ---------------- | ----------------------------------------------------------------------------------- |
| Framework        | Flutter 3.44, Dart 3.12                                                             |
| State & Routing  | [GetX](https://pub.dev/packages/get)                                                |
| HTTP Client      | [Dio](https://pub.dev/packages/dio), [http](https://pub.dev/packages/http)          |
| Penyimpanan Aman | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)           |
| Media & UI       | cached_network_image, flutter_svg, carousel_slider, percent_indicator, skeletonizer |
| Konten           | flutter_cached_pdfview, webview_flutter                                             |
| Lain-lain        | firebase_core, flutter_dotenv, logger                                               |
| Build (Android)  | AGP 8.11.1, Gradle 8.14.3, Kotlin 2.2.20                                            |

## Prasyarat

- **Flutter 3.44+ / Dart 3.12+** (channel stable), diverifikasi di Flutter 3.44.4
- **Android SDK** (compileSdk 36, NDK 28.2.13676358) dan **JDK 17+**
- Akses ke backend **fisimate-api** yang berjalan (lokal atau production)

## Quick Start

```bash
# 1. Install dependencies
flutter pub get

# 2. Siapkan environment (arahkan BASE_URL ke fisimate-api)
cp .env.example .env

# 3. Jalankan
flutter run
```

Satu-satunya variabel environment adalah `BASE_URL` (endpoint fisimate-api).
File `.env` **wajib ada** meski hanya menyalin `.env.example`, karena
terdaftar sebagai asset di `pubspec.yaml`.

> Panduan lengkap (akun seed, build APK, menjalankan backend lokal) ada di
> [docs/SETUP.md](docs/SETUP.md).

## Struktur Proyek

```
lib/
└── app/
    ├── config/      # API, service, & state global
    ├── data/        # Response API
    ├── models/      # Model domain
    ├── domain/      # Service yang membungkus backend
    ├── modules/     # Fitur (bank_materi, bank_soal, chatbot, ...)
    ├── routes/      # Deklarasi route & halaman
    ├── theme/       # Warna, teks, & tema
    ├── widgets/     # Widget reusable
    ├── helpers/     # Helper & ekstensi
    └── utils/       # Konstanta & enum
```

## Dokumentasi

| Dokumen                                | Isi                                                     |
| -------------------------------------- | ------------------------------------------------------- |
| [docs/SETUP.md](docs/SETUP.md)         | Setup dan menjalankan secara lokal                      |
| [docs/MIGRATION.md](docs/MIGRATION.md) | Catatan revival dan modernisasi (termasuk status Unity) |

## Roadmap

- [ ] Mengaktifkan kembali simulasi fisika berbasis Unity
- [ ] Dukungan platform iOS
- [ ] Cakupan pengujian yang lebih luas

## Kontribusi

Proyek ini menggunakan `flutter_lints` dengan aturan tambahan
(lihat [analysis_options.yaml](analysis_options.yaml)) dan formatter
120-kolom. Sebelum mengirim perubahan:

```bash
dart format .
flutter analyze
flutter test
```

---