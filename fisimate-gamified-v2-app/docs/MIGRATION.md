# Catatan Revival & Modernisasi (2026-07-02)

Project ini di-revive mengikuti pola yang sama dengan `fisimate-api` dan
`fisimate-web-platform` (lihat `../../fisimate-api/docs/MIGRATION.md`).
Berbeda dengan keduanya, masalah utama di sini bukan (cuma) dependency usang,
melainkan **file platform Android yang hilang dari git sejak awal**, ditambah
Gradle/AGP/NDK yang jauh tertinggal dari toolchain lokal (JDK 21).

## Ringkasan

1. Restore scaffold platform Android (`AndroidManifest.xml`, `MainActivity`,
   `res/`, `.gitignore`) yang ternyata tidak pernah ter-commit.
2. Upgrade seluruh dependency direct ke versi major terbaru, migrasi breaking
   change yang menyertai (`connectivity_plus` 5→7).
3. Upgrade Gradle 7.6.4→8.14.3, AGP 7.3.0→8.11.1, Kotlin 1.9.0→2.2.20,
   compileSdk 34→36, NDK 23→28 — wajib supaya build jalan sama sekali di JDK 21.
4. **Unity dinonaktifkan sementara** (`flutter_unity_widget` dilepas dari
   `pubspec.yaml`, modul game di-stub) — lihat bagian khusus di bawah.
5. `flutter build apk --debug` berhasil dan diverifikasi jalan end-to-end di
   Android emulator (splash → onboard → register/login → home).

## Bug struktural yang diperbaiki

### Scaffold Android tidak pernah di-commit

`git log --all -- '**/AndroidManifest.xml'` kosong — tidak ada commit apa pun
(di branch manapun) yang pernah menambahkan file ini. Yang ter-track di git
hanya `android/{build.gradle,app/build.gradle,settings.gradle,gradle.properties}`
plus konfigurasi `gradle-wrapper.properties`. Tidak ada `.gitignore` di root
maupun di `android/` — jadi kemungkinan besar bug ini bukan karena file
di-gitignore, tapi memang tidak pernah ditambahkan (`git add`) sejak initial
commit repo ini. Diperbaiki dengan `flutter create --org id.ac.polines
--project-name fisimate --platforms=android .` (aman dijalankan di project
existing, hanya menambah file yang hilang tanpa menimpa `build.gradle` yang
sudah dikustomisasi). Detail:

- **Konflik Groovy vs Kotlin DSL**: `flutter create` versi ini generate
  `build.gradle.kts` / `settings.gradle.kts` baru berdampingan dengan
  `build.gradle` / `settings.gradle` lama — dua-duanya ada bikin Gradle
  ambigu. File `.kts` yang baru dihapus, konfigurasi lama (Groovy)
  dipertahankan lalu di-modernisasi manual (lihat bagian Gradle di bawah).
- `AndroidManifest.xml` hasil generate ulang adalah manifest default Flutter
  (tanpa permission apa pun). Ditambahkan
  `<uses-permission android:name="android.permission.INTERNET"/>` karena
  seluruh app bergantung ke REST API.
- Launcher icon di-generate ulang dari asset asli project
  (`assets/icons/fisimate_launcher_icon.png`) via
  `dart run flutter_launcher_icons`, supaya tidak memakai logo Flutter
  default.
- **Tidak ada `.gitignore` sama sekali** di root sebelumnya. Ditambahkan
  `.gitignore` standar Flutter (dari `flutter create`), plus `.env` untuk
  kredensial lokal.

### `.env` wajib ada tapi tidak terdokumentasi

`pubspec.yaml` mendaftarkan `.env` sebagai asset wajib, tapi filenya sendiri
maupun `.env.example` tidak ada di repo — `flutter pub get`/`flutter
test`/build gagal dengan `No file or variants found for asset: .env`.
Ditambahkan `.env.example` yang mendokumentasikan satu-satunya env var yang
benar-benar dibaca kode: `GEMINI_API_KEY` (grep `dotenv.env[` di seluruh
`lib/`).

> Catatan: base URL API (`lib/app/config/api/urls.dart`) **hardcode**, tidak
> lewat `.env` seperti di `fisimate-web-platform`. Untuk dev melawan API
> lokal, edit `baseUrl` manual — belum dirapikan jadi env var karena di luar
> scope revival ini.

### Test smoke test bawaan tidak relevan

`test/widget_test.dart` adalah boilerplate default Flutter (`Counter
increments smoke test`) yang tidak pernah disesuaikan — app ini tidak punya
counter sama sekali, `FisimateApp` langsung route ke splash screen. Diganti
jadi smoke test yang benar-benar menguji app ini: pump `FisimateApp` dan
pastikan tidak throw.

## Upgrade Gradle / AGP / Kotlin / NDK

Setelah scaffold Android ada, `flutter build apk` masih gagal total — Gradle
7.6.4 (dan AGP 7.3.0, Kotlin 1.9.0, NDK 23) sudah terlalu tua untuk JDK 21
yang terpasang di mesin ini (`Unsupported class file major version 65`).
Flutter 3.44 sendiri mensyaratkan minimum AGP 8.6.0. Upgrade dilakukan
bertahap sampai versi yang benar-benar Flutter minta:

