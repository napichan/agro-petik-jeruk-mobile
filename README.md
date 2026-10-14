
# Agro Petik Jeruk Mobile



## Identitas Tim dan Pembagian Tugas

Proyek Agro Petik Jeruk Mobile dikembangkan secara berkelompok sebagai bagian dari kegiatan perkuliahan. Setiap anggota memiliki tanggung jawab dalam pengembangan aplikasi sesuai dengan pembagian tugas yang telah disepakati.

### Anggota Tim

| No. | Nama                 | NIM             | Jobdesk                                                                                   |
| --- | -------------------- | --------------- | ----------------------------------------------------------------------------------------- |
| 1   | Dwiki Ilman Nafian   | 253140707111035 | Pengembangan antarmuka mobile: Login, Beranda, navigasi Pesan Tiket, Riwayat, dan Profil. |
| 2   | Shely Rahmatika Devi | 253140707111021 | Pengembangan antarmuka mobile: Register, PopUp, E-Tiket, Tiket saya, Jelahai aktivitas.   |

## Deskripsi Proyek

Agro Petik Jeruk Mobile merupakan aplikasi berbasis mobile yang dikembangkan menggunakan Flutter untuk mendukung kegiatan wisata petik jeruk di kawasan Solorejo, Malang. Aplikasi ini dirancang untuk memudahkan pengunjung dalam memperoleh informasi wisata, memilih paket kunjungan, melakukan pemesanan tiket, serta mengakses berbagai fitur pendukung selama merencanakan kunjungan.

Selain menyediakan layanan pemesanan wisata, aplikasi ini dirancang dengan memanfaatkan teknologi kecerdasan buatan (Artificial Intelligence/AI) untuk mendukung pengenalan visual jeruk dan memberikan rekomendasi kunjungan yang lebih sesuai dengan kebutuhan pengguna.

Pengembangan aplikasi dilakukan secara bertahap, mulai dari implementasi antarmuka, navigasi antarhalaman, hingga pengembangan fitur-fitur pendukung. Beberapa fitur masih berada dalam tahap pengembangan dan belum terintegrasi sepenuhnya dengan layanan AI maupun backend.

## Tujuan Pengembangan

Pengembangan aplikasi Agro Petik Jeruk Mobile bertujuan untuk:

* Mempermudah pengunjung dalam memperoleh informasi mengenai wisata petik jeruk.
* Menyediakan akses pemesanan tiket dan informasi paket wisata melalui perangkat mobile.
* Mengembangkan pengalaman wisata yang didukung oleh teknologi digital.
* Merancang pemanfaatan teknologi AI untuk membantu pengenalan jeruk dan memberikan rekomendasi kunjungan.
* Menyediakan akses informasi tiket, riwayat kunjungan, dan profil pengguna dalam satu aplikasi.

## Fitur Utama Aplikasi

### 1. CitrusScan

CitrusScan merupakan fitur yang dirancang untuk membantu pengunjung mengenali jenis jeruk, mengetahui tingkat kematangan, dan memperoleh perkiraan kelayakan jeruk untuk dipetik melalui pemindaian visual. Fitur ini direncanakan menggunakan teknologi AI untuk mendukung proses analisis gambar. Integrasi dan fungsi AI masih dalam tahap pengembangan.

### 2. Kategori Paket Otomatis

Fitur ini menyediakan kategori paket kunjungan yang meliputi Wisata, Wawancara, dan Edukasi-Riset. Setiap kategori dirancang memiliki informasi dan harga sesuai dengan jenis kunjungan yang dipilih. Perhitungan harga otomatis diterapkan sesuai dengan kebutuhan dan aturan paket yang ditentukan dalam pengembangan aplikasi.

### 3. Chatbot AI Rekomendasi

Chatbot AI Rekomendasi dirancang sebagai asisten digital yang membantu pengunjung memahami informasi kalender musim dan memperoleh saran kunjungan yang lebih personal. Rekomendasi direncanakan disesuaikan dengan informasi musim serta kebutuhan pengunjung. Integrasi layanan AI masih dalam tahap pengembangan.

### 4. Booking & E-Tiket QR

