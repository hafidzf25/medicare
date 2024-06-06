import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:source_code/pages/registrationPage.dart';

class VerifikasiWA extends StatefulWidget {
  final String generatedOTP;
  final String email;

  const VerifikasiWA({Key? key, required this.generatedOTP, required this.email}) : super(key: key);

  @override
  State<VerifikasiWA> createState() => _VerifikasiWAState();
}

class _VerifikasiWAState extends State<VerifikasiWA> {
  bool isTimerFinished = false;
  bool isTimeUp = false;
  String otpCode = "";

  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;
  late FocusNode _focusNode4;
  late FocusNode _focusNode5;
  late FocusNode _focusNode6;

  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
    _focusNode5 = FocusNode();
    _focusNode6 = FocusNode();
    simulateOtpInput();
  }

  void simulateOtpInput() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      otpCode = widget.generatedOTP;
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    super.dispose();
  }

  void resetOtpCode() {
    setState(() {
      otpCode = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFC1F4FF), Colors.white],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 25.0,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verifikasi OTP',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C0A91),
                  ),
                ),
                SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Masukkan ',
                      ),
                      TextSpan(
                        text: '6 digit kode ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'yang dikirimkan ke',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: widget.email,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' melalui email. ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' Kirim ulang',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'kode jika tidak mendapatkan kode dalam ',
                      ),
                      TextSpan(
                        text: ' 2 menit.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Waktu Tersisa: ',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    isTimerFinished
                        ? Text(
                            '00 : 00 : 00',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : CountdownTimer(
                            endTime: DateTime.now().millisecondsSinceEpoch + 120000, // 2 menit
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                            onEnd: () {
                              setState(() {
                                isTimerFinished = true;
                                isTimeUp = true; // Set isTimeUp to true when the time is up
                              });
                            },
                          ),
                  ],
                ),
                SizedBox(height: 40), // Space between Countdown Timer and OTP Verification
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display 6 input boxes for OTP
                    buildOtpTextField(_focusNode1, 0),
                    buildOtpTextField(_focusNode2, 1),
                    buildOtpTextField(_focusNode3, 2),
                    buildOtpTextField(_focusNode4, 3),
                    buildOtpTextField(_focusNode5, 4),
                    buildOtpTextField(_focusNode6, 5),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: GestureDetector(
              onTap: () {
                // Perform OTP verification using the entered code
                if (isTimeUp) { // Check if the time is up
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Waktu Habis'),
                        content: Text('Waktu untuk verifikasi telah habis. Silakan coba lagi.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else if (otpCode == widget.generatedOTP) { // Check if the OTP is 6 characters
                    // OTP matches, navigate to the home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                } else {
                  // OTP does not match, reset OTP
                  setState(() {
                    resetOtpCode(); // Reset OTP if verification fails
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Verifikasi Gagal'),
                        content: Text('Kode OTP yang Anda masukkan salah. Silakan coba lagi.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  'VERIFIKASI',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtpTextField(FocusNode focusNode, int index) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: (value) {
          // Save the entered OTP code into the otpCode variable
          setState(() {
            if (value.length == 1) {
              if (otpCode.length < 6) {
                otpCode += value;
              }
              _moveToNextTextField(focusNode); // Move to the next input box after entering a character
            }
          });
        },
        textAlign: TextAlign.center,
        maxLength: 1, // Limit input length to 1 character
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counter: Offstage(), // Hide character counter
          border: InputBorder.none,
        ),
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        controller: TextEditingController(text: otpCode.length > index ? otpCode[index] : ''),
      ),
    );
  }

  void _moveToNextTextField(FocusNode focusNode) {
    if (focusNode == _focusNode1) {
      FocusScope.of(context).requestFocus(_focusNode2);
    } else if (focusNode == _focusNode2) {
      FocusScope.of(context).requestFocus(_focusNode3);
    } else if (focusNode == _focusNode3) {
      FocusScope.of(context).requestFocus(_focusNode4);
    } else if (focusNode == _focusNode4) {
      FocusScope.of(context).requestFocus(_focusNode5);
    } else if (focusNode == _focusNode5) {
      FocusScope.of(context).requestFocus(_focusNode6);
    }
  }
}