import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:source_code/main.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/info_obat.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RincianReservasi(),
  ));
}

class RincianReservasi extends StatefulWidget {
  RincianReservasi(
      {super.key, this.status = 0, this.idDaftarProfil = 0, this.total = 0});

  int status;
  int idDaftarProfil;
  double total;

  @override
  _RincianReservasiState createState() => _RincianReservasiState();
}

class _RincianReservasiState extends State<RincianReservasi> {
  int currentStep = 0;
  String? selectedBank;
  Set<int> selectedDiagnoses = {};
  double totalMedicinePrice = 0;

  // Initialize the ValueNotifier here
  final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    totalMedicinePrice = widget.total;
    // Mengambil nilai status dari widget dan menaruhnya di currentStep
    currentStep = widget.status;
  }

  bool get isStep5 => currentStep == 4;

  void _advanceStep(int step) {
    setState(() {
      if (step == 2) {
        context.read<AuthCubit>().setStatusReservasiById(
            context.read<AuthCubit>().Reservasi['id'], 2);
        currentStep = 2;
      } else if (currentStep == 3 && step == 4) {
        currentStep = 4;
      } else {
        currentStep = step;
      }
    });
  }

  bool get isStep3 => currentStep == 2;
  bool get isStep4 => currentStep == 3;

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
              if (currentStep == 0) Text('Biaya: Rp. 50.000'),
              if (currentStep == 4)
                Text('Biaya: Rp. ${totalMedicinePrice / 2}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                AuthCubit myAuth = context.read<AuthCubit>();
                var Reservasi = context.read<AuthCubit>().Reservasi;

                if (currentStep == 4) {
                  bottomNavIndex.value = 1;
                  await context.read<AuthCubit>().setStatusReservasiById(
                      context.read<AuthCubit>().Reservasi['id'], 5);
                  await myAuth.getReservasiByDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);
                  await myAuth.getReservasiDoneByDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);
                  await myAuth.getRekamMedisByDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);

                  await myAuth.getObatByIdDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);

                  for (var i = 0; i < myAuth.dataProfilLain.length; i++) {
                    await myAuth.getObatByIdDaftarProfilLain(
                        myAuth.dataProfilLain[i]['id_daftar_profil'],
                        myAuth.dataProfilLain[i]['id']);
                  }

                  myAuth.dataNotifikasiProfilLain = [];
                  await myAuth.getNotifikasiByDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);
                  for (var i = 0; i < myAuth.dataProfilLain.length; i++) {
                    await myAuth.getNotifikasiByDaftarProfilLain(
                        myAuth.dataProfilLain[i]['id_daftar_profil'],
                        myAuth.dataProfilLain[i]['id']);
                  }

                  await Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return InfoObat();
                    },
                  ));
                } else {
                  Navigator.pop(context);
                  var Reservasi = context.read<AuthCubit>().Reservasi;
                  context
                      .read<AuthCubit>()
                      .setStatusReservasiById(Reservasi['id'], 1);
                  _advanceStep(
                      1); // Advance to the next step after confirming payment
                }
              },
              child: Text('KONFIRMASI'),
            ),
          ],
        );
      },
    );
  }

  void _showCancellationConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembatalan'),
          content: Text('Apakah Anda yakin ingin membatalkan reservasi ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _cancelReservation(); // Cancel the reservation
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelReservation() async {
    AuthCubit myAuth = context.read<AuthCubit>();
    await myAuth.deleteReservasi(myAuth.Reservasi['id']);
    await myAuth
        .getReservasiByDaftarProfil(myAuth.dataProfil['id_daftar_profil']);
    await myAuth
        .getReservasiDoneByDaftarProfil(myAuth.dataProfil['id_daftar_profil']);
    bottomNavIndex.value = 1; // Indeks untuk ReservasiTab
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePage(bottomNavIndex: bottomNavIndex)),
      (Route<dynamic> route) => false,
    );
  }

  void _showLoadingScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          _advanceStep(3); // Advance to step 4 after loading
        });

        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Menunggu diagnosis dokter"),
            ],
          ),
        );
      },
    );
  }

  void _toggleDiagnosisSelection(int diagnosis) {
    setState(() {
      if (selectedDiagnoses.contains(diagnosis)) {
        selectedDiagnoses.remove(diagnosis);
      } else {
        selectedDiagnoses.add(diagnosis);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    double screenWidth = MediaQuery.of(context).size.width;

    List<String> stepDescriptions = [
      "Silahkan lakukan pembayaran",
      "Pindai kode QR untuk Check In",
      "Silahkan klik tombol Check In",
      "Silahkan pilih diagnosis",
      "Silahkan lakukan pembayaran obat",
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
                onPressed: () async {
                  bottomNavIndex.value = 1;
                  await context.read<AuthCubit>().getReservasiByDaftarProfil(
                      myAuth.dataProfil['id_daftar_profil']);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyHomePage(bottomNavIndex: bottomNavIndex);
                      },
                    ),
                  );
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
                  width: screenWidth * 0.9,
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
          if (currentStep < 3 && currentStep >= 1)
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: currentStep == 2
                    ? Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.green,
                      )
                    : currentStep == 3 && currentStep != 5
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              _advanceStep(2);
                            },
                            child: Image.asset(
                              "assets/icon/QR.png",
                              alignment: Alignment.center,
                            ),
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
                  children: List.generate(5, (index) {
                    return GestureDetector(
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
                          if (index < 4)
                            Container(
                              width: 45,
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
                width: screenWidth * 0.9,
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
                                : currentStep == 2
                                    ? "Menunggu Check In"
                                    : "Pilih sesuai dengan hasil rawat jalan",
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
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 30,
                right: 30,
                bottom: 4,
              ),
              child: Text("INFORMASI PASIEN"),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
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
                          "${myAuth.Reservasi['nama']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 30,
                bottom: 4,
              ),
              child: Text("INFORMASI JANJI TEMU"),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
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
                          "${myAuth.Reservasi['tanggal']}, ${myAuth.Reservasi['jam_awal']} - ${myAuth.Reservasi['jam_akhir']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 30,
                bottom: 4,
              ),
              child: Text("INFORMASI BIAYA OPERASIONAL"),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
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
                          "${myAuth.Reservasi['biaya']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (isStep4)
            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
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
                          "Diagnosis",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myAuth.dataPenyakitReservasi.length,
                          itemBuilder: (context, index) {
                            var Penyakit = myAuth.dataPenyakitReservasi[index];
                            return GestureDetector(
                              onTap: () =>
                                  _toggleDiagnosisSelection(Penyakit['id']),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      selectedDiagnoses.contains(Penyakit['id'])
                                          ? Colors.blue
                                          : Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text('${Penyakit['nama']}'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (isStep5)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  width: screenWidth * 0.9,
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
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Obat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Menampilkan informasi obat secara dinamis
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: myAuth.dataObatReservasi.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var obat = myAuth.dataObatReservasi[index];
                            totalMedicinePrice += obat['harga'];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(obat['nama']),
                                Text("Rp. ${obat['harga']}"),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Menampilkan total harga obat secara dinamis
                            Text(
                              "Rp. $totalMedicinePrice",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _showBankSelectionDialog();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.green,
                              ),
                              child: Text(
                                "BAYAR DISINI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (currentStep < 4)
            Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 10),
              child: GestureDetector(
                onTap: () async {
                  if (isStep3) {
                    myAuth.dataPenyakitReservasi = [];
                    selectedDiagnoses = {};
                    await myAuth.getPenyakitDariObatByIdSpesialis(
                        myAuth.Reservasi['id_spesialis']);
                    await myAuth.setStatusReservasiById(
                        myAuth.Reservasi['id'], 3);
                    _showLoadingScreen(); // Show loading screen before advancing to step 4
                  } else if (isStep4 && selectedDiagnoses.isNotEmpty) {
                    myAuth.setStatusReservasiById(myAuth.Reservasi['id'], 4);
                    totalMedicinePrice = 0;
                    List<int> listDiagnosa = selectedDiagnoses.toList();
                    myAuth.dataObatReservasi = [];
                    myAuth.tempDataObat = {};
                    for (var i = 0; i < listDiagnosa.length; i++) {
                      await myAuth.getObatByIdPenyakit(listDiagnosa[i]);
                    }

                    Set<String> namaObat = {};
                    Set<Map<String, dynamic>> obatUnik = {};

                    for (var item in myAuth.tempDataObat) {
                      if (!namaObat.contains(item['nama'])) {
                        namaObat.add(item['nama']);
                        obatUnik.add(item);
                      }
                    }

                    myAuth.dataObatReservasi = obatUnik.toList();

                    for (var i = 0; i < myAuth.dataObatReservasi.length; i++) {
                      totalMedicinePrice +=
                          myAuth.dataObatReservasi[i]['harga'];
                    }

                    for (var i = 0; i < listDiagnosa.length; i++) {
                      await myAuth.postDaftarPenyakitProfil(
                          widget.idDaftarProfil,
                          listDiagnosa[i],
                          myAuth.Reservasi['id']);
                    }

                    // Perform action after selecting diagnosis
                    // Advance to the next screen or perform any other action
                    _advanceStep(4);
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
                        : isStep4 && selectedDiagnoses.isNotEmpty
                            ? Colors.green
                            : Colors.black.withOpacity(0.4),
                  ),
                  child: Center(
                    child: Text(
                      isStep4 ? "SELANJUTNYA" : "CHECK IN",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!isStep4 && !isStep5)
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: GestureDetector(
                  onTap: _showCancellationConfirmationDialog,
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
