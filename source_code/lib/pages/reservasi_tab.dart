import 'package:flutter/material.dart';
import 'package:source_code/pages/histori_reservasi.dart';
import 'package:source_code/pages/periksajanjitemu.dart';
import 'package:source_code/pages/rekam_medis.dart';
import 'package:source_code/pages/rincian_reservasi.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReservasiTab(),
  ));
}

class ReservasiTab extends StatelessWidget {
  const ReservasiTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFC1F4FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: Color(0xFF0D0A92),
        title: Padding(
          padding: EdgeInsets.only(top: 50),
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
                "Reservasi Saya",
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
              padding:
                  EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RincianReservasi()),
                  );
                },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rifky Affandy",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rabu, 14 Jan 2021, 12:30 - 12:50",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "dr. Legi Kustiah",
                            ),
                            Text(
                              "Spesialis Kulit",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryReservasi()),
                  );
                },
                child: Text(
                  "LIHAT HISTORI RESERVASI",
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
