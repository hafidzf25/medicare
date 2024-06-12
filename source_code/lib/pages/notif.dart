import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Notifikasi(),
  ));
}

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    AuthCubit myAuth = context.read<AuthCubit>();
    double screenWidth = MediaQuery.of(context).size.width;
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
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Notifikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 25,
                        )),
                    Spacer(),
                    Image.asset(
                      'assets/icon/notifikasi.png',
                    ),
                  ],
                ),
              ],
            ),
          )),
      body: ListView(
        children: [
          ListView.builder(
            itemCount: myAuth.dataNotifikasiProfil.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var notif = myAuth.dataNotifikasiProfil[index];
              DateTime date = DateTime.parse(notif['tanggal']);
              String tanggal =
                  DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
              return Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
                child: Container(
                  width: screenWidth * 0.9,
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
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF0D0A92),
                          ),
                          height: 190,
                          width: 95,
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Text(
                                  '"Halo ${notif['nama']}!, jangan lupa untuk melakukan janji temu bersama Dokter ${notif['dokter']} ya di hari ${tanggal} pada pukul ${notif['jam_awal']}!"',
                                  style: TextStyle(fontSize: 15),
                                  softWrap: true,
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
          ListView.builder(
            itemCount: myAuth.dataNotifikasiProfilLain.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var notif = myAuth.dataNotifikasiProfilLain[index];
              DateTime date = DateTime.parse(notif['tanggal']);
              String tanggal =
                  DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
              return Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
                child: Container(
                  width: screenWidth * 0.9,
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
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF0D0A92),
                          ),
                          width: 95,
                          height: 190,
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Text(
                                  '"Halo ${notif['nama']}!, jangan lupa untuk melakukan janji temu bersama Dokter ${notif['dokter']} ya di hari ${tanggal} pada pukul ${notif['jam_awal']}!"',
                                  style: TextStyle(fontSize: 15),
                                  softWrap: true,
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
          ListView.builder(
            itemCount: myAuth.dataAkhirObat.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var notifobat = myAuth.dataAkhirObat[index];
              return Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
                child: Container(
                  width: screenWidth * 0.9,
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
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF0D0A92),
                          ),
                          width: 95,
                          height: 190,
                          child: Icon(
                            Icons.medication_liquid_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Text(
                                  '"Halo ${notifobat['nama_pasien']}!, jangan lupa untuk mengonsumsi obat ${notifobat['nama']} ya di hari ini! Untuk info lengkap mengenai cara mengonsumsi obatnya terdapat di Info Obat!"',
                                  style: TextStyle(fontSize: 15),
                                  softWrap: true,
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
        ],
      ),
    );
  }
}
