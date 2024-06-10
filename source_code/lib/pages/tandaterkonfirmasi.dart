import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/main.dart';
import 'package:source_code/pages/reservasi_tab.dart';
import '../widgets/GreenButton.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var locale;
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Terkonfirmasi(),
  ));
}

class Terkonfirmasi extends StatelessWidget {
  Terkonfirmasi();

  // Initialize the ValueNotifier here
  final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AuthCubit myAuth = context.read<AuthCubit>();
    String locale = '';
    initializeDateFormatting('id_ID', locale);

    DateTime dateTime = DateTime.parse(myAuth.Reservasi['tanggal']);
    DateFormat dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    int idxJam = myAuth.hariKerja.indexWhere((element) => element['id'] == myAuth.Reservasi['id_jam_kerja_dokter']);

    var tanggal =  dateFormat.format(dateTime);
    var tempjam = myAuth.hariKerja[idxJam];
    idxJam = myAuth.dataJam.indexWhere((element) => element['id'] == tempjam['id_jam']);
    
    var jam = myAuth.dataJam[idxJam];
    var jamawal = jam['jam_awal'].substring(0,5);
    var jamakhir = jam['jam_akhir'].substring(0,5);

    return Scaffold(
      backgroundColor: Color(0xFFC1F4FF),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC1F4FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero, // Menghapus padding vertikal dari ListView
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0), // Ubah jarak di sini sesuai kebutuhan
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                              size: 60,
                            ),
                            Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
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
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${tanggal}, ${jamawal} - ${jamakhir}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Beta Medicare Bandung",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${myAuth.Dokter['nama']}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Biaya: Rp. ${myAuth.Reservasi['biaya']}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Mohon datang 15 menit lebih awal untuk check-in",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        100), // Menambahkan jarak antara kotak dan teks terakhir
                Text(
                  "Terimakasih telah memilih Rumah Sakit Beta Medicare",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                // Konfirmasi button
                GreenButton(
                  onTap: () {
                    bottomNavIndex.value = 1; // Indeks untuk ReservasiTab
                    // Action to perform when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(bottomNavIndex: bottomNavIndex)),
                    );
                  },
                  text: 'LIHAT JANJI TEMU',
                  width: screenWidth * 0.9,
                  height: 45,
                ),
                SizedBox(
                    height:
                        20), // Menambahkan jarak antara button sebelumnya dan button "Kembali ke Home"
                GreenButton(
                  onTap: () {
                    bottomNavIndex.value = 0; // Indeks untuk ReservasiTab
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(bottomNavIndex: bottomNavIndex)),
                    );
                  },
                  text: 'KEMBALI KE HOME',
                  width: screenWidth * 0.9,
                  height: 45,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
