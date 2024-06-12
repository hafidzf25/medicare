// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Isi_HasilRadiologi(),
  ));
}

class Isi_HasilRadiologi extends StatelessWidget {
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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Saya Sendiri",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myAuth.dataRadiologiProfil.isEmpty
                            ? 1
                            : myAuth.dataRadiologiProfil.length,
                        itemBuilder: (context, index) {
                          if (myAuth.dataRadiologiProfil.isEmpty) {
                            return Text(
                                "Tidak ada data lab radiologi untuk profil.");
                          } else {
                            var Pasien = myAuth.dataRadiologiProfil[index];
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
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/${Pasien['foto']}",
                                              width:
                                                  120, // Adjust width as needed
                                              height:
                                                  120, // Adjust height as needed
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "Nama",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                "Umur",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                          
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Expanded(
                                                          flex: 6,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                ": ${Pasien['nama_pasien']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                ": ${Pasien['umur']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        "Tes : ${Pasien['nama_radiologi']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "${Pasien['deskripsi_radiologi']}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                        itemCount: myAuth.dataRadiologiProfilLain.isEmpty
                            ? 1
                            : myAuth.dataRadiologiProfilLain.length,
                        itemBuilder: (context, index) {
                          if (myAuth.dataRadiologiProfilLain.isEmpty) {
                            return Text(
                                "Tidak ada data lab radiologi untuk profil lain.");
                          } else {
                            var Pasien = myAuth.dataRadiologiProfilLain[index];
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
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/${Pasien['foto']}",
                                              width:
                                                  120, // Adjust width as needed
                                              height:
                                                  120, // Adjust height as needed
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "Nama",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                "Umur",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                          
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Expanded(
                                                          flex: 6,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                ": ${Pasien['nama_pasien']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                ": ${Pasien['umur']}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        "Tes : ${Pasien['nama_radiologi']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "${Pasien['deskripsi_radiologi']}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
