import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/GreenButton.dart';
import 'package:source_code/pages/tandaterkonfirmasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PeriksaJanjiTemu(),
  ));
}

class PeriksaJanjiTemu extends StatefulWidget {
  @override
  _PeriksaJanjiTemuState createState() => _PeriksaJanjiTemuState();
}

class _PeriksaJanjiTemuState extends State<PeriksaJanjiTemu> {
  bool selected = false;

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
                "Periksa Janji Temu",
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
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Silahkan periksa kembali detail janji temu untuk memastikan kesesuaian informasi sebelum Anda melakukan konfirmasi.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "INFORMASI PASIEN",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "NAMA",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 10),
                                child: Text(
                                  "Rifky Affandy",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "TANGGAL LAHIR",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "30 Februari 1996",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "NOMOR PONSEL",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "081234567890",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "EMAIL",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "rifkytech@gmail.com",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "INFORMASI JANJI TEMU",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RUMAH SAKIT",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 10),
                                child: Text(
                                  "Beta Mediacare Bandung",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "WAKTU TEMU",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Rabu, 14 Februari 2024 12:30-12:50",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "DOKTER",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "dr. Abdul Hafidz",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "SPESIALIS",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Dermatologi (Kulit) - Spesialis Kulit",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BIAYA OPERASIONAL",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "Rp. 20000",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  // Konfirmasi button
                  GreenButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Terkonfirmasi()),
                      );
                    },
                    text: 'KONFIRMASI',
                    width: screenWidth * 0.9,
                    height: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
