// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/spesialis.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InfoSD(),
  ));
}

class InfoSD extends StatefulWidget {
  @override
  _InfoSDState createState() => _InfoSDState();
}

class _InfoSDState extends State<InfoSD> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredSpesialis = [];

  @override
  void initState() {
    super.initState();
    AuthCubit myAuth = context.read<AuthCubit>();
    filteredSpesialis = myAuth.dataSpesialis;
    searchController.addListener(_filterSpesialis);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterSpesialis);
    searchController.dispose();
    super.dispose();
  }

  void _filterSpesialis() {
    AuthCubit myAuth = context.read<AuthCubit>();
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSpesialis = myAuth.dataSpesialis.where((spesialis) {
        return spesialis['nama'].toString().toLowerCase().contains(query);
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
                "Spesialis dan Dokter",
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF727173),
                ),
                hintText: 'Cari spesialis',
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
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSpesialis.length,
                itemBuilder: (context, index) {
                  var DataSpesialis = filteredSpesialis[index];
                  return Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await myAuth.getdoktorbyspesialis(DataSpesialis['id']);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Spesialis(posisiSpesialis: index)),
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
                            ),
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
                                      "assets/images/${DataSpesialis['foto']}"),
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${DataSpesialis['nama']}",
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
            ),
          ],
        ),
      ),
    );
  }
}
