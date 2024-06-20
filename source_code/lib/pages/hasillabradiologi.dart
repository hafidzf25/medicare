// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/isi_hasillab.dart';
import 'package:source_code/pages/isi_hasilradiologi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HasilLab(),
  ));
}

class HasilLab extends StatelessWidget {
  const HasilLab({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
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
                    Text("Hasil Lab & Radiologi",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                    Spacer(),
                    Image.asset(
                      'assets/icon/microscope.png',
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Hasil yang Akurat & Cepat untuk Perawatan Anda!",
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
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
            child: GestureDetector(
              onTap: () async {
                myAuth.dataLabProfilLain = [];
                await myAuth.getLabByIdDaftarProfil(
                    myAuth.dataProfil['id_daftar_profil']);
                for (var i = 0; i < myAuth.dataProfilLain.length; i++) {
                  await myAuth.getLabByIdDaftarProfilLain(
                      myAuth.dataProfilLain[i]['id_daftar_profil'],
                      myAuth.dataProfilLain[i]['id']);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Isi_HasilLab()),
                );
              },
              child: Container(
                  height: 80,
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
                          "assets/icon/hasillab.png",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Periksa Hasil Lab",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right_sharp),
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 40, right: 40),
            child: GestureDetector(
              onTap: () async {
                myAuth.dataRadiologiProfilLain = [];
                await myAuth.getRadiologiByIdDaftarProfil(
                    myAuth.dataProfil['id_daftar_profil']);
                for (var i = 0; i < myAuth.dataProfilLain.length; i++) {
                  await myAuth.getRadiologiByIdDaftarProfilLain(
                      myAuth.dataProfilLain[i]['id_daftar_profil'],
                      myAuth.dataProfilLain[i]['id']);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Isi_HasilRadiologi()),
                );
              },
              child: Container(
                  height: 80,
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
                          "assets/icon/hasilradio.png",
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Periksa Hasil Radiologi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right_sharp),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
