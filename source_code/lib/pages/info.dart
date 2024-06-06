import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                "Tentang Kami",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins-Bold',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Image.asset(
                  'assets/images/rs-image.jpg', // Sesuaikan dengan nama file gambar Anda
                  width: screenWidth, // Adjust image width to screen width
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Beta Medicare Bandung',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Rumah sakit Beta Mediacere didirikan pada tahun 2009 di Bandung. Sebagai bagian dari visi perusahaan untuk memberikan pelayanan kesehatan berkualitas kepada masyarakat, rumah sakit ini dibangun dengan fasilitas modern dan tenaga medis yang kompeten. Sejak didirikan, rumah sakit Beta Mediacere telah menjadi salah satu tempat perawatan kesehatan terkemuka di wilayah tersebut, memberikan pelayanan yang berkualitas dan perhatian yang hangat kepada pasien-pasien mereka. Dengan dukungan teknologi mutakhir dan tim medis yang berpengalaman, rumah sakit ini telah menjadi salah satu pilihan utama bagi mereka yang mencari perawatan medis terpercaya di Bandung dan sekitarnya.',
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
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
                            Icons.add_location, // Icon rumah sakit
                            color: Colors.green,
                          ),
                          SizedBox(width: 10), // Jarak antara icon dan teks
                          Text(
                            "Alamat Rumah Sakit Kami",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 
 void _launchGoogleMaps() async {
    const url = 'https://www.google.com/maps/place/RSU+Hermina+Arcamanik/data=!4m7!3m6!1s0x2e68dd46e0715365:0xebb26d7575f70f99!8m2!3d-6.904194!4d107.666794!16s%2Fg%2F1hc2llztj!19sChIJZVNx4EbdaC4RmQ_3dXVtsus?authuser=0&hl=id&rclk=1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}