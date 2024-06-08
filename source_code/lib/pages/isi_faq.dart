import 'package:flutter/material.dart';

class Isi_FAQ extends StatelessWidget {
  final String question;
  final String answer;
  final List<String> imagePaths;

  const Isi_FAQ({
    super.key,
    required this.question,
    required this.answer,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> steps = answer.split("\n");
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.8; // 80% of screen width
    double imageHeight = imageWidth * 1; // Maintain aspect ratio (adjust as needed)

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
              SizedBox(width: 8),
              Text(
                "Pusat Bantuan",
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC1F4FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontFamily: 'Poppins-bold',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (index < imagePaths.length && imagePaths[index].isNotEmpty)
                    Image.asset(
                      imagePaths[index],
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
