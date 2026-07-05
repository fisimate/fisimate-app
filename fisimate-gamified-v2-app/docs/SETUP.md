# Setup Lokal

Panduan menjalankan Fisimate (app siswa, Flutter) di mesin lokal.

## Prasyarat

- Flutter 3.44+ / Dart 3.12+ (channel stable) — diverifikasi di Flutter 3.44.4
- Android SDK, compileSdk 36, NDK 28.2.13676358, JDK 17+ — diverifikasi build
  & run dengan JDK 21 (Gradle 8.14.3 / AGP 8.11.1)
- Backend **fisimate-api** yang bisa diakses — app ini hardcode ke API
  production di `lib/app/config/api/urls.dart` (`baseUrl`), tidak dibaca dari
  `.env`. Untuk menunjuk ke API lokal, ubah `baseUrl` secara manual saat dev
  (lihat `../../fisimate-api/docs/SETUP.md` untuk menjalankan API-nya).

## Langkah

1. **Install dependencies**

   ```bash
   flutter pub get
   ```

2. **Buat file `.env`**

   ```bash
   cp .env.example .env
   ```

   Satu-satunya variabel yang benar-benar dibaca kode adalah `GEMINI_API_KEY`
   (dipakai fitur chatbot AI di `lib/app/domain/services/gemini_api_service.dart`,
   ambil key di https://aistudio.google.com/apikey). File `.env` wajib ada
   meski kosong — didaftarkan sebagai asset di `pubspec.yaml`, dan
   `flutter pub get`/`flutter test`/build akan gagal kalau filenya tidak ada
   sama sekali.

3. **Jalankan**

   ```bash
   flutter run
   ```

   Sudah diverifikasi jalan end-to-end di Android emulator (splash → onboard
   → register/login → home) dengan `flutter build apk --debug` +
   `adb install`.

## Simulasi Unity (dinonaktifkan sementara)

Modul `lib/app/modules/game/` tadinya meng-embed simulasi Unity lewat
`flutter_unity_widget`, tapi saat ini dinonaktifkan — layar simulasi
menampilkan placeholder teks. Detail lengkap kenapa dan cara mengaktifkan
kembali ada di [MIGRATION.md](MIGRATION.md#unity-dinonaktifkan-sementara).

## Login

Gunakan akun hasil seed fisimate-api role siswa: `siswa@gmail.com` /
`siswa123` (lihat `../../fisimate-api/docs/SETUP.md`).

## Test

```bash
flutter test
flutter analyze
```

## Build APK

```bash
flutter build apk --debug    # atau --release
```

Kalau disk penuh (`No space left on device` saat Gradle daemon jalan) atau
NDK gagal ter-download dengan benar (`did not have a source.properties
file`), bersihkan cache Gradle lama (`~/.gradle/caches`, `~/.gradle/wrapper/dists`)
dan hapus ulang folder NDK yang corrupt di `~/Library/Android/sdk/ndk/`.
