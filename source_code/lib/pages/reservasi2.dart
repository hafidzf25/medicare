// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/reservasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Reservasi2(),
  ));
}

class Reservasi2 extends StatelessWidget {
  const Reservasi2({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
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
                "Spesialis",
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
                  TextField(
                    decoration: InputDecoration(
                      hintText: ' Cari',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myAuth.dataSpesialis.length,
                    itemBuilder: (context, index) {
                      var Spesialis = myAuth.dataSpesialis[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Reservasi(
                                  spesialis: '${Spesialis['nama']}',
                                  id_spesialis: Spesialis['id'],
                                ),
                              ),
                            );
                          },
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
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "${Spesialis['nama']}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }
}
