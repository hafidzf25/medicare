import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
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
                  ]),
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
                      height: 110,
                      width: 95,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Expanded(
                      child: Text(
                        '"Halo, jangan lupa bahwa Anda memiliki janji temu dengan dr. Shidiq. Pastikan untuk mempersiapkan diri dan datang tepat waktu. Kesehatan adalah prioritas utama. Semoga hari Anda menyenangkan!"',
                        style: TextStyle(fontSize: 15),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
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
                  ]),
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
                      height: 110,
                      width: 95,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Expanded(
                      child: Text(
                        '"Halo, jangan lupa bahwa Anda memiliki janji temu dengan dr. Shidiq. Pastikan untuk mempersiapkan diri dan datang tepat waktu. Kesehatan adalah prioritas utama. Semoga hari Anda menyenangkan!"',
                        style: TextStyle(fontSize: 15),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
