import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/landingPage.dart';

import '../widgets/CustomButton.dart';

import 'faq.dart';
import 'profilPasien.dart';
import 'rekam_medis.dart';
import 'info_obat.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Profil(),
  ));
}

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFC1F4FF), Colors.white],
              ),
            ),
          ),
          Container(
            width: screenWidth, // Lebar persegi panjang
            height: 195, // Tinggi persegi panjang
            color: const Color(0xFF0D0A92), // Warna persegi panjang
          ),
          Positioned(
            top: 85, // Atur jarak dari atas untuk "Profil Circle"
            left: 25, // Atur jarak dari kiri untuk "Profil Circle"
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profil Saya',
                  style: TextStyle(
                    fontSize: 24, // Ukuran teks
                    fontWeight: FontWeight.bold, // Ketebalan teks
                    color: Colors.white, // Warna teks
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFD9D9D9),
                      backgroundImage: AssetImage("assets/images/${context.read<AuthCubit>().dataProfil['foto']}"),
                      child: const Icon(
                        Icons.person, // Icon yang ingin ditampilkan
                        size: 1, // Ukuran ikon
                        color: Colors.black, // Warna ikon
                      ),
                    ),
                    const SizedBox(
                        width: 20), // Atur jarak antara "CircleAvatar" dan "Hi"
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi ${context.read<AuthCubit>().dataProfil['nama']}!', // Teks "Hi"
                          style: const TextStyle(
                            fontSize: 20, // Ukuran teks
                            fontWeight: FontWeight.bold, // Ketebalan teks
                            color: Colors.white, // Warna teks
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          '',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Atur jarak antara "Hi" dan tombol
                CustomButton(
                  text: 'Profil',
                  iconData: Icons.person,
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPasien()),
                    );
                  },
                ),
                const SizedBox(height: 15), // Atur jarak antara "Hi" dan tombol
                CustomButton(
                  text: 'Rekam Medis',
                  iconData: Icons.medical_services,
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RekamMedis()),
                    );
                  },
                ),
                const SizedBox(height: 15), // Atur jarak antara "Hi" dan tombol
                CustomButton(
                  text: 'Info Obat',
                  iconData: Icons.medication_rounded,
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoObat()),
                    );
                  },
                ),
                const SizedBox(height: 15), // Atur jarak antara "Hi" dan tombol
                CustomButton(
                  text: 'Pusat Bantuan',
                  iconData: Icons.live_help,
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQ()),
                    );
                  },
                ),
                const SizedBox(height: 15), // Atur jarak antara "Hi" dan tombol
                CustomButton(
                  text: 'Keluar',
                  iconData: Icons.logout,
                  onPressed: () {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
