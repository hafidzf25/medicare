import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:source_code/models/auth.model.dart';

class AuthCubit extends Cubit<AuthModel> {
  AuthCubit() : super(AuthModel(userID: 0, accessToken: "", error: ""));

  Map<String, dynamic> dataProfil = {};
  Map<String, dynamic> Dokter = {};
  Map<String, dynamic> Spesialis = {};

  List<Map<String, dynamic>> dataSpesialis = [];
  List<Map<String, dynamic>> dataDoktor = [];
  List<Map<String, dynamic>> dataHari = [];
  List<Map<String, dynamic>> hariKerja = [];
  List<Map<String, dynamic>> dataJam = [];
  
  void setFromJson(Map<String, dynamic> json) {
    int userID = json['user_id'];
    String accessToken = json['access_token'];
    emit(AuthModel(userID: userID, accessToken: accessToken, error: ""));
  }

  List<Map<String, dynamic>> get _dataspesialis => dataSpesialis;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
      getspesialis();
      gethari();
      getjam();
      getProfil(state.userID);
    } else {
      emit(AuthModel(userID: 0, accessToken: "", error: "Email atau password salah"));
    }
  }

  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

     if (response.statusCode == 201) {
      // Berhasil mendaftar
      emit(AuthModel(userID: 0, accessToken: "", error: ""));
    } else if (response.statusCode == 400 && response.body.contains("Email sudah terdaftar")) {
      emit(AuthModel(userID: 0, accessToken: "", error: "Email sudah terdaftar"));
    } else {
      emit(AuthModel(userID: 0, accessToken: "", error: "Gagal Mendaftar. Terjadi kesalahan."));
    }
  }

  Future<void> tambahProfil(int userID, String nama, String jenisKelamin, String notelp, String tanggalLahir, String foto) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/profil/$userID'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "nama": nama,
        "jenis_kelamin": jenisKelamin,
        "notelp": notelp,
        "tanggal_lahir": tanggalLahir,
        "foto": foto
      }),
    );

    if (response.statusCode == 200) {
      print('Profil berhasil ditambahkan: ${response.body}');
      // Tambahkan logika tambahan di sini jika diperlukan
    } else {
      print('Gagal menambahkan profil: ${response.statusCode} ${response.body}');
      // Emit error state jika diperlukan
      emit(AuthModel(userID: state.userID, accessToken: state.accessToken, error: "Gagal menambahkan profil"));
    }
  }






  

  Future<void> getspesialis() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/spesialis/?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization' : 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil = body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataSpesialis = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load spesialis');
    }
  }

  Future<void> gethari() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/hari/?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization' : 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil = body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataHari = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load spesialis');
    }
  }

  Future<void> getjam() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/jam/?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization' : 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil = body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataJam = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load jam');
    }
  }

  Future<void> getProfil(int id_user) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/profil?id_user=$id_user'),
      headers: {
        'Authorization' : 'Bearer ${state.accessToken}',
      }
    );

    if (response.statusCode == 200) {
      dataProfil = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profil');
    }
  }

  Future<void> updateProfil(int id_user, Map<String, dynamic> profilData) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/profil/$id_user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${state.accessToken}',
      },
      body: jsonEncode(profilData),
    );

    if (response.statusCode == 200) {
      dataProfil = jsonDecode(response.body);
      emit(AuthModel(userID: state.userID, accessToken: state.accessToken, error: ""));
    } else {
      throw Exception('Failed to update profil');
    }
  }

  Future<void> getDokter(int id_dokter) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/dokter?id_dokter=${id_dokter}'),
      headers: {
        'Authorization' : 'Bearer ${state.accessToken}',
      }
    );

    if (response.statusCode == 200) {
      Dokter = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load specific dokter');
    }
  }

  Future<void> getSpesialis(int id_spesialis) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/spesialis?id_spesialis=${id_spesialis}'),
      headers: {
        'Authorization' : 'Bearer ${state.accessToken}',
      }
    );

    if (response.statusCode == 200) {
      Spesialis = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load specific specialist');
    }
  }

  Future<void> getdoktorbyspesialis(int id_spesialis) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/dokter/$id_spesialis?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization' : 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil = body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataDoktor = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load spesialis');
    }
  }

  Future<void> getjadwalbydoktor(int id_dokter) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/jam_kerja_dokter/$id_dokter'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization' : 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil = body.map((dynamic item) => item as Map<String, dynamic>).toList();
      hariKerja = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load jadwal');
    }
  }
}
