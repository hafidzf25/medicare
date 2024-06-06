import 'package:flutter/material.dart';

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
        onTap: (){},
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
}
