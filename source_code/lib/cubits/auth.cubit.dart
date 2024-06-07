import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:source_code/models/auth.model.dart';

class AuthCubit extends Cubit<AuthModel> {
  AuthCubit() : super(AuthModel(userID: 0, accessToken: "", error: ""));

  Map<String, dynamic> dataProfil = {};
  Map<String, dynamic> Dokter = {};
  Map<String, dynamic> Spesialis = {};
  Map<String, dynamic> Reservasi = {};
  Map<String, dynamic> dataProfilLain = {};

  List<Map<String, dynamic>> dataSpesialis = [];
  List<Map<String, dynamic>> dataDoktor = [];
  List<Map<String, dynamic>> dataHari = [];
  List<Map<String, dynamic>> hariKerja = [];
  List<Map<String, dynamic>> dataJam = [];
  List<Map<String, dynamic>> dataReservasi = [];
  List<Map<String, dynamic>> dataBlokJadwal = [];

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
      await getProfil(state.userID);
      await getReservasiByDaftarProfil(dataProfil['id_daftar_profil']);
      // getJamKerjaDokterById(7);
    } else {
      emit(AuthModel(
          userID: 0, accessToken: "", error: "Email atau password salah"));
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
      var dataRegis = jsonDecode(response.body);
      emit(AuthModel(userID: dataRegis['id'], accessToken: "", error: ""));
    } else if (response.statusCode == 400 &&
        response.body.contains("Email sudah terdaftar")) {
      emit(AuthModel(
          userID: 0, accessToken: "", error: "Email sudah terdaftar"));
    } else {
      emit(AuthModel(
          userID: 0,
          accessToken: "",
          error: "Gagal Mendaftar. Terjadi kesalahan."));
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
      emit(AuthModel(userID: state.userID, accessToken: state.accessToken, error: ""));
    } else {
      print('Gagal menambahkan profil: ${response.statusCode} ${response.body}');
      emit(AuthModel(userID: state.userID, accessToken: state.accessToken, error: "Gagal menambahkan profil"));
    }
  }

  Future<void> getspesialis() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/spesialis/?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataSpesialis = hasil;
    } else {
      throw Exception('Failed to load spesialis');
    }
  }

  Future<void> gethari() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/hari/?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
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
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataJam = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load jam');
    }
  }

  Future<String> getDokterById(int idDokter) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/Dokter/$idDokter'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var dataDokter = jsonDecode(response.body);
      return dataDokter['nama'];
    } else {
      throw Exception('Failed to load dokter');
    }
  }

  Future<dynamic> getJamById(int idJam) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/jam/$idJam'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var dataJam = jsonDecode(response.body);
      return dataJam;
    } else {
      throw Exception('Failed to load Jam');
    }
  }

  Future<dynamic> getJamKerjaDokterById(int idJamKerjaDokter) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/jam_kerja_dokter/$idJamKerjaDokter'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var dataJamKerjaDokter = jsonDecode(response.body);
      var tempJam = await getJamById(dataJamKerjaDokter['id_jam']);
      dataJamKerjaDokter['dokter'] = await getDokterById(dataJamKerjaDokter['id_dokter']);
      dataJamKerjaDokter['jam_awal'] = tempJam['jam_awal'];
      dataJamKerjaDokter['jam_akhir'] = tempJam['jam_akhir'];
      return dataJamKerjaDokter;
    } else {
      throw Exception('Failed to load Jam Kerja Dokter');
    }
  }

  Future<void> getDaftarProfilSiProfil(int idProfil) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftarprofil/$idProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      dataProfil['id_daftar_profil'] = temp['id'];
    } else {
      throw Exception('Failed to load profil');
    }
  }

  Future<void> getProfil(int idUser) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/profil/$idUser'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      dataProfil = jsonDecode(response.body);
      await getDaftarProfilSiProfil(dataProfil['id']);
    } else {
      throw Exception('Failed to load profil');
    }
  }

  Future<void> updateProfil(int id_user, Map<String, dynamic> profilData) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/profil/${id_user}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${state.accessToken}',
      },
      body: jsonEncode(profilData),
    );

    if (response.statusCode == 200) {
      dataProfil = jsonDecode(response.body);
      getProfil(id_user);
    } else {
      throw Exception('Failed to update profil');
    }
  }

  Future<void> getDokter(int idDokter) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/dokter/$idDokter'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      Dokter = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load specific dokter');
    }
  }

  Future<void> getSpesialis(int idSpesialis) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/spesialis/$idSpesialis'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      Spesialis = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load specific specialist');
    }
  }

  Future<void> getdoktorbyspesialis(int idSpesialis) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/dokter_by_spesialis/$idSpesialis?skip=0&limit=10'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
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
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      hariKerja = hasil;
      // print(response.body);
    } else {
      throw Exception('Failed to load jadwal');
    }
  }

  Future<void> getReservasiByTanggal(String Tanggal) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/reservasi_tgl/$Tanggal'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataBlokJadwal = hasil;
      for (var i = 0; i < dataBlokJadwal.length; i++) {
        var temp = await getJamKerjaDokterById(dataBlokJadwal[i]['id_jam_kerja_dokter']);
        dataBlokJadwal[i]['dokter'] = temp['dokter'];
        dataBlokJadwal[i]['jam_awal'] = temp['jam_awal'].substring(0,5);
        dataBlokJadwal[i]['jam_akhir'] = temp['jam_akhir'].substring(0,5);
      }
    } else if (response.statusCode == 404) {
      
    }
     else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> getReservasiByDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/reservasi_by_id_daftar_profil/$idDaftarProfil?skip=0&limit=10'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataReservasi = hasil;
      for (var i = 0; i < dataReservasi.length; i++) {
        var temp = await getJamKerjaDokterById(dataReservasi[i]['id_jam_kerja_dokter']);
        dataReservasi[i]['dokter'] = temp['dokter'];
        dataReservasi[i]['jam_awal'] = temp['jam_awal'].substring(0,5);
        dataReservasi[i]['jam_akhir'] = temp['jam_akhir'].substring(0,5);
      }
      print(dataReservasi);
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> postReservasi(String tanggal, int idJamKerjaDokter,
      int idDaftarProfil, String biaya) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/reservasi/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${state.accessToken}',
      },
      body: jsonEncode(
        {
          'tanggal': tanggal,
          'id_jam_kerja_dokter': idJamKerjaDokter,
          'id_daftar_profil': idDaftarProfil,
          'biaya': biaya,
        },
      ),
    );

    if (response.statusCode == 200) {
      Reservasi = jsonDecode(response.body);
      getReservasiByDaftarProfil(idDaftarProfil);
    } else {
      throw Exception('Failed to push reservasi');
    }
  }

  Future<void> getProfilLain(int idUser) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/profil_lain/$idUser'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      dataProfilLain = jsonDecode(response.body);
      await getDaftarProfilSiProfil(dataProfilLain['id']);
    } else {
      throw Exception('Failed to load profil');
    }
  }
}
