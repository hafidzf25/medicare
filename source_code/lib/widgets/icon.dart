import 'package:flutter/material.dart';
import 'package:source_code/pages/hasillabradiologi.dart';
import 'package:source_code/pages/igd.dart';
import 'package:source_code/pages/infors.dart';
import 'package:source_code/pages/reservasi.dart';

class IconHome extends StatelessWidget {
  const IconHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(icon: "assets/icon/booking.png", name: "Buat\nReservasi"),
      CustomIcon(
          icon: "assets/icon/hospital-building.png",
          name: "Informasi\nRumah Sakit"),
      CustomIcon(
        icon: "assets/icon/ambulance.png",
        name: "IGD",
      ),
      CustomIcon(
          icon: "assets/icon/flask.png", name: "Hasil Lab\n dan Radiologi"),
      CustomIcon(
          icon: "assets/icon/medical-report.png", name: "Medical\nCheck-Up"),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Ubah nilai padding sesuai kebutuhan
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(customIcons.length, (index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index == 0) {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Reservasi()),
                    );
                  }
                  else if (index == 1) {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => infoRS()),
                   );
                  } else if (index == 2) {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IGD()),
                    );
                  } else if (index == 3) {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HasilLab()),
                    );
                  } else if (index == 4) {
                    // Fungsi yang akan dijalankan ketika tombol ditekan
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => IGD()),
                    // );
                  }
                },
                child: Container(
                  width: 65,
                  height: 65,
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    customIcons[index].icon,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                customIcons[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;
  CustomIcon({
    required this.icon,
    required this.name,
  });
}
