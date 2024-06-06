import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/pilihpasien.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PilihTanggal(),
  ));
}

class PilihTanggal extends StatefulWidget {
  PilihTanggal({super.key, this.id_dokter = 0});
  final id_dokter;

  @override
  _PilihTanggalState createState() => _PilihTanggalState(id_dokter: id_dokter);
}

class _PilihTanggalState extends State<PilihTanggal> {
  _PilihTanggalState({this.id_dokter = 0});

  final id_dokter;

  DateTime today = DateTime.now();
  Map<DateTime, bool> availability = {
    DateTime(2024, 6, 1): true, // contoh, ubah dengan data yang sesuai
    DateTime(2024, 6, 2): false, // contoh, ubah dengan data yang sesuai
    DateTime(2024, 6, 3): true, // contoh, ubah dengan data yang sesuai
    // tambahkan entri sesuai kebutuhan
  };

  final Set<int> disabledDays = {}; // Misalnya: Sabtu (6) dan Minggu (7)

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TimePickerPopup(
          selectedDate: today,
          onSelectTime: (TimeOfDay selectedTime) {
            // Handle the selected time
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(
      () {
        today = day;
        _showTimePicker(context); // Show the time picker when a day is selected
      },
    );
  }

  bool isAvailable(DateTime day) {
    return availability[day] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    var Doktor = myAuth.Dokter, Spesialis = myAuth.Spesialis;

    for (var i = 0; i < myAuth.hariKerja.length; i++) {
      disabledDays.add(myAuth.hariKerja[i]['id_hari']);
    }
    double screenHeight = MediaQuery.of(context).size.height;
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
                "Pilih Jadwal",
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFC1F4FF), Color(0xFFFFFFFF)],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    locale: "en_US",
                    rowHeight: 43,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Colors.red),
                      outsideDaysVisible: false,
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFF0D0A92),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(fontSize: 20),
                      titleCentered: true,
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    focusedDay: today,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2030),
                    onDaySelected: _onDaySelected,
                    enabledDayPredicate: (day) {
                      return disabledDays.contains(day.weekday);
                    },
                    calendarBuilders: CalendarBuilders(
                      disabledBuilder: (context, day, focusedDay) {
                        return Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                                color: Colors
                                    .grey), // Gaya untuk tanggal yang dinonaktifkan
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tersedia",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Tidak Tersedia",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Reservasi()),
                    //   );
                    // },
                    child: Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage(
                                    "assets/images/${Doktor['foto']}"),
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${Doktor['nama']}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${Spesialis['nama']}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
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
    );
  }
}

class TimePickerPopup extends StatefulWidget {
  final DateTime selectedDate;
  final Function(TimeOfDay) onSelectTime;

  const TimePickerPopup({
    Key? key,
    required this.selectedDate,
    required this.onSelectTime,
  }) : super(key: key);

  @override
  _TimePickerPopupState createState() => _TimePickerPopupState();
}

class _TimePickerPopupState extends State<TimePickerPopup> {
  TimeOfDay? _selectedTime;
  int indexJadwal = 0;

  @override
  void initState() {
    super.initState();
    _selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AuthCubit myAuth = context.read<AuthCubit>();
    double screenHeight = MediaQuery.of(context).size.height;

    final tanggalDipilih = widget.selectedDate.weekday;

    List<Map<String, dynamic>> hasil = myAuth.hariKerja
        .where((item) => item["id_hari"] == tanggalDipilih)
        .toList();

    // print(hasil);

    String tanggal = widget.selectedDate.toIso8601String().split('T')[0];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.7,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20, // Menambahkan jarak dari ujung atas pop-up
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  DateFormat('EEEE, d MMMM y').format(
                      widget.selectedDate), // Tampilkan tanggal yang dipilih
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pilih dan tekan Lanjut untuk memilih waktu',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: hasil.length, // Total waktu yang ditampilkan
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var indexJam = hasil[index]['id_jam'];
                    // var jam = myAuth.dataJam[indexJam - 1];
                    var jam = myAuth.dataJam
                        .firstWhere((item) => item["id"] == indexJam);

                    List<String> jamawal = jam['jam_awal'].split(':');
                    int hour = int.parse(jamawal[0]); // Start from 7:00 AM
                    int minute = int.parse(jamawal[1]);
                    final time = TimeOfDay(hour: hour, minute: minute);

                    List<String> jamakhir = jam['jam_akhir'].split(':');
                    hour = int.parse(jamakhir[0]); // Start from 7:00 AM
                    minute = int.parse(jamakhir[1]);
                    final timeafter = TimeOfDay(hour: hour, minute: minute);
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _selectedTime = time;
                            indexJadwal = hasil[index]['id'];
                          },
                        );
                      },
                      child: Container(
                        color:
                            _selectedTime == time ? Colors.grey.shade300 : null,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "${time.format(context)} - ${timeafter.format(context)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedTime != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PilihPasien(
                          tanggal: tanggal,
                          idxJadwal: indexJadwal,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pilih waktu untuk melakukan reservasi!',
                          style: GoogleFonts.poppins(),
                        ),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Colors.green;
                    },
                  ),
                ),
                child: Text(
                  'Lanjut',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(DateTime.now());
      //     var timeSekarang = convertTimeOfDayToDateTime(_selectedTime!);
      //     print(timeSekarang);
      //     print(timeSekarang.weekday);
      //   },
      // ),
    );
  }
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  return DateTime(
      now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
}
