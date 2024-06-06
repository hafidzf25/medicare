// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:source_code/pages/reservasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RekamMedis(),
  ));
}

class RekamMedis extends StatelessWidget {
  const RekamMedis({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFC1F4FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Color(0xFF0D0A92),
        title: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Rekam Medis",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC1F4FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          18), // Untuk membuat sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Warna bayangan
                          spreadRadius: 3, // Radius penyebaran bayangan
                          blurRadius: 3, // Radius blur bayangan
                          offset: Offset(2, 2), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Fungsi yang akan dijalankan saat tombol ditekan
                      },
                      clipBehavior: Clip.none,
                      child: Text(
                        'SAYA SENDIRI',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            18), // Untuk membuat sudut melengkung
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 3, // Radius penyebaran bayangan
                            blurRadius: 3, // Radius blur bayangan
                            offset: Offset(2, 3), // Posisi bayangan (x, y)
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Fungsi yang akan dijalankan saat tombol ditekan
                        },
                        clipBehavior: Clip.none,
                        child: Text(
                          'ORANG LAIN',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: Image.asset(
                                "assets/icon/person1.jpg",
                                width: screenWidth * 0.18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nama",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                                Text(
                                  "Tanggal",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                                Text(
                                  "Nama Dokter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ": Rifky Afandi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                                Text(
                                  ": 29 Februari 1996",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                                Text(
                                  ": Dr Legi Kustiah",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Text(
                          "Penyakit : Demam Tinggi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.03),
                        ),
                        Text(
                          "Obat        : Panadol",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.03),
                        ),
                        Text(
                          "Tindakan : Rawat Jalan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.03),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
