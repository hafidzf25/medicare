// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Isi_HasilRadiologi(),
  ));
}

class Isi_HasilRadiologi extends StatelessWidget {
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
                "Hasil Pemeriksaan Radiologi",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Bold',
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
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF727173),
                          ),
                          hintText: 'Cari nama pasien',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Saya Sendiri",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
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
                                        borderRadius:
                                            BorderRadius.circular(300),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            "Umur",
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
                                            "Jenis Kelamin",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ": Rifky Afandi",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            ": 18",
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
                                            ": Pria",
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
                                    "Tes : Sinar-X Toraks",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.03),
                                  ),
                                  Text(
                                    "Hasil Sinar-X Toraks menunjukkan adanya fraktur pada tulang iga kiri ke-4 dan ke-5",
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.03),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Orang Lain",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
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
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          "assets/icon/person2.png",
                                          width: screenWidth * 0.18,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            "Umur",
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
                                            "Jenis Kelamin",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ": Anies Baswedan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            ": 50",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            ": 7 Mei 1969",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          Text(
                                            ": Pria",
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
                                    "Tes : Ultrasonografi Abdomen",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.03),
                                  ),
                                  Text(
                                    "Pemeriksaan ultrasonografi menunjukkan adanya batu empedu dengan diameter sekitar 1,2 cm.",
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.03),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
