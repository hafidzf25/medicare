import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IGD extends StatelessWidget {
  const IGD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/icon/Cancel.png',
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text("Instalasi Gawat Darurat",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                  Spacer(),
                  Image.asset(
                    'assets/icon/ambulancesigd.png',
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Hubungi layanan IGD segera jika darurat!",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, right: 40, left: 40, bottom: 20),
            child: GestureDetector(
              onTap: () {
                _makePhoneCall(context, '2-222-911');
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
                        offset: Offset(0, 3))
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hubungi Kami"),
                            Text(
                              "2-222-911",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF00C608),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 12, right: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 17,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Hubungi",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 40, right: 40),
            child: GestureDetector(
              onTap: () {
                    _launchGoogleMaps();
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
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Alamat Rumah Sakit Kami",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
              ),
            ),
          )
        ],
      ),
    );
  }

  void _makePhoneCall(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 100,
                  color: Colors.green,
                ),
                SizedBox(height: 20),
                Text(
                  'Menelepon $phoneNumber...',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _launchGoogleMaps() async {
    const url = 'https://www.google.com/maps/place/RSU+Hermina+Arcamanik/data=!4m7!3m6!1s0x2e68dd46e0715365:0xebb26d7575f70f99!8m2!3d-6.904194!4d107.666794!16s%2Fg%2F1hc2llztj!19sChIJZVNx4EbdaC4RmQ_3dXVtsus?authuser=0&hl=id&rclk=1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }