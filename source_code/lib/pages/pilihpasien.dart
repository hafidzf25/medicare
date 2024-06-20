import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/periksajanjitemu.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PilihPasien(),
  ));
}

class PilihPasien extends StatefulWidget {
  PilihPasien(
      {super.key,
      this.tanggal = '',
      this.idxJadwal = 0,
      this.biaya = "Rp. 50.000"});
  String tanggal;
  String biaya;
  int idxJadwal;

  @override
  _PilihPasienState createState() => _PilihPasienState();
}

class _PilihPasienState extends State<PilihPasien> {
  bool isSelected = false;
  int idxSelected = 0;
  String nama = '';
  String tanggal_lahir = '';

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    DateTime dateTime =
        DateTime.parse(context.read<AuthCubit>().dataProfil['tanggal_lahir']);
    DateFormat dateFormat = DateFormat('d MMMM yyyy', 'id_ID');
    var tanggal = dateFormat.format(dateTime);

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
                "Pilih Profil Pasien",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20,
                ),
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saya Sendiri",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  idxSelected =
                                      myAuth.dataProfil['id_daftar_profil'];
                                  isSelected = true;
                                  nama = myAuth.dataProfil['nama'];
                                  tanggal_lahir =
                                      myAuth.dataProfil['tanggal_lahir'];
                                },
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                color: idxSelected ==
                                        myAuth.dataProfil['id_daftar_profil']
                                    ? Colors.blue
                                    : Colors.white,
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
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${context.read<AuthCubit>().dataProfil['nama']} - Saya Sendiri",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: idxSelected ==
                                                    myAuth.dataProfil[
                                                        'id_daftar_profil']
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "${tanggal}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: idxSelected ==
                                                      myAuth.dataProfil[
                                                          'id_daftar_profil']
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "${context.read<AuthCubit>().dataProfil['notelp']}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: idxSelected ==
                                                      myAuth.dataProfil[
                                                          'id_daftar_profil']
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Orang Lain",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myAuth.dataProfilLain.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(
                                myAuth.dataProfilLain[index]['tanggal_lahir']);
                            String tanggal = DateFormat('d MMMM yyyy', 'id_ID')
                                .format(dateTime);
                            return Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idxSelected = myAuth.dataProfilLain[index]
                                        ['id_daftar_profil'];
                                    isSelected = true;
                                    nama = myAuth.dataProfilLain[index]['nama'];
                                    tanggal_lahir =
                                        myAuth.dataProfilLain[index]['tanggal_lahir'];
                                  });
                                },
                                child: Container(
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: idxSelected ==
                                            myAuth.dataProfilLain[index]
                                                ['id_daftar_profil']
                                        ? Colors.blue
                                        : Colors.white,
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
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${myAuth.dataProfilLain[index]['nama']} - Orang Lain",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: idxSelected ==
                                                        myAuth.dataProfilLain[
                                                                index]
                                                            ['id_daftar_profil']
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                "${tanggal}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: idxSelected ==
                                                          myAuth.dataProfilLain[
                                                                  index][
                                                              'id_daftar_profil']
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GreenButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeriksaJanjiTemu(
                        biaya: widget.biaya,
                        tanggal: widget.tanggal,
                        idxJadwal: widget.idxJadwal,
                        nama: nama,
                        tanggal_lahir: tanggal_lahir,
                        idxDaftarProfil: idxSelected,
                      ),
                    ),
                  );
                },
                text: "Lanjut",
                width: screenWidth * 0.9,
                height: 45,
                isEnabled: isSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GreenButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isEnabled;

  const GreenButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = 320,
    this.height = 45,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _GreenButtonState createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      onTapDown: widget.isEnabled ? (_) => setState(() => _scale = 0.95) : null,
      onTapUp: widget.isEnabled ? (_) => setState(() => _scale = 1.0) : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_scale),
        child: Center(
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.isEnabled ? widget.backgroundColor : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
