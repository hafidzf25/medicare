import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/pilihdokter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Reservasi3(),
  ));
}

class Reservasi3 extends StatefulWidget {
  Reservasi3({super.key, this.id_spesialis = 0});
  final int id_spesialis;

  @override
  _Reservasi3State createState() => _Reservasi3State();
}

class _Reservasi3State extends State<Reservasi3> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredDoktor = [];

  @override
  void initState() {
    super.initState();
    AuthCubit myAuth = context.read<AuthCubit>();
    filteredDoktor = myAuth.dataDoktor;
    searchController.addListener(_filterDoktor);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterDoktor);
    searchController.dispose();
    super.dispose();
  }

  void _filterDoktor() {
    AuthCubit myAuth = context.read<AuthCubit>();
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredDoktor = myAuth.dataDoktor.where((doktor) {
        return doktor['nama'].toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
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
                "Cari Dokter",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
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
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF727173),
                      ),
                      hintText: 'Cari nama dokter',
                      hintStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Dokter",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredDoktor.length,
                    itemBuilder: (context, index) {
                      var doktor = filteredDoktor[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () async {
                            await myAuth.getjadwalbydoktor(doktor['id']);
                            await myAuth.getDokter(doktor['id']);
                            await myAuth.getSpesialis(doktor['id_spesialis']);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PilihDokter(
                                  id_dokter: doktor['id'],
                                ),
                              ),
                            );
                          },
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
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/dokter/${doktor['foto']}"),
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${doktor['nama']}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
