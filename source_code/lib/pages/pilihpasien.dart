import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_code/pages/periksajanjitemu.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PilihPasien(),
  ));
}

class PilihPasien extends StatefulWidget {

  PilihPasien({this.tanggal = '', this.idxJadwal = 0, this.biaya = "Rp. 30.000"}) :super();
  String tanggal;
  String biaya;
  int idxJadwal;

  @override
  _PilihPasienState createState() => _PilihPasienState();
}

class _PilihPasienState extends State<PilihPasien> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // print(widget.tanggal);
    // print(widget.biaya);
    // print(widget.idxJadwal);
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
                "Pilih Profil Pasien",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saya Sendiri",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSelected1 = !_isSelected1;
                                if (_isSelected1) {
                                  _isSelected2 = false;
                                }
                              });
                            },
                            child: Container(
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                color: _isSelected1 ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rifky Affandy - Saya Sendiri",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: _isSelected1
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "30 Februari 1996",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: _isSelected1
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "081234567890",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: _isSelected1
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Orang Lain",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSelected2 = !_isSelected2;
                                if (_isSelected2) {
                                  _isSelected1 = false;
                                }
                              });
                            },
                            child: Container(
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                color: _isSelected2 ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rifky Affandy - Orang Lain",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: _isSelected2
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "30 Februari 1996",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: _isSelected2
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "081234567890",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: _isSelected2
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GreenButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PeriksaJanjiTemu()),
                  );
                },
                text: "Lanjut",
                width: screenWidth * 0.9,
                height: 45,
                isEnabled: _isSelected1 || _isSelected2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GreenButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isEnabled;

  const GreenButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = 320,
    this.height = 45,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _GreenButtonState createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      onTapDown: widget.isEnabled
          ? (_) => setState(() => _scale = 0.95)
          : null,
      onTapUp: widget.isEnabled
          ? (_) => setState(() => _scale = 1.0)
          : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_scale),
        child: Center(
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? widget.backgroundColor
                  : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