Fitur Booking & E-Tiket QR dirancang untuk mendukung proses pemesanan tiket secara mandiri melalui aplikasi. Setelah proses pemesanan terintegrasi, pengunjung diharapkan dapat memperoleh tiket elektronik dalam bentuk QR code sebagai informasi tiket kunjungan.

### 5. Tiket Saya & Riwayat

Fitur ini dirancang untuk membantu pengguna mengakses informasi tiket yang dimiliki, meliputi tiket aktif, tiket untuk kunjungan mendatang, dan riwayat kunjungan. Fitur ini mendukung pengelolaan informasi pemesanan agar lebih mudah diakses melalui aplikasi.

## Teknologi yang Digunakan

Teknologi dan package yang digunakan dalam pengembangan aplikasi meliputi:

* **Flutter** — Framework untuk pengembangan aplikasi mobile.
* **Dart** — Bahasa pemrograman yang digunakan dalam pengembangan aplikasi Flutter.
* **Google Fonts** — Package untuk penggunaan font dalam antarmuka aplikasi.
* **Iconify Flutter** — Package untuk mendukung penggunaan ikon pada antarmuka aplikasi.
* **Git dan GitHub** — Digunakan untuk pengelolaan kode sumber dan kolaborasi pengembangan.

## Struktur Proyek

Struktur utama proyek disusun sebagai berikut:

```text
flutter_agrowisatajeruk/
├── android/
├── assets/
│   └── images/
├── lib/
│   ├── pages/
│   ├── services/
│   ├── widgets/
│   └── main.dart
├── test/
├── web/
├── windows/
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

Keterangan:

* `lib/pages/` berisi halaman-halaman aplikasi.
* `lib/services/` berisi layanan pendukung aplikasi.
* `lib/widgets/` berisi komponen antarmuka yang digunakan kembali.
* `assets/images/` menyimpan aset gambar yang digunakan dalam aplikasi.
* `pubspec.yaml` berisi konfigurasi proyek dan dependensi Flutter.

## Persyaratan Sistem

Sebelum menjalankan aplikasi, pastikan perangkat pengembangan telah memiliki:

* Flutter SDK.
* Dart SDK yang sesuai dengan versi Flutter yang digunakan.
* Visual Studio Code atau editor lain yang mendukung Flutter.
* Android Studio, emulator, atau perangkat Android untuk menjalankan aplikasi.

## Cara Menjalankan Aplikasi

1. Clone repository GitHub:

   ```bash
   git clone https://github.com/napichan/agro-petik-jeruk-mobile.git
   ```
2. Masuk ke direktori proyek:

   ```bash
   cd agro-petik-jeruk-mobile
   ```
3. Pindah ke branch pengembangan:

   ```bash
   git switch dev
   ```
4. Instal seluruh dependensi:

   ```bash
   flutter pub get
   ```
5. Periksa konfigurasi Flutter:

   ```bash
   flutter doctor
   ```
6. Jalankan aplikasi pada emulator atau perangkat yang terhubung:

   ```bash
   flutter run
   ```

## Dokumentasi Tampilan Aplikasi

Bagian ini digunakan untuk menampilkan dokumentasi antarmuka aplikasi, seperti halaman Login, Beranda, Pemesanan Tiket, Riwayat, dan Profil. Screenshot ditambahkan setelah setiap tampilan siap didokumentasikan.

## Status Pengembangan

Aplikasi Agro Petik Jeruk Mobile dikembangkan secara bertahap. Implementasi antarmuka dan navigasi dilakukan sesuai dengan pembagian tugas dalam tim. Sementara itu, integrasi backend, layanan AI, pemrosesan QR code, dan fungsi pemesanan disesuaikan dengan tahap implementasi masing-masing fitur.

Deskripsi fitur dalam README ini menjelaskan rancangan dan tujuan fitur aplikasi, bukan pernyataan bahwa seluruh fungsi telah selesai atau berjalan sepenuhnya.

## Repository

Kode sumber aplikasi dapat diakses melalui repository GitHub berikut:

https://github.com/napichan/agro-petik-jeruk-mobile

---

Aplikasi Agro Petik Jeruk Mobile dikembangkan sebagai bagian dari proyek perkuliahan di bidang pengembangan aplikasi mobile.
