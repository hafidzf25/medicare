// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:source_code/pages/igd.dart';
import 'package:source_code/pages/profil.dart';
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
                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icon/Cancel.png',
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Pusat Bantuan",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/icon/Ask.png',
                    ),
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
          )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: screenWidth * 0.9,
              height: 42,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextButton(
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Isi_FAQ()),
                    );
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Gimana sih cara buat reservasi untuk seseorang?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: screenWidth * 0.9,
              height: 42,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextButton(
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Isi_FAQ()),
                    );
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Bagaimana cara reservasi?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: screenWidth * 0.9,
              height: 42,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextButton(
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Isi_FAQ()),
                    );
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Informasi tentang dokter ada dimana ya?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: screenWidth * 0.9,
              height: 42,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextButton(
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Isi_FAQ()),
                    );
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Bagaimana cara mendaftarkan akun?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: screenWidth * 0.9,
              height: 42,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(8.0),
                child: TextButton(
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Isi_FAQ()),
                    );
                  },
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Bagaimana cara melihat jadwal dokter?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
