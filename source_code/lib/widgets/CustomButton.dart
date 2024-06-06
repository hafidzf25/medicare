import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.iconData,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenWidth * 0.9, // Lebar kontainer tombol
        height: 55, // Tinggi kontainer tombol
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar belakang kontainer tombol
          borderRadius: BorderRadius.circular(
              10), // Membuat sudut kontainer tombol menjadi melengkung
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.5), // Warna bayangan dengan opasitas 50%
              spreadRadius: 2, // Radius penyebaran bayangan
              blurRadius: 3, // Radius blur bayangan
              offset: Offset(3, 3), // Posisi offset bayangan (x, y)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 15),
            Icon(
              iconData, // Icon di sisi kiri
              color: Colors.black, // Warna ikon
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                text, // Teks di tengah
                style: TextStyle(
                  fontSize: 16, // Ukuran teks
                  color: Colors.black, // Warna teks
                  fontWeight: FontWeight.bold, // Ketebalan teks
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios, // Icon panah ke kanan di sisi kanan
              color: Colors.black, // Warna ikon
            ),
            SizedBox(width: 15), // Atur jarak antara teks dan panah
          ],
        ),
      ),
    );
  }
}
