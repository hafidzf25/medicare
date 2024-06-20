import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/faq.dart';
import 'package:source_code/pages/info_obat.dart';
import 'package:source_code/pages/landingPage.dart';
import 'package:source_code/pages/profilPasien.dart';
import 'package:source_code/pages/rekam_medis.dart';
import 'package:source_code/widgets/CustomButton.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Profil(),
  ));
}

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AuthCubit myAuth = context.read<AuthCubit>();
    final String? foto = myAuth.dataProfil['foto'];

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
            width: screenWidth,
            height: 195,
            color: const Color(0xFF0D0A92),
          ),
          Positioned(
            top: 85,
            left: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profil Saya',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                      backgroundImage: foto != null && foto.isNotEmpty
                          ? AssetImage("assets/images/$foto")
                          : null,
                      child: foto == null || foto.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 55, // Sesuaikan ukuran sesuai kebutuhan
                              color: Colors.black,
                            )
                          : null,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi ${myAuth.dataProfil['nama']}!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(''),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: 'Profil',
                  iconData: Icons.person,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPasien()),
                    ).then((updatedData) {
                      if (updatedData != null) {
                        setState(() {
                          myAuth.dataProfil = updatedData;
                        });
                      }
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Rekam Medis',
                  iconData: Icons.medical_services,
                  onPressed: () async {
                    await myAuth.getRekamMedisByDaftarProfil(
                        myAuth.dataProfil['id_daftar_profil']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RekamMedis()),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Info Obat',
                  iconData: Icons.medication_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoObat()),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Pusat Bantuan',
                  iconData: Icons.live_help,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQ()),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Keluar',
                  iconData: Icons.logout,
                  onPressed: () async {
                    await myAuth.logout();
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
