import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:source_code/pages/reservasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RincianReservasi(),
  ));
}

class RincianReservasi extends StatefulWidget {
  const RincianReservasi({super.key});

  @override
  _RincianReservasiState createState() => _RincianReservasiState();
}

class _RincianReservasiState extends State<RincianReservasi> {
  int currentStep = 0;
  String? selectedBank;

  void _advanceStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  bool get isStep3 => currentStep == 2;

  void _showBankSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silahkan Pilih Bank'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedBank,
                    hint: Text('Pilih Bank'),
                    items: [
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/bca.png', width: 24),
                            SizedBox(width: 10),
                            Text('BCA'),
                          ],
                        ),
                        value: 'BCA',
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/mandiri.png', width: 24),
                            SizedBox(width: 10),
                            Text('MANDIRI'),
                          ],
                        ),
                        value: 'MANDIRI',
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/danamon.png', width: 24),
                            SizedBox(width: 10),
                            Text('DANAMON'),
                          ],
                        ),
                        value: 'DANAMON',
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/bri.png', width: 24),
                            SizedBox(width: 10),
                            Text('BRI'),
                          ],
                        ),
                        value: 'BRI',
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/bni.png', width: 24),
                            SizedBox(width: 10),
                            Text('BNI'),
                          ],
                        ),
                        value: 'BNI',
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedBank = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedBank != null) {
                  Navigator.of(context).pop();
                  _showPaymentConfirmationDialog();
                }
              },
              child: Text('LANJUT'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Menggunakan Bank $selectedBank'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Biaya Rp. 20000'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _advanceStep(1); // Advance to the next step after confirming payment
              },
              child: Text('KONFIRMASI'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<String> stepDescriptions = [
      "Silahkan lakukan pembayaran",
      "Pindai kode QR untuk Check In",
      "Silahkan klik tombol Check In",
    ];

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
                "Rincian Reservasi",
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
      body: ListView(
        children: [
          if (currentStep == 0)
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Container(
                  width: 400,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Silahkan Bayar Disini",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _showBankSelectionDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "BAYAR",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (currentStep >= 1)
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: currentStep == 2
                    ? Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.green,
                      )
                    : Image.asset(
                        "assets/icon/QR.png",
                        alignment: Alignment.center,
                      ),
              ),
            ),
          if (currentStep >= 1 && currentStep < 2)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text("KODE BOOKING"),
              ),
            ),
          if (currentStep >= 1 && currentStep < 2)
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Center(
                child: Text(
                  "QVNM7I",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (currentStep >= 1 && currentStep < 2)
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Center(
                child: Text("Pindai kode QR untuk Check In"),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _advanceStep(index),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: currentStep >= index
                                ? Colors.blue
                                : Colors.white,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: currentStep >= index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          if (index < 2)
                            Container(
                              width: 113,
                              height: 2,
                              color: currentStep > index
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                width: 400,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDC8),
                  borderRadius: BorderRadius.circular(10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stepDescriptions[currentStep],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentStep == 0
                            ? "Menunggu pembayaran"
                            : currentStep == 1
                                ? "Menunggu verifikasi pasien"
                                : "Menunggu Check In",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
              bottom: 4,
            ),
            child: Text("INFORMASI PASIEN"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rifky Affandy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
              bottom: 4,
            ),
            child: Text("INFORMASI JANJI TEMU"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rabu, 14 Feb 2024, 12:30 - 12:50",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
              bottom: 4,
            ),
            child: Text("INFORMASI BIAYA OPERASIONAL"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rp. 20000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 10),
            child: GestureDetector(
              onTap: () {
                if (isStep3) {
                  // Perform Check-In action
                  // You can define what happens when the button is clicked in step 3 here
                  print('Checked In');
                }
              },
              child: Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                width: screenWidth * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: isStep3
                      ? Colors.green
                      : Colors.black.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(
                    "CHECK IN",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Function to be executed when text is tapped
                  // Place the action you want to perform when the text is tapped here
                },
                child: Text(
                  'BATALKAN RESERVASI',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
