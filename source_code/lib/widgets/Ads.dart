import 'package:flutter/material.dart';

class Ads extends StatelessWidget {
const Ads({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){},
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ads1.jpg'), // Ganti dengan path gambar lokal Anda
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){},
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ads4.jpg'), // Ganti dengan path gambar lokal Anda
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){},
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ads7.jpg'), // Ganti dengan path gambar lokal Anda
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
          // Tambahkan lebih banyak widget di sini untuk scroll horizontal
        ],
      ),
    );
  }
}