| Komponen | Sebelum | Sesudah |
|---|---|---|
| Gradle | 7.6.4 | 8.14.3 |
| AGP (`com.android.application`) | 7.3.0 | 8.11.1 |
| Kotlin (`org.jetbrains.kotlin.android`) | 1.9.0 | 2.2.20 |
| `compileSdk` | 34 | 36 (diminta beberapa plugin: `connectivity_plus`, `flutter_secure_storage`, `image_cropper`, dst) |
| `ndkVersion` | 23.1.7779620 | 28.2.13676358 |
| `compileOptions`/`kotlinOptions` target | Java 8 | Java 17 |

`minSdkVersion` yang sebelumnya eksplisit `22` **otomatis ditulis ulang** oleh
migrator bawaan Flutter (`flutter build`/`flutter run` menjalankan
"Upgrading build.gradle" setiap kali) jadi `minSdkVersion =
flutter.minSdkVersion` (default Flutter, saat ini 21) — perubahan ini
dibiarkan, bukan dilawan, karena migrator akan menimpanya lagi di build
berikutnya kalau di-hardcode manual.

`google-services` (plugin Firebase) **dinonaktifkan** (dikomentari, bukan
dihapus) di `android/app/build.gradle` — `firebase_core` ada di
`pubspec.yaml` tapi **tidak diimport di manapun** di `lib/`, dan plugin ini
hard-fail tanpa `google-services.json` yang memang tidak ada di repo. Tinggal
uncomment + tambah file itu kalau Firebase-nya jadi benar-benar dipakai.

## Unity dinonaktifkan sementara

Setelah scaffold & Gradle beres, langkah berikutnya adalah membuat
`:unityLibrary` (module yang di-reference `android/settings.gradle`, tapi
tidak pernah ada di repo — hasil export Unity Editor yang harusnya
di-generate manual) sebagai module Gradle **stub** kosong supaya build jalan
tanpa Unity asli. Ini sempat berhasil sebagian jauh (lewati error
`checkDebugAarMetadata`/`unity-classes` dengan menyalin `unity-classes.jar`
bawaan plugin ke `unityLibrary/libs/`), tapi akhirnya mentok di:

```
e: .../OverrideUnityActivity.kt:7:27 Unresolved reference 'UnityPlayerActivity'.
```

`unity-classes.jar` yang dibundel di dalam plugin `flutter_unity_widget`
sendiri (untuk kebutuhan kompilasi plugin-nya) hanya berisi stub minimal
(`UnityPlayer`, `IUnityPlayerLifecycleEvents`, dst) — **tidak** berisi
`UnityPlayerActivity` dan kelas lain yang cuma ada di jar hasil export Unity
Editor yang sesungguhnya. Artinya stub Gradle module kosong **tidak cukup**
untuk plugin ini compile sama sekali; dibutuhkan hasil export Unity yang
nyata (bukan cuma untuk fitur game jalan, tapi supaya *compile* saja
berhasil).

Karena source project Unity tidak ditemukan di manapun dan tidak dalam scope
saat ini (lihat instruksi di awal revival ini), pilihannya adalah mengangkat
sepenuhnya ketergantungan Unity dari build path, bukan cuma stub setengah
jalan:

- `flutter_unity_widget` **dikomentari** (bukan dihapus) di `pubspec.yaml`.
- `android/unityLibrary/` (stub yang sempat dibuat) **dihapus**, begitu juga
  referensi `:unityLibrary` di `android/settings.gradle` dan
  `android/app/build.gradle`.
- `lib/app/modules/game/controllers/game_controller.dart`: field
  `UnityWidgetController?` diganti `dynamic`, tipe parameter
  `onUnitySceneLoaded` diganti `dynamic` (sebelumnya `SceneLoaded?` dari
  package yang sekarang tidak ada). Semua method publik (`startMovement`,
  `setScene`, `setAppliedForce`, dst) **tetap ada dengan signature sama** dan
  tetap meng-update state observable (`isGameLoaded`, `gameSceneName`,
  `isObjectMoving`) — jadi kode lain yang memanggil `GameController` (mis.
  `simulation_content_controller.dart`, `simulation_simulation_section_view.dart`)
  tidak perlu berubah sama sekali, cuma tidak benar-benar menggerakkan
  simulasi 3D apa pun.
- `lib/app/modules/game/views/game_view.dart`: `UnityWidget(...)` diganti
  `Container` hitam dengan teks "Simulasi 3D belum tersedia". Struktur
  loading shimmer di sekitarnya dipertahankan apa adanya.

### Cara mengaktifkan lagi

1. Dapatkan/bangun source project Unity untuk Fisimate (tidak ada di
   `Portfolio/` manapun saat dokumen ini ditulis).
2. Unity Editor → `File > Build Settings > Android > Export Project` →
   copy hasilnya ke `android/unityLibrary/`.
