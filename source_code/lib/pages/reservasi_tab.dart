// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/histori_reservasi.dart';
import 'package:source_code/pages/rincian_reservasi.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservasiTab extends StatelessWidget {
  const ReservasiTab({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    AuthCubit myAuth = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFC1F4FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: const Color(0xFF0D0A92),
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Reservasi Saya",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC1F4FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          18), // Untuk membuat sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Warna bayangan
                          spreadRadius: 3, // Radius penyebaran bayangan
                          blurRadius: 3, // Radius blur bayangan
                          offset: const Offset(2, 2), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Fungsi yang akan dijalankan saat tombol ditekan
                      },
                      clipBehavior: Clip.none,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text(
                        'SAYA SENDIRI',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            18), // Untuk membuat sudut melengkung
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 3, // Radius penyebaran bayangan
                            blurRadius: 3, // Radius blur bayangan
                            offset:
                                const Offset(2, 3), // Posisi bayangan (x, y)
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Fungsi yang akan dijalankan saat tombol ditekan
                        },
                        clipBehavior: Clip.none,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text(
                          'ORANG LAIN',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                scrollbars: false,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.read<AuthCubit>().dataReservasi.length,
                itemBuilder: (context, index) {
                  var reserve = myAuth.dataReservasi[index];
                  DateTime date = DateTime.parse(reserve['tanggal']);
                  String tanggal = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);

                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RincianReservasi()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${myAuth.dataProfil['nama']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${tanggal}, ${reserve['jam_awal']} - ${reserve['jam_akhir']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${reserve['dokter']}",
                                  ),
                                  Text(
                                    "Spesialis A",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryReservasi()),
                  );
                },
                child: Text(
                  "LIHAT HISTORI RESERVASI",
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
