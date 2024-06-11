import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_code/cubits/auth.cubit.dart';
import 'package:source_code/pages/landingPage.dart';
import 'package:source_code/pages/reservasi_tab.dart';
import 'pages/home_page.dart';
import 'pages/notif.dart';
import 'pages/profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(0);

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'MediCare',
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ValueNotifier<int> bottomNavIndex;
  const MyHomePage({super.key, required this.bottomNavIndex});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ValueNotifier<int> _bottomNavIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.bottomNavIndex;
    _bottomNavIndex.addListener(_navigateBottomBar);
  }

  @override
  void dispose() {
    _bottomNavIndex.removeListener(_navigateBottomBar);
    super.dispose();
  }

  void _navigateBottomBar() {
    setState(() {
      // This will rebuild the widget tree with the new selected index
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    ReservasiTab(),
    Notifikasi(),
    Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bottomNavIndex.value == 0 ? _buildAppBar() : null,
      body: _pages[_bottomNavIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex.value,
        onTap: (index) => _bottomNavIndex.value = index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF00C607),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Reservasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'My',
              style: TextStyle(
                color: Color(0xFFFF720C),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: Color(0xFFFC6A84),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            TextSpan(
              text: 'Medicare',
              style: TextStyle(
                color: Color(0xFF0C0A91),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
