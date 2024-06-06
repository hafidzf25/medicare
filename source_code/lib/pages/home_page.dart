import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/Ads.dart';
import '../widgets/icon.dart';
import '../widgets/news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit myAuth = context.read<AuthCubit>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC0F3FF), Colors.white]),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Ads(),
            const SizedBox(height: 8),
            IconHome(),
            const SizedBox(height: 10),
            News(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
