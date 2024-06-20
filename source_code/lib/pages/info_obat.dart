// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/main.dart';

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
    final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(1);
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
                    bottomNavIndex.value = 3;
                    // Kembali ke halaman sebelumnya
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyHomePage(bottomNavIndex: bottomNavIndex);
                        },
                      ),
                    );
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
      body: ListView.builder(
        itemCount: context.read<AuthCubit>().dataAkhirObat.length,
        itemBuilder: (context, index) {
          var obat = context.read<AuthCubit>().dataAkhirObat[index];
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/obat/${obat['foto']}"),
                      width: 100,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${obat['nama']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${obat['dosis']}",
                            ),
                            Text(
                              "${obat['pemakaian']}",
                            ),
                            Text(
                              "Perkiraan habis: ${obat['durasi']} hari",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Penyakit : ${obat['nama_penyakit']}",
                            ),
                            Text(
                              "Pasien : ${obat['nama_pasien']}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
