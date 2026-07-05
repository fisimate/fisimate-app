# Spec Mobile — Migrasi Chatbot (Gemini → Backend/SumoPod)

> **Tujuan:** Mengganti pemanggilan Google Gemini langsung dari device menjadi request ke endpoint
> backend baru. Backend yang memanggil SumoPod. Mobile HANYA mengirim `chapter` dan menerima JSON
> soal yang sudah bersih.
>
> Dokumen ini adalah spec pekerjaan sisi **mobile (Flutter/GetX)**. Kontrak API-nya identik dengan
> `chatbot-migration-backend-spec.md` — jika kontrak berubah, kedua file harus di-update bersamaan.

---

## 1. Kondisi Saat Ini (yang akan diubah)

Fitur "chatbot" = **generator soal Fisika**, bukan chat bebas.

- **UI** — `lib/app/modules/chatbot/views/chatbot_detail_view.dart`
  User memilih bab dari `CustomDropdown` lalu menekan tombol kirim → `controller.addMessage(controller.selectedChapter)`.
- **Controller** — `lib/app/modules/chatbot/controllers/chatbot_controller.dart`
  - `addMessage()` (baris ~51–99) menambah bubble user, set state `loading`, memanggil
    `GeminiApiService.stringFromGemini(prompt: chapter)`, lalu mem-parse respons jadi `GeneratedPhycsicsExam`.
  - Ada `late final GenerativeModel _model` yang **tidak pernah dipakai** (sisa kode) — hapus.
  - Import `package:google_generative_ai/...` — hapus setelah migrasi.
- **Service** — `lib/app/domain/services/gemini_api_service.dart`
  Memanggil Gemini langsung dengan `dotenv.env['GEMINI_API_KEY']`, model `gemini-1.5-flash-latest`,
  prompt hardcoded + `assets/json/exam_template.json`. **Semua ini dipindah ke backend.**
- **Model** — `lib/app/models/generated_physics_exam.dart`
  `GeneratedPhycsicsExam.fromJson` membaca field: `questions`, `options[]{option, correct}`,
  `answer`, `explanation`. **Struktur ini dipertahankan** — kontrak backend menyesuaikan.

Pola service backend yang sudah ada (jadikan acuan): `lib/app/config/services/chapter_api_service.dart`
— singleton + `Dio` + header `Authorization: Bearer <token>`, base URL dari `URLs.baseUrl`,
respons dibaca dari `response.data['data']`.

---

## 2. Kontrak Endpoint (dari backend — WAJIB diikuti)

### Request

```
POST {URLs.baseUrl}chatbot/generate-question
Authorization: Bearer <access_token>
Content-Type: application/json
```

Body:

```json
{ "chapter": "Gerak Lurus" }
```

`chapter` = nilai `controller.selectedChapter` (string nama bab, sama seperti yang saat ini
dikirim sebagai prompt).

### Response Sukses — `200 OK`

Dibungkus dalam `data`:

```json
{
  "data": {
    "questions": "Sebuah mobil bergerak lurus...",
    "options": [
      { "option": "10 m/s", "correct": false },
      { "option": "20 m/s", "correct": true },
      { "option": "30 m/s", "correct": false },
      { "option": "40 m/s", "correct": false }
    ],
    "answer": "20 m/s",
    "explanation": "Karena v = s/t maka..."
  }
}
```

Field `data` **cocok persis** dengan `GeneratedPhycsicsExam.fromJson` yang sudah ada
(`questions` jamak, `options`, `answer`, `explanation`). Parse dengan `GeneratedPhycsicsExam.fromJson(response.data['data'])`.

### Response Error

`400` chapter kosong · `401` token invalid · `422` output AI gagal · `502/503` upstream error.
Body error: `{ "message": "..." }`. Tampilkan state error seperti sekarang (`ResultState.error`).

---

## 3. Pekerjaan Mobile

### 3.1 Tambah URL
`lib/app/config/api/urls.dart`:
```dart
// POST - Generate Chatbot Question
static const String chatbotGenerate = 'chatbot/generate-question';
```

### 3.2 Buat service baru
`lib/app/config/services/chatbot_api_service.dart`, mengikuti pola `ChapterApiService`
(singleton + Dio + Bearer). Contoh signature:

```dart
Future<GeneratedPhycsicsExam> generateQuestion({
  required String chapter,
  required String accessToken,
});
```
- Set `dio.options.headers['Authorization'] = 'Bearer $accessToken'`.
- `dio.post('${URLs.baseUrl}${URLs.chatbotGenerate}', data: {'chapter': chapter})`.
- Return `GeneratedPhycsicsExam.fromJson(response.data['data'])`.
- Tangani `DioException` + logging konsisten dengan service lain.

### 3.3 Ubah controller
`lib/app/modules/chatbot/controllers/chatbot_controller.dart` — di `addMessage()`:
- Ganti `GeminiApiService.stringFromGemini(...)` → `ChatbotApiService().generateQuestion(chapter: messageText, accessToken: await StorageService.getAccessToken() ?? '')`.
- Hapus `json.decode` manual (service sudah mengembalikan objek).
- Pertahankan alur state: `loading` → tambah `GeneratedPhycsicsExam` ke `_chatMessages` → `hasData`; `catchError` → `error`.
- Hapus field `late final GenerativeModel _model` + getter `model`, dan import `google_generative_ai` serta `dart:convert` bila tak terpakai lagi.

### 3.4 Bersihkan sisa Gemini
- Hapus `lib/app/domain/services/gemini_api_service.dart` (pastikan tidak dipakai di tempat lain: `grep -r GeminiApiService lib/`).
- Hapus dependency `google_generative_ai` di `pubspec.yaml` (cek tidak ada import lain).
- Hapus `GEMINI_API_KEY` dari `.env` / `.env.example`.
- `assets/json/exam_template.json` tidak lagi dipakai mobile (logika prompt pindah ke backend) — boleh dihapus setelah dipastikan tak direferensikan.

---

## 4. Definition of Done (Mobile)

- [ ] `URLs.chatbotGenerate` ditambahkan.
- [ ] `ChatbotApiService.generateQuestion()` dibuat mengikuti pola `ChapterApiService`.
- [ ] `ChatbotController.addMessage()` memakai service baru; alur `ResultState` tetap sama.
- [ ] Tidak ada lagi referensi ke `GeminiApiService`, `google_generative_ai`, atau `GEMINI_API_KEY`.
- [ ] `flutter analyze` bersih; `flutter pub get` sukses setelah dependency dihapus.
- [ ] Terverifikasi manual: pilih bab → tekan kirim → soal muncul; matikan backend → muncul state error.

---

## 5. Catatan Sinkronisasi dengan Backend

- Backend harus sudah menyediakan `POST chatbot/generate-question` dengan respons terbungkus `data`
  dan nama field persis Bagian 2 **sebelum** mobile bisa diuji end-to-end.
- Base URL dev saat ini: `http://localhost:8080/api/v1/` (lihat `URLs.baseUrl`).
- Jika struktur respons backend berbeda dari Bagian 2, sesuaikan `GeneratedPhycsicsExam.fromJson`
  ATAU minta backend menormalisasi — dan update kedua file spec.
