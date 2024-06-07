import 'package:flutter/material.dart';
import '../widgets/Ads.dart';
import '../widgets/icon.dart';
import '../widgets/news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC0F3FF), Colors.white]),
        ),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: const [
              Ads(),
              SizedBox(height: 8),
              IconHome(),
              SizedBox(height: 10),
              News(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
