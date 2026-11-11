# RPL Keamanan

Aplikasi Flutter untuk demonstrasi secure storage, validasi input, dan REST API.

## Menjalankan secara lokal

1. Pastikan Flutter SDK versi stabil terpasang.
2. Salin `.env.example` menjadi `.env`.
3. Jalankan:

   ```sh
   flutter pub get
   flutter run
   ```

`.env` dipakai sebagai konfigurasi aplikasi dan tidak boleh berisi rahasia yang
akan dikirim ke browser. Semua konfigurasi yang dibundel ke aplikasi web dapat
dilihat oleh pengunjung.

## Hosting di GitHub Pages

Workflow `.github/workflows/deploy.yml` akan menjalankan analisis, test, build
Flutter Web, lalu menerbitkan hasilnya ke GitHub Pages saat ada push ke branch
`main`. Workflow membuat `.env` dari `.env.example`; rahasia GitHub tidak
dimasukkan ke build karena nilai apa pun di aplikasi browser dapat diekstrak.

1. Push repository ke GitHub dengan branch utama bernama `main`. Jika branch
   utamanya bernama lain, ubah branch trigger di workflow.
2. Buka **Settings → Pages** pada repository.
3. Pada **Build and deployment**, pilih **GitHub Actions**.
4. Push perubahan ke `main`, atau jalankan workflow **Deploy Flutter Web to
   GitHub Pages** secara manual dari tab **Actions**.
5. Setelah workflow berhasil, situs tersedia di
   `https://<username>.github.io/<nama-repository>/`.

Untuk repository khusus `username.github.io`, ubah argumen `--base-href` pada
workflow menjadi `/`.

## Catatan konfigurasi dan keamanan

- `.env.example` berisi konfigurasi publik untuk JSONPlaceholder, bukan API key
  rahasia. Jangan memasukkan token, password, atau kredensial asli ke file
  tersebut.
- `.env` lokal diabaikan oleh Git. Bila file `.env` atau kredensial pernah
  dipublikasikan di riwayat Git, hapus/rotasi kredensial tersebut; menghapus
  file pada commit terbaru saja tidak menghapusnya dari riwayat.
- Fitur `flutter_secure_storage` yang memakai penyimpanan aman native tidak
  memiliki tingkat keamanan yang sama di browser. Jangan gunakan contoh token
  pada aplikasi web untuk menyimpan kredensial produksi.
