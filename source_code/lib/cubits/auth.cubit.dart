import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:source_code/models/auth.model.dart';

class AuthCubit extends Cubit<AuthModel> {
  AuthCubit() : super(AuthModel(userID: 0, accessToken: "", error: ""));

  Map<String, dynamic> dataProfil = {};
  Map<String, dynamic> Dokter = {};
  Map<String, dynamic> Spesialis = {};
  Map<String, dynamic> Reservasi = {};

  List<Map<String, dynamic>> dataProfilLain = [];
  List<Map<String, dynamic>> dataSpesialis = [];
  List<Map<String, dynamic>> dataDoktor = [];
  List<Map<String, dynamic>> dataHari = [];
  List<Map<String, dynamic>> hariKerja = [];
  List<Map<String, dynamic>> dataJam = [];
  List<Map<String, dynamic>> dataReservasi = [];
  List<Map<String, dynamic>> dataReservasiLain = [];
  List<Map<String, dynamic>> dataBlokJadwal = [];

  void setFromJson(Map<String, dynamic> json) {
    int userID = json['user_id'];
    String accessToken = json['access_token'];
    emit(AuthModel(userID: userID, accessToken: accessToken, error: ""));
  }

  List<Map<String, dynamic>> get _dataspesialis => dataSpesialis;

  /*
  
      ENDPOINT MENGENAI AUTH
  
  */

  // Loginkan
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

