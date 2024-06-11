import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/main.dart';
import 'package:source_code/models/auth.model.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _pass = '';

  // Initialize the ValueNotifier here
  final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();

    return Scaffold(
      body: BlocListener<AuthCubit, AuthModel>(
        listener: (context, state) {
          if (state.userID != 0 && state.accessToken.isNotEmpty) {
            bottomNavIndex.value = 0; // Indeks untuk ReservasiTab
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(bottomNavIndex: bottomNavIndex)),
            );
          } else if (state.error.isNotEmpty) {
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
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFF0C0A91),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Selamat datang kembali! Silakan masukkan informasi login Anda untuk melanjutkan.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        }
                        return null;
                      },
                      onSaved: (value) => _pass = value!,
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // Panggil fungsi login dari AuthCubit
                            BlocProvider.of<AuthCubit>(context)
                                .login(_email, _pass);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
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
