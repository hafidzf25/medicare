import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  String selectedCategory = "Kesehatan Tubuh"; // Kategori default

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( // Tambahkan dekorasi latar belakang putih di sini
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    'Ketahui Informasi Kesehatan Terbaru!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCategoryTab("Kesehatan Tubuh"),
                  buildCategoryTab("Kesehatan Mental"),
                  buildCategoryTab("Kecantikan"),
                ],
              ),
            ),
            const SizedBox(height: 10), // Spacer
            // Tampilkan konten berdasarkan kategori yang dipilih
            buildContent(selectedCategory),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryTab(String title) {
    bool isSelected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = title;
          });
        },
        child: Container(
          width: 120, // Ubah ukuran lebar sesuai kebutuhan Anda
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.blue : Colors.white,
            border: Border.all(color: Colors.black, width: 1), // Tambahkan border/stroke
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun konten berdasarkan kategori
  Widget buildContent(String category) {
    switch (category) {
      case 'Kesehatan Tubuh':
        return buildBodyHealthContent();
      case 'Kesehatan Mental':
        return buildMentalHealthContent();
      case 'Kecantikan':
        return buildBeautyContent();
      default:
        return Container();
    }
  }

  // Fungsi untuk membangun konten kesehatan tubuh
  Widget buildBodyHealthContent() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildNewsItem('assets/images/tubuh1.jpg', 'Kenali Risiko dan Penanganan Cedera Olahraga Bulu Tangkis'),
            buildNewsItem('assets/images/tubuh2.jpg', 'Pentingnya Vaksinasi bagi Orang Dewasa'),
            buildNewsItem('assets/images/tubuh3.jpg', 'Cegah Kanker Serviks, Lakukan Vaksinasi HPV!'),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun konten kesehatan mental
  Widget buildMentalHealthContent() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildNewsItem('assets/images/mental1.jpeg', 'Hasil Survei I-NAMHS: Satu dari Tiga Remaja Indonesia Memiliki Masalah Kesehatan Mental'),
            buildNewsItem('assets/images/mental2.jpeg', '6 Tips Menjaga Kesehatan Mental Remaja'),
            buildNewsItem('assets/images/mental3.jpg', 'Pentingkah Mahasiswa Menjaga Kesehatan Mental?'),
            // Tambahkan lebih banyak widget di sini untuk scroll horizontal
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun konten kecantikan
  Widget buildBeautyContent() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildNewsItem('assets/images/kecantikan1.jpg', 'Cara Mengatasi Kulit Kering saat Puasa yang Bisa Dilakukan'),
            buildNewsItem('assets/images/kecantikan2.jpg', 'Ini Tips Merawat Wajah saat Puasa, Tetap Sehat dan Cerah'),
            buildNewsItem('assets/images/kecantikan3.jpg', '5 Efek Samping Masker Putih Telur untuk Wajah, Harus Tahu!'),
          ],
        ),
      ),
    );
  }

  Widget buildNewsItem(String imagePath, String newsTitle) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (newsTitle == 'Kenali Risiko dan Penanganan Cedera Olahraga Bulu Tangkis') {
            _launchURL('https://mediaindonesia.com/olahraga/503193/ini-risiko-cedera-karena-bermain-bulu-tangkis-dan-penanganannya#google_vignette');
          }
          else if (newsTitle == 'Pentingnya Vaksinasi bagi Orang Dewasa') {
            _launchURL('https://www.idntimes.com/health/fitness/eka-amira-yasien/alasan-pentingnya-vaksinasi-bagi-orang-dewasa');
          }
           else if (newsTitle == 'Cegah Kanker Serviks, Lakukan Vaksinasi HPV!') {
            _launchURL('https://www.rspondokindah.co.id/id/news/cegah-kanker-serviks-lakukan-vaksinasi-hpv');
          }
          else if (newsTitle == 'Hasil Survei I-NAMHS: Satu dari Tiga Remaja Indonesia Memiliki Masalah Kesehatan Mental') {
            _launchURL('https://ugm.ac.id/id/berita/23086-hasil-survei-i-namhs-satu-dari-tiga-remaja-indonesia-memiliki-masalah-kesehatan-mental/');
          }
           else if (newsTitle == '6 Tips Menjaga Kesehatan Mental Remaja') {
            _launchURL('https://ners.unair.ac.id/site/index.php/news-fkp-unair/30-lihat/561-6-tips-menjaga-kesehatan-mental-remaja#:~:text=Nah%2C%20untuk%20remaja%20yang%20merasa%20mudah%20mengalami%20stress,Terbukalah%20pada%20Seseorang%206%20%E2%80%A2%20Tidur%20Tepat%20Waktu');
          }
          else if (newsTitle == 'Pentingkah Mahasiswa Menjaga Kesehatan Mental?') {
            _launchURL('https://www.kompasiana.com/dayucinta4954/660257fede948f49b527a8e2/pentingnya-kesehatan-mental-di-kalangan-mahasiswa');
          }
           else if (newsTitle == 'Cara Mengatasi Kulit Kering saat Puasa yang Bisa Dilakukan') {
            _launchURL('https://www.siloamhospitals.com/informasi-siloam/artikel/cara-mengatasi-kulit-kering-saat-puasa');
          }
          else if (newsTitle == 'Ini Tips Merawat Wajah saat Puasa, Tetap Sehat dan Cerah') {
            _launchURL('https://www.siloamhospitals.com/informasi-siloam/artikel/tips-merawat-wajah-saat-puasa?source=qr-code');
          }
          else if (newsTitle == '5 Efek Samping Masker Putih Telur untuk Wajah, Harus Tahu!') {
            _launchURL('https://www.siloamhospitals.com/informasi-siloam/artikel/efek-samping-putih-telur-untuk-wajah');
          }
        },
        child: Container(
          width: 300,
          child: Column(
            children: <Widget>[
              Container(
                height: 150, // Ubah tinggi gambar menjadi lebih kecil
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          newsTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