    // Memasukkan data data yang akan terhubung apabila sudah login
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
      await getspesialis();
      await gethari();
      await getjam();
      await getProfil(state.userID);
      await getProfilLain(state.userID);
      await getReservasiByDaftarProfil(dataProfil['id_daftar_profil']);
    } else {
      emit(AuthModel(
          userID: 0, accessToken: "", error: "Email atau password salah"));
    }
  }

  // Melakukan pendaftaran akun
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

  /*
  
      ENDPOINT MENGENAI PROFIL
  
  */

  // Melakukan Create Profil
  Future<void> tambahProfil(int userID, String nama, String jenisKelamin,
      String notelp, String tanggalLahir, String foto) async {
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
      emit(AuthModel(
          userID: state.userID, accessToken: state.accessToken, error: ""));
    } else {
      print(
          'Gagal menambahkan profil: ${response.statusCode} ${response.body}');
      emit(AuthModel(
          userID: state.userID,
          accessToken: state.accessToken,
          error: "Gagal menambahkan profil"));
    }
  }

  // Mengambil data profil berdasarkan id user yang di loginkan
  Future<void> getProfil(int idUser) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/profil/$idUser'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      dataProfil = jsonDecode(response.body);
      await getDaftarProfilSiProfil(dataProfil['id']);
    } else {
      throw Exception('Failed to load profil');
    }
  }

  // Mengambil data profil lain berdasarkan id nya
  Future<dynamic> getProfilLainById(int idProfilLain) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/profil_lain/id/$idProfilLain'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var profilLain = jsonDecode(response.body);
      return profilLain;
    } else {
      throw Exception('Failed to load profil');
    }
  }

  // Melakukan update profil pada id_user tertentu
  Future<void> updateProfil(
      int id_user, Map<String, dynamic> profilData) async {
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

  /*
  
      ENDPOINT MENGENAI SPESIALIS
  
  */

  // Melakukan get all data mengenai spesialis yang ada di db
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

  /*
  
      ENDPOINT MENGENAI HARI
  
  */

  // Melakukan get data hari yang ada dalam db
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

  /*
  
      ENDPOINT MENGENAI JAM
  
  */

  // Melakukan get data jam yang ada dalam db
  Future<void> getjam() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/jam/'),
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

  // Mengambil data jam berdasarkan id jam yang diminta
  Future<dynamic> getJamById(int idJam) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/jam/$idJam'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      var dataJam = jsonDecode(response.body);
      return dataJam;
    } else {
      throw Exception('Failed to load Jam');
    }
  }

  /*
  
      ENDPOINT MENGENAI DOKTER
  
  */

  // Melakukan get data dokter berdasarkan id dokter yang diminta
  Future<dynamic> getDokterById(int idDokter) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/Dokter/$idDokter'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      var dataDokter = jsonDecode(response.body);
      await getSpesialis(dataDokter['id_spesialis']);
      dataDokter['spesialis'] = Spesialis['nama'];
      return dataDokter;
    } else {
      throw Exception('Failed to load dokter');
    }
  }

  /*
  
      ENDPOINT MENGENAI JAM KERJA DOKTER
  
  */

  // Mengambil data jam kerja dokter berdasarkan idjamkerjadokter tersebut
  Future<dynamic> getJamKerjaDokterById(int idJamKerjaDokter) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/jam_kerja_dokter/$idJamKerjaDokter'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var dataJamKerjaDokter = jsonDecode(response.body);
      var tempJam = await getJamById(dataJamKerjaDokter['id_jam']);
      var tempDokter = await getDokterById(dataJamKerjaDokter['id_dokter']);
      dataJamKerjaDokter['dokter'] = tempDokter['nama'];
      dataJamKerjaDokter['spesialis'] = tempDokter['spesialis'];
      dataJamKerjaDokter['jam_awal'] = tempJam['jam_awal'];
      dataJamKerjaDokter['jam_akhir'] = tempJam['jam_akhir'];
      return dataJamKerjaDokter;
    } else {
      throw Exception('Failed to load Jam Kerja Dokter');
    }
  }

  /*
  
      ENDPOINT MENGENAI DAFTAR PROFIL
  
  */

  // Mengambil data daftar profil berdasarkan id daftar profil
  Future<dynamic> getDaftarProfilByIdDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftarprofil/id_daftar_profil/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      return temp;
    } else {
      throw Exception('Failed to load daftar profil');
    }
  }

  // Mengambil data daftar profil berdasarkan id profil yang diminta
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

  // Mengambil data daftar profil berdasarkan id profil lain yang diminta
  Future<dynamic> getDaftarProfilSiProfilLain(int idProfilLain) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftarprofil_lain/$idProfilLain'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      return temp;
    } else {
      throw Exception('Failed to load daftar profil lain');
    }
  }

  Future<void> getDokter(int idDokter) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/dokter/$idDokter'), headers: {
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
        Uri.parse('http://127.0.0.1:8000/spesialis/$idSpesialis'),
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
      Uri.parse(
          'http://127.0.0.1:8000/dokter_by_spesialis/$idSpesialis?skip=0&limit=10'),
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
      Uri.parse('http://127.0.0.1:8000/jam_kerja_dokter/id_dokter/$id_dokter'),
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

  Future<void> getReservasiById(int idReservasi, bool isProfil) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/reservasi/$idReservasi'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      Reservasi = {};
      var body = jsonDecode(response.body);

      DateTime date = DateTime.parse(body['tanggal']);
      var tempJam = await getJamKerjaDokterById(body['id_jam_kerja_dokter']);
      var nama = await getDaftarProfilByIdDaftarProfil(body['id_daftar_profil']);
      var tempNama;

      if (isProfil) {
        tempNama = dataProfil;
      } else {
        tempNama = await getProfilLainById(nama['id_profil_lain']);
      }
      
      Reservasi['id'] = body['id'];
      Reservasi['nama'] = tempNama['nama'];
      Reservasi['tanggal'] = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
      Reservasi['biaya'] = body['biaya'];
      Reservasi['jam_awal'] = tempJam['jam_awal'].substring(0, 5);
      Reservasi['jam_akhir'] = tempJam['jam_akhir'].substring(0, 5);

      print(Reservasi);
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load reservasi');
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
        var temp = await getJamKerjaDokterById(
            dataBlokJadwal[i]['id_jam_kerja_dokter']);
        dataBlokJadwal[i]['dokter'] = temp['dokter'];
        dataBlokJadwal[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        dataBlokJadwal[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
      }
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> getReservasiByDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi_by_id_daftar_profil/$idDaftarProfil?skip=0&limit=10'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataReservasi = hasil;
      for (var i = 0; i < dataReservasi.length; i++) {
        var temp = await getJamKerjaDokterById(
            dataReservasi[i]['id_jam_kerja_dokter']);
        dataReservasi[i]['dokter'] = temp['dokter'];
        dataReservasi[i]['spesialis'] = temp['spesialis'];
        dataReservasi[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        dataReservasi[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
        dataReservasi[i]['nama'] = dataProfil['nama'];
      }
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> getReservasiByDaftarProfilLain(
      int idDaftarProfil, int idx) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/reservasi_by_id_daftar_profil/$idDaftarProfil?skip=0&limit=10'),
      headers: {
        'Authorization': 'Bearer ${state.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var temp = await getJamKerjaDokterById(hasil[i]['id_jam_kerja_dokter']);
        hasil[i]['dokter'] = temp['dokter'];
        hasil[i]['spesialis'] = temp['spesialis'];
        hasil[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        hasil[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
        var nama = await getProfilLainById(idx);
        hasil[i]['nama'] = nama['nama'];
      }
      dataReservasi.addAll(hasil);
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
          'status': 0,
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
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/profil_lain/$idUser'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataProfilLain = hasil;
      for (var i = 0; i < dataProfilLain.length; i++) {
        var tempid = await getDaftarProfilSiProfilLain(dataProfilLain[i]['id']);
        dataProfilLain[i]['id_daftar_profil'] = tempid['id'];
      }
    } else {
      throw Exception('Failed to load profil lain');
    }
  }
}