3. `android/settings.gradle`: tambahkan lagi
   `include ":unityLibrary"` + `project(":unityLibrary").projectDir = file("./unityLibrary")`.
4. `android/app/build.gradle`: tambahkan lagi
   `dependencies { implementation project(':unityLibrary') }`.
5. `pubspec.yaml`: uncomment blok `flutter_unity_widget` (masih pin ke fork
   `juicycleff/flutter-unity-view-widget` branch `flutter_3.24_android_hotfix`
   — package resminya sudah lama tidak di-maintain).
6. `game_controller.dart` / `game_view.dart`: kembalikan tipe
   `UnityWidgetController`/`SceneLoaded` dan `UnityWidget(...)` (lihat git
   history commit revival ini untuk versi sebelum di-stub).
7. Kemungkinan besar perlu ulang beberapa langkah modernisasi Gradle di atas
   khusus untuk module `flutter_unity_widget` (jvmTarget/compileSdk-nya
   hardcode rendah) — root `android/build.gradle` sebelumnya sempat punya
   `subprojects { afterEvaluate { ... jvmTarget = "17" ... } }` untuk
   menambal ini, dihapus lagi saat Unity dilepas karena tidak ada subproject
   lain yang butuh. Bisa dikembalikan dari git history kalau perlu.

## Upgrade dependency Dart (major version bump)

Dilakukan dengan `flutter pub outdated` lalu menaikkan tiap dependency
direct ke versi major terbaru di `pubspec.yaml`, cek breaking change lewat
`flutter analyze`.

| Package | Sebelum | Sesudah | Breaking change |
|---|---|---|---|
| `connectivity_plus` | 5.0.2 | 7.2.0 | `checkConnectivity()` sekarang return `List<ConnectivityResult>`, bukan `ConnectivityResult` tunggal (mendukung multi-network). Dipakai di `connectivity_helper.dart` dan `simulation_controller.dart` — diambil `.first`. |
| `firebase_core` | 3.2.0 | 4.11.0 | Tidak ada breaking change kena, package ini **tidak diimport di manapun** di `lib/` saat ini (dead dependency, plugin Gradle-nya dinonaktifkan, lihat di atas). |
| `image_cropper` | 7.1.0 | 12.2.1 | API yang dipakai (`profile_controller.dart`) tetap kompatibel, tidak ada error dari `flutter analyze`. |
| `flutter_secure_storage` | 9.2.2 | 10.3.1 | API `read/write/delete` yang dipakai (`secure_storage_helper.dart`) tidak berubah. |
| `skeletonizer` | 1.4.2 | 2.1.3 | Dead dependency, tidak diimport di `lib/`. |
| `carousel_slider` | 4.2.1 | 5.1.2 | Dead dependency, tidak diimport di `lib/`. |
| Lainnya (`dio`, `http`, `webview_flutter`, `flutter_dotenv`, dst) | — | latest | Minor/major bump tanpa breaking change yang kena. |
| `flutter_lints` | 4.0.0 | 6.0.0 | Menambah lint baru (`avoid_print`, `use_super_parameters`, dst) — semuanya level `info`, sengaja **tidak** dibereskan satu-satu supaya diff revival ini fokus ke yang struktural. |

## Disk penuh saat build

Saat pertama kali menjalankan `flutter build apk`, Gradle sempat gagal
dengan `No space left on device` dan NDK ter-download corrupt
(`[CXX1101] NDK ... did not have a source.properties file`) — bukan bug di
project ini, tapi disk mesin dev sendiri tersisa ~1.8GB dari `~/.gradle`
yang sudah 34GB (banyak cache versi Gradle lama dari project lain).
Dibersihkan (hapus wrapper dist & cache per-versi Gradle selain versi yang
dipakai project ini, hapus `~/.gradle/daemon`) — melonggarkan ~29GB. Kalau
ketemu error serupa di mesin lain, lihat troubleshooting di
[SETUP.md](SETUP.md#build-apk).

## Yang sengaja belum dikerjakan

- **Simulasi Unity** dinonaktifkan (lihat bagian khusus di atas) — bukan
  cuma "belum di-setup", tapi source project Unity-nya sendiri belum
  ditemukan di repo manapun.
- **`google-services.json`** (Firebase) tidak ada, plugin Gradle-nya
  dinonaktifkan. Kalau nanti dipakai beneran, file ini perlu ditambahkan dan
  plugin di-uncomment lagi di `android/app/build.gradle`.
- **iOS platform** tidak pernah ada di repo ini sama sekali (tidak seperti
  Android yang setidaknya punya `build.gradle` custom) — di luar scope,
  belum direstore.
- **Dead dependency** `firebase_core` (`carousel_slider`, `skeletonizer` juga
  dead tapi tidak menyebabkan masalah build) dibiarkan di `pubspec.yaml`
  walau tidak dipakai — tidak dihapus karena belum jelas apakah memang fitur
  yang belum selesai dikerjakan atau memang sisa yang bisa dibuang.
- Lint info baru dari `flutter_lints` 6 (level `info`, bukan `error`) belum
  dibereskan satu-satu.
