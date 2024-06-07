import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/models/auth.model.dart';
import 'package:source_code/pages/registrationPage.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisUser(),
      ),
    ),
  );
}

class RegisUser extends StatefulWidget {
  @override
  _RegisUserState createState() => _RegisUserState();
}

class _RegisUserState extends State<RegisUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateToRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthModel>(
        listener: (context, state) {
          print("Current userID: ${state.userID}");
          if (state.userID != 0) {
            // User registered successfully, navigate to the next screen
            navigateToRegistrationPage();
          } else if (state.error.isNotEmpty) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Container(
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
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.poppins(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // Panggil fungsi register dari AuthCubit
                            BlocProvider.of<AuthCubit>(context).register(
                              _emailController.text,
                              _passwordController.text,
                            ).then((_) {
                              // Setelah register berhasil, cek state untuk memastikan tidak ada error
                              final authState = BlocProvider.of<AuthCubit>(context).state;
                              if (authState.error.isEmpty) {
                                navigateToRegistrationPage();
                              }
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
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
      ),
    );
  }
}
