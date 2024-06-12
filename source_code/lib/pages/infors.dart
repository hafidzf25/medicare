import 'package:flutter/material.dart';
import 'package:source_code/pages/info.dart';
import 'package:source_code/pages/infosd.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: infoRS(),
  ));
}

class infoRS extends StatelessWidget {
  const infoRS({super.key});

  @override
  Widget build(BuildContext context) {
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
                GestureDetector(
                  onTap: () {
                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Informasi Rumah Sakit Kami",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Info()),
                );
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital, // Icon rumah sakit
                      ),
                      SizedBox(width: 10), // Jarak antara icon dan teks
                      Text(
                        "Informasi Rumah Sakit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.chevron_right_sharp),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 40, right: 40, bottom: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoSD()),
                );
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .medical_information_sharp, // Icon medical (rumah sakit)
                      ),
                      SizedBox(width: 10), // Jarak antara icon dan teks
                      Text(
                        "Spesialis & Dokter Kami",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(Icons.chevron_right_sharp),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
