// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:source_code/pages/isi_hasillab.dart';
import 'package:source_code/pages/isi_hasilradiologi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InfoObat(),
  ));
}

class InfoObat extends StatelessWidget {
  const InfoObat({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Info Obat",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                    Spacer(),
                    Image.asset(
                      'assets/icon/Obat.png',
                    ),
                  ],
                ),
              ],
            ),
          )),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/dummy_obat.png",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Panadol",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "3 x 1 hari",
                          ),
                          Text(
                            "Setelah makan",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/dummy_obat.png",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paracetamol",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2 x 1 hari",
                          ),
                          Text(
                            "Setelah makan",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/dummy_obat.png",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Antibiotik",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "3 x 1 hari",
                          ),
                          Text(
                            "Setelah makan (Habiskan)",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 20),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/dummy_obat.png",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salep",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2 x 1 hari",
                          ),
                          Text(
                            "Oleskan ditempat yang disarankan",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
