# Spec Backend — Migrasi Chatbot (Gemini → SumoPod via Backend)

> **Tujuan:** Memindahkan pemanggilan AI generator soal Fisika dari sisi mobile (yang saat ini
> memanggil Google Gemini langsung dari device) menjadi request ke endpoint backend. Backend
> yang akan memanggil **API SumoPod** dan mengembalikan soal dalam format JSON yang sudah baku.
>
> Dokumen ini adalah **kontrak** yang WAJIB dipenuhi backend. Sisi mobile mengacu pada kontrak
> yang sama (lihat `chatbot-migration-mobile-spec.md`). Jika ada perubahan kontrak, kedua file
> harus di-update bersamaan.

---

## 1. Konteks

Fitur "chatbot" pada aplikasi Fisimate **bukan** chat bebas, melainkan **generator soal pilihan
ganda Fisika**. Alur saat ini di mobile:

1. User memilih **bab (chapter)** dari dropdown (daftar bab diambil dari `GET {baseUrl}chapters`).
2. Mobile memanggil Gemini langsung dengan prompt hardcoded + template JSON, model `gemini-1.5-flash-latest`.
3. Respons JSON di-parse menjadi 1 soal pilihan ganda interaktif.

**Masalah yang diselesaikan migrasi ini:** API key AI tidak lagi berada di client, prompt & model
bisa diubah tanpa rilis ulang aplikasi, dan parsing/validasi JSON ditangani backend.

Setelah migrasi, mobile HANYA mengirim `chapter` dan menerima JSON soal yang sudah bersih.

---

## 2. Kontrak Endpoint (WAJIB)

### Request

```
POST {baseUrl}chatbot/generate-question
Authorization: Bearer <access_token>
Content-Type: application/json
```

Body:

```json
{
  "chapter": "Gerak Lurus"
}
```

- `chapter` — **string, required**. Nama bab persis seperti yang dikirim mobile (nilai berasal dari
  field `name` pada `GET {baseUrl}chapters`). Backend TIDAK menerima `chapterId` pada versi ini
  agar mobile tidak perlu perubahan pemetaan.
- Endpoint **wajib** dilindungi auth Bearer token yang sama dengan endpoint lain.

### Response Sukses — `200 OK`

Response **WAJIB** dibungkus dalam objek `data` (konsisten dengan endpoint lain seperti `chapters`):

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

**Aturan field (harus dipenuhi persis — mobile mem-parse berdasarkan ini):**

| Field | Tipe | Aturan |
|-------|------|--------|
| `data.questions` | string | Teks soal. (Perhatikan: **jamak** `questions`, mengikuti kontrak lama — jangan ubah jadi `question`.) |
| `data.options` | array | **Tepat 4 item.** |
| `data.options[].option` | string | Teks pilihan jawaban. |
| `data.options[].correct` | boolean | **Tepat satu** item bernilai `true`, sisanya `false`. |
| `data.answer` | string | Harus **sama persis** dengan teks `option` yang `correct: true`. |
| `data.explanation` | string | Penjelasan jawaban benar. |

> Nama field ini mengikuti template lama `assets/json/exam_template.json`. Backend HARUS
> menormalisasi output SumoPod ke bentuk ini — mobile tidak melakukan koreksi field.

### Response Error

Gunakan HTTP status code semantik + body yang konsisten dengan konvensi API yang ada:

| Status | Kondisi |
|--------|---------|
| `400` | `chapter` kosong / tidak valid. |
| `401` | Token tidak valid / kadaluarsa. |
| `422` | SumoPod mengembalikan output yang tidak bisa dinormalisasi ke skema di atas (setelah retry). |
| `502` / `503` | SumoPod tidak dapat dihubungi / error upstream. |

Body error (contoh, samakan dengan format error backend yang berlaku):

```json
{ "message": "Gagal menghasilkan soal, coba lagi." }
```

---

## 3. Tanggung Jawab Backend

Ini adalah logika yang **dipindahkan dari mobile ke backend**:

1. **Simpan API key SumoPod di server** (env var), tidak pernah dikirim ke client.
2. **Susun prompt** untuk SumoPod. Prompt lama (untuk referensi maksud):
   > `(Hanya respon dengan format JSON) dengan template <exam_template.json> (pastikan hanya ada satu jawaban benar): Buatkan soal Fisika Kelas 7 SMP dengan bab <chapter>`

   Backend bebas memperbaiki prompt ini asalkan output akhir sesuai skema Bagian 2. Pastikan tetap:
   - Bahasa Indonesia.
   - Level: Fisika Kelas 7 SMP (atau parametrik bila nanti diperluas).
   - Tepat 4 opsi, tepat 1 benar.
3. **Parsing & validasi** output SumoPod:
   - Ekstrak JSON dari respons model (model bisa mengembalikan teks tambahan; parse blok `{...}`).
   - Validasi skema Bagian 2 (jumlah opsi = 4, tepat 1 `correct: true`, `answer` cocok).
   - **Retry** (mis. maks 1–2x) bila JSON tidak valid; jika tetap gagal → `422`.
4. **Pilih model SumoPod** di sisi server (dapat dikonfigurasi via env), menggantikan
   `gemini-1.5-flash-latest`.

---

## 4. Definition of Done (Backend)

- [ ] Endpoint `POST {baseUrl}chatbot/generate-question` aktif & terlindungi Bearer auth.
- [ ] Menerima `{ "chapter": string }`, memvalidasi non-empty.
- [ ] Memanggil SumoPod dengan API key dari env server.
- [ ] Menormalisasi + memvalidasi output ke skema `data` di Bagian 2 (4 opsi, 1 benar, `answer` cocok).
- [ ] Menangani error upstream dengan status code Bagian 2.
- [ ] Response sukses **selalu** dibungkus `{ "data": {...} }`.
- [ ] Terverifikasi manual: kirim `chapter` valid → dapat soal valid; kirim `chapter` kosong → 400.

---

## 5. Catatan Sinkronisasi dengan Mobile

- Base URL saat ini di mobile: `http://localhost:8080/api/v1/` (dev). Endpoint relatif: `chatbot/generate-question`.
- Mobile mengharapkan pembungkus `data` dan nama field **persis** seperti Bagian 2.
- Jika backend memutuskan mengubah nama field / struktur, **update `chatbot-migration-mobile-spec.md`
  di repo mobile** dan beri tahu sesi mobile sebelum implementasi.
