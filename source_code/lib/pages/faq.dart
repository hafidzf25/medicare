import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './isi_faq.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FAQ(),
  ));
}

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFC1F4FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 160,
        backgroundColor: Color(0xFF0D0A92),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/icon/Cancel.png'),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Pusat Bantuan",
                    style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  Spacer(),
                  Image.asset('assets/icon/Ask.png'),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Temukan pertanyaan yang mungkin belum anda ketahui",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            faqButton(context, screenWidth, 
              "Bagaimana cara membuat reservasi untuk seseorang?", 
              "1. Masuk ke menu Buat Reservasi\n2. Pilih Spesialis\n3. Kemudian cari dokter\n4. Pilih Dokter sesuai jadwal yang diinginkan\n5. Pilih salah satu profil orang lain", 
              ["assets/images/klikreservasi.jpg", "assets/images/spesialis.jpg", "assets/images/dok.jpg", "assets/images/jadwal.jpg", "assets/images/lain.jpg"]),
            SizedBox(height: 10),
            faqButton(context, screenWidth, 
              "Bagaimana cara reservasi?", 
              "1. Masuk ke menu Buat Reservasi\n2. Pilih Spesialis\n3. Kemudian cari dokter\n4. Pilih Dokter sesuai jadwal yang diinginkan\n5. Pilih saya sendiri", 
              ["assets/images/klikreservasi.jpg", "assets/images/spesialis.jpg", "assets/images/dok.jpg", "assets/images/jadwal.jpg", "assets/images/saya.png"]),
            SizedBox(height: 10),
            faqButton(context, screenWidth, 
              "Informasi tentang dokter dan spesialis ada dimana?", 
              "1. Masuk ke informasi rumah sakit\n2. Pilih Spesialis & Dokter Kami\n3. Pilih salah satu spesialis\n4. Dokter ditampilkan.", 
              ["assets/images/infors.jpg", "assets/images/sd.jpg", "assets/images/sp.jpg", "assets/images/dt.jpg"]),
            SizedBox(height: 10),
            faqButton(context, screenWidth, 
              "Bagaimana cara mendaftarkan akun untuk orang lain?", 
              "1. Masuk ke profil\n2. Pilih 'Profil'\n3. Pilih tambah profil lain", 
              ["assets/images/pro.jpg", "assets/images/prof.png", "assets/images/profi.png"]),
            SizedBox(height: 10),
            faqButton(context, screenWidth, 
              "Bagaimana cara membatalkan reservasi?", 
              "1. Masuk ke menu Reservasi\n2. Pilih reservasi yang ingin dibatalkan\n3. Klik 'Batalkan Reservasi'", 
              ["assets/images/reserve.jpg", "assets/images/vasi.png", "assets/images/batal.jpg"]),
          ],
        ),
      ),
    );
  }

  Widget faqButton(BuildContext context, double screenWidth, String question, String answer, List<String> imagePaths) {
    return Container(
      width: screenWidth * 0.9,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Isi_FAQ(question: question, answer: answer, imagePaths: imagePaths),
              ),
            );
          },
          style: ButtonStyle(alignment: Alignment.centerLeft),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),

              Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
