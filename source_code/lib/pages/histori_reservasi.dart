// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HistoryReservasi(),
  ));
}

class HistoryReservasi extends StatelessWidget {
  const HistoryReservasi({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
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
                "Histori Reservasi",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: IsiHistory(
        myAuth: myAuth,
      ),
    );
  }
}

class IsiHistory extends StatefulWidget {
  IsiHistory({super.key, required this.myAuth});

  final AuthCubit myAuth;

  @override
  State<IsiHistory> createState() => _IsiHistoryState();
}

class _IsiHistoryState extends State<IsiHistory> {
  bool profil = true;
  bool profillain = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Row(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        18), // Untuk membuat sudut melengkung
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 3, // Radius penyebaran bayangan
                        blurRadius: 3, // Radius blur bayangan
                        offset: Offset(2, 2), // Posisi bayangan (x, y)
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      AuthCubit myAuth = context.read<AuthCubit>();
                      await myAuth.getReservasiDoneByDaftarProfil(
                          myAuth.dataProfil['id_daftar_profil']);
                      setState(() {
                        // Fungsi yang akan dijalankan saat tombol ditekan
                        profillain = false;
                        profil = true;
                      });
                    },
                    clipBehavior: Clip.none,
                    child: Text(
                      'SAYA SENDIRI',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: profil ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          18), // Untuk membuat sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Warna bayangan
                          spreadRadius: 3, // Radius penyebaran bayangan
                          blurRadius: 3, // Radius blur bayangan
                          offset: Offset(2, 3), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () async {
                        AuthCubit myAuth = context.read<AuthCubit>();
                        myAuth.dataHistoryReservasi = [];
                        for (var i = 0; i < myAuth.dataProfilLain.length; i++) {
                          await myAuth.getReservasiDoneByDaftarProfilLain(
                              myAuth.dataProfilLain[i]['id_daftar_profil'],
                              myAuth.dataProfilLain[i]['id']);
                        }
                        setState(() {
                          // Fungsi yang akan dijalankan saat tombol ditekan
                          profillain = true;
                          profil = false;
                        });
                      },
                      clipBehavior: Clip.none,
                      child: Text(
                        'ORANG LAIN',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: profillain ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 40, right: 30, bottom: 10),
            child: Text(
              "JANJI TEMU YANG SUDAH TERJADI",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: context.read<AuthCubit>().dataHistoryReservasi.length,
            itemBuilder: (context, index) {
              var reserve = widget.myAuth.dataHistoryReservasi[index];
              DateTime date = DateTime.parse(reserve['tanggal']);
              String tanggal =
                  DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
              return Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.camera),
                        Text(
                          "${reserve['nama']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$tanggal, ${reserve['jam_awal']} - ${reserve['jam_akhir']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${reserve['dokter']}",
                        ),
                        Text(
                          "Spesialis ${reserve['spesialis']}",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
