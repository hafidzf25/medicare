// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';

class Isi_HasilLab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
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
                "Hasil Pemeriksaan Lab",
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
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Saya Sendiri",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: myAuth.dataLabProfil.isEmpty
                            ? 1
                            : myAuth.dataLabProfil.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (myAuth.dataLabProfil.isEmpty) {
                            return Text("Tidak ada data Lab untuk Profil.");
                          } else {
                            var Pasien = myAuth.dataLabProfil[index];
                            return Padding(
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
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Nama",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Tanggal",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Jenis Kelamin",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": ${Pasien['nama_pasien']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ": ${Pasien['tanggal_lahir']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ": ${Pasien['jenis_kelamin']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(
                                          "${Pasien['nama_lab']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${Pasien['deskripsi_lab']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }
                        },
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
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myAuth.dataLabProfilLain.isEmpty
                            ? 1
                            : myAuth.dataProfilLain.length,
                        itemBuilder: (context, index) {
                          if (myAuth.dataLabProfilLain.isEmpty) {
                            return Text(
                                "Tidak ada data lab untuk Profil Lain.");
                          } else {
                            return Padding(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Nama",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Umur",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Tanggal",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Jenis Kelamin",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ": ${myAuth.dataLabProfilLain[index]['nama_pasien']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ": ${myAuth.dataLabProfilLain[index]['umur']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ": ${myAuth.dataLabProfilLain[index]['tanggal_lahir']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ": ${myAuth.dataLabProfilLain[index]['jenis_kelamin']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(
                                          "${myAuth.dataLabProfilLain[index]['nama_lab']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "${myAuth.dataLabProfilLain[index]['deskripsi_lab']}",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }
                        },
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
