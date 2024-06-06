// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import './faq.dart';



class Isi_FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                "Pusat Bantuan",
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
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Text(
                          "Bagaimana cara reservasi?",
                          style: TextStyle(
                              fontFamily: 'Poppins-bold',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Text("   1. Masuk ke menu Buat Reservasi", style: TextStyle(fontSize: 15),),
                      ),
                      Container(
                        child: Text("   2. Pilih Spesialis, kemudian cari dokter", style: TextStyle(fontSize: 15),),
                      ),
                      Container(
                        child: Text("   3. Pilih Dokter sesuai jadwal yang diinginkan", style: TextStyle(fontSize: 15),),
                      ),
                    ],
                  )
                )
              )
            ),
    );
  }
}
