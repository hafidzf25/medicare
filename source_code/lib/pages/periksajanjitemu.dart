import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import '../widgets/GreenButton.dart';
import 'package:source_code/pages/tandaterkonfirmasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PeriksaJanjiTemu(),
  ));
}

class PeriksaJanjiTemu extends StatefulWidget {
  PeriksaJanjiTemu(
      {super.key,
      this.tanggal = "0000-00-00",
      this.biaya = "Rp.20.000",
      this.idxJadwal = 0,
      this.nama = '',
      this.tanggal_lahir = '', this.idxDaftarProfil = 0});
  String tanggal;
  int idxJadwal;
  String biaya;
  String nama;
  String tanggal_lahir;
  int idxDaftarProfil;

  @override
  _PeriksaJanjiTemuState createState() => _PeriksaJanjiTemuState();
}

class _PeriksaJanjiTemuState extends State<PeriksaJanjiTemu> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    print(myAuth.dataProfil);
    print(myAuth.dataProfilLain);
    DateTime dateTime =
        DateTime.parse(context.read<AuthCubit>().dataProfil['tanggal_lahir']);
    DateFormat dateFormat = DateFormat('d MMMM yyyy', 'id_ID');
    var tanggal = dateFormat.format(dateTime);

    String locale = '';
    initializeDateFormatting('id_ID', locale);

    DateTime dateTime2 = DateTime.parse(widget.tanggal);
    DateFormat dateFormat2 = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    int idxJam = myAuth.hariKerja
        .indexWhere((element) => element['id'] == widget.idxJadwal);

    var tanggalreservasi = dateFormat2.format(dateTime2);
    var tempjam = myAuth.hariKerja[idxJam];
    idxJam = myAuth.dataJam
        .indexWhere((element) => element['id'] == tempjam['id_jam']);

    var jam = myAuth.dataJam[idxJam];
    var jamawal = jam['jam_awal'].substring(0, 5);
    var jamakhir = jam['jam_akhir'].substring(0, 5);

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
                                  "${widget.nama}",
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
                                  "${widget.tanggal_lahir}",
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
                                  "${myAuth.dataProfil['notelp']}",
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
                                  "${tanggalreservasi} ${jamawal}-${jamakhir}",
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
                                  "${myAuth.Dokter['nama']}",
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
                                  "${myAuth.Spesialis['nama']}",
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
                                "${widget.biaya}",
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
                    onTap: () async {
                      await myAuth.postReservasi(
                          widget.tanggal,
                          widget.idxJadwal,
                          widget.idxDaftarProfil,
                          widget.biaya);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Terkonfirmasi(),
                        ),
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
