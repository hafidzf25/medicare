// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/reservasi2.dart';
import 'package:source_code/pages/reservasi3.dart';
import '../main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Reservasi(),
  ));
}

class Reservasi extends StatelessWidget {
  const Reservasi(
      {super.key, this.spesialis = 'Pilih Spesialis', this.id_spesialis = 0});
  final String spesialis;
  final int id_spesialis;

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFC1F4FF),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          backgroundColor: Color(0xFF0D0A92),
          title: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10.0, bottom: 10, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Kembali ke halaman sebelumnya
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon/Cancel.png',
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text("Buat Reservasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Cari jadwal yang tepat dengan kebutuhan anda!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservasi2()),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      spesialis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
            child: GestureDetector(
              onTap: () async {
                if (id_spesialis == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Pilih spesialis untuk menampilkan daftar doktornya!',
                        style: GoogleFonts.poppins(),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  await myAuth.getdoktorbyspesialis(id_spesialis);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Reservasi3(
                        id_spesialis: id_spesialis,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xFF00C608),
                ),
                child: Center(
                  child: Text(
                    "CARI DOKTER",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
