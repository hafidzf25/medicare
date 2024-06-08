import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:convert';

import 'package:source_code/pages/profilPasien.dart';
import 'package:source_code/cubits/auth.cubit.dart';

class TambahProfil extends StatefulWidget {
  @override
  _TambahProfilState createState() => _TambahProfilState();
}

class _TambahProfilState extends State<TambahProfil> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime? _dateOfBirth;
  String _gender = '';
  Uint8List? _galleryImageBytes;

  void getImageFromGallery() {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.onLoad.listen((event) {
        setState(() {
          _galleryImageBytes = reader.result as Uint8List?;
        });
      });

      reader.readAsArrayBuffer(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC0F3FF), Colors.white],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Tambah Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 24.0,
                      color: Color(0xFF0C0A91),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: GestureDetector(
                      onTap: getImageFromGallery,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _galleryImageBytes != null
                            ? MemoryImage(_galleryImageBytes!)
                            : null,
                        child: _galleryImageBytes == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey[700],
                              )
                            : null,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      labelStyle: GoogleFonts.poppins(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Lengkap harus diisi';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tanggal Lahir',
                      labelStyle: GoogleFonts.poppins(),
                    ),
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((pickedDate) {
                        if (pickedDate == null) return;
                        setState(() {
                          _dateOfBirth = pickedDate; // Simpan objek DateTime
                        });
                      });
                    },
                    validator: (value) {
                      if (_dateOfBirth == null) {
                        return 'Tanggal Lahir harus diisi';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: _dateOfBirth != null
                            ? "${_dateOfBirth!.day}-${_dateOfBirth!.month}-${_dateOfBirth!.year}"
                            : ''), // Tambahkan controller untuk menampilkan tanggal yang dipilih
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Jenis Kelamin',
                        style: GoogleFonts.poppins(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _gender = _gender == 'PRIA' ? '' : 'PRIA';
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return _gender == 'PRIA' ? Colors.blue : null;
                              },
                            ),
                          ),
                          icon: _gender == 'PRIA'
                              ? Icon(Icons.check, color: Colors.white)
                              : Icon(Icons.male, color: Colors.grey),
                          label: Text(
                            'PRIA',
                            style: TextStyle(
                              color: _gender == 'PRIA' ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _gender = _gender == 'WANITA' ? '' : 'WANITA';
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return _gender == 'WANITA' ? Colors.blue : null;
                              },
                            ),
                          ),
                          icon: _gender == 'WANITA'
                              ? Icon(Icons.check, color: Colors.white)
                              : Icon(Icons.female, color: Colors.grey),
                          label: Text(
                            'WANITA',
                            style: TextStyle(
                              color: _gender == 'WANITA' ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    String base64Image = '';
    if (_galleryImageBytes != null) {
      base64Image = base64.encode(_galleryImageBytes!);
    }
    final authCubit = context.read<AuthCubit>();
    authCubit.tambahProfilLain(
      authCubit.state.userID,
      _name,
      _gender,
      _dateOfBirth.toString(),
      base64Image,
    ).then((_) async {
      await authCubit.getProfilLain(authCubit.dataProfil['id_user']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilPasien()),
      );
    }).catchError((error) {
      // Handle error
      print('Failed to add profile: $error');
    });
  }
},

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Text(
                        'TAMBAH',
                        style: GoogleFonts.poppins(
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
      ),
    );
  }
}
