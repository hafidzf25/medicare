import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:source_code/cubits/auth.cubit.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  late ImagePicker _imagePicker;
  Uint8List? _imageFile;
  bool _isEditing = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    // Initialize text field controllers with existing data
    _nameController.text = "John Doe";
    _dobController.text = "1990-01-01";
    _phoneController.text = "+1234567890";
    _emailController.text = "john.doe@example.com";
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = bytes;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = picked.toString().split(' ')[0]; // Update the date controller without time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    
    _nameController.text = "${myAuth.dataProfil['nama']}";
    _dobController.text = "${myAuth.dataProfil['tanggal_lahir']}";
    _phoneController.text = "${myAuth.dataProfil['notelp']}";
    
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
                "Profil",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Bold',
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null ? MemoryImage(_imageFile!) as ImageProvider<Object> : AssetImage('assets/images/${myAuth.dataProfil['foto']}'),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _pickImage,
                child: Text(
                  "Edit Foto",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                      ),
                      readOnly: !_isEditing,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        suffixIcon: _isEditing ? IconButton( // Tampilkan icon hanya saat dalam mode edit
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ) : null,
                      ),
                      readOnly: !_isEditing,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Ponsel',
                      ),
                      readOnly: !_isEditing,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true; // Set _isEditing to true when the button is pressed
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Change button color to green
                        minimumSize: Size(double.infinity/2, 50), // Set button width to maximum with height 50
                      ),
                      child: Text('Edit', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
