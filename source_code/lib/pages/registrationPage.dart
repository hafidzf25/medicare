import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/landingPage.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime? _dateOfBirth;
  String _gender = '';
  String _phoneNumber = '';
  bool _isAgreed = false;
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

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Tampilkan dialog konfirmasi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Apakah Anda yakin bahwa informasi yang Anda masukkan di bawah sudah akurat?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Nama: $_name\n'
                  'Tanggal Lahir: ${_dateOfBirth != null ? "${_dateOfBirth!.year}-${_dateOfBirth!.month.toString().padLeft(2, '0')}-${_dateOfBirth!.day.toString().padLeft(2, '0')}" : ''}\n'
                  'Jenis Kelamin: $_gender\n'
                  'Nomor Ponsel: $_phoneNumber',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Pastikan bahwa data yang Anda berikan sudah benar, dan nama serta tanggal lahir Anda cocok dengan kartu identifikasi nasional Anda karena kami akan memeriksa dan menyimpan data berikut.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                },
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: _isAgreed
                    ? () {
                        // Tambahkan data setelah mengklik "Lanjut"
                        BlocProvider.of<AuthCubit>(context).tambahProfil(
                          BlocProvider.of<AuthCubit>(context).state.userID, // ID pengguna
                          _name, // Nama
                          _gender, // Jenis Kelamin
                          _phoneNumber, // Nomor Telepon
                          _dateOfBirth != null
                              ? "${_dateOfBirth!.year}-${_dateOfBirth!.month.toString().padLeft(2, '0')}-${_dateOfBirth!.day.toString().padLeft(2, '0')}" // Tanggal Lahir
                              : "", // Tanggal Lahir (jika tidak ada)
                          _galleryImageBytes != null
                              ? base64Encode(_galleryImageBytes!) // Foto (jika ada)
                              : "", // Foto (jika tidak ada)
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LandingPage(),
                          ),
                        );
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return _isAgreed ? Colors.green : Colors.grey;
                    },
                  ),
                ),
                child: Text(
                  'Lanjut',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building RegistrationPage");
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
                    'Daftar',
                    style: GoogleFonts.poppins(
                      fontSize: 24.0,
                      color: Color(0xFF0C0A91),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Sepertinya Anda pengguna baru. Mohon lengkapi data Anda',
                    style: GoogleFonts.poppins(fontSize: 16.0),
                  ),
                  SizedBox(height: 32.0),
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
                  SizedBox(height: 16.0),
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
                          _dateOfBirth = pickedDate;
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
                          ? "${_dateOfBirth!.year}-${_dateOfBirth!.month.toString().padLeft(2, '0')}-${_dateOfBirth!.day.toString().padLeft(2, '0')}"
                          : '',
                    ),
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
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Ponsel',
                      labelStyle: GoogleFonts.poppins(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nomor Ponsel harus diisi';
                      }
                      return null;
                    },
                    onSaved: (value) => _phoneNumber = value!,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isAgreed,
                        onChanged: (newValue) {
                          setState(() {
                            _isAgreed = newValue!;
                          });
                        },
                      ),
                      SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          'Saya yakin bahwa data di atas adalah informasi akurat, lengkap, dan terbaru tentang saya.',
                          style: GoogleFonts.poppins(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isAgreed ? _register : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return _isAgreed ? Colors.green : Colors.grey;
                          },
                        ),
                      ),
                      child: Text(
                        'DAFTAR',
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
