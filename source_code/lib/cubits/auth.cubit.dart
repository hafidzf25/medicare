import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
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
  List<Map<String, dynamic>> dataHistoryReservasi = [];
  List<Map<String, dynamic>> dataReservasi = [];
  List<Map<String, dynamic>> dataReservasiLain = [];
  List<Map<String, dynamic>> dataBlokJadwal = [];
  List<Map<String, dynamic>> dataDiagnosaReservasi = [];
  List<Map<String, dynamic>> dataPenyakitReservasi = [];
  List<Map<String, dynamic>> dataObatReservasi = [];
  List<Map<String, dynamic>> dataRekamMedis = [];
  List<Map<String, dynamic>> dataObatProfil = [];
  List<Map<String, dynamic>> dataAkhirObat = [];
  List<Map<String, dynamic>> dataLabProfil = [];
  List<Map<String, dynamic>> dataLabProfilLain = [];
  List<Map<String, dynamic>> dataRadiologiProfil = [];
  List<Map<String, dynamic>> dataRadiologiProfilLain = [];
  List<Map<String, dynamic>> dataNotifikasiProfil = [];
  List<Map<String, dynamic>> dataNotifikasiProfilLain = [];

  Set<Map<String, dynamic>> tempDataObat = {};

  double biaya_obat = 0;

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
      await getReservasiDoneByDaftarProfil(dataProfil['id_daftar_profil']);
      await getRekamMedisByDaftarProfil(dataProfil['id_daftar_profil']);
      await getObatByIdDaftarProfil(dataProfil['id_daftar_profil']);
      for (var i = 0; i < dataProfilLain.length; i++) {
        await getObatByIdDaftarProfilLain(
            dataProfilLain[i]['id_daftar_profil'], dataProfilLain[i]['id']);
      }
      await getLabByIdDaftarProfil(dataProfil['id_daftar_profil']);
      for (var i = 0; i < dataProfilLain.length; i++) {
        await getLabByIdDaftarProfilLain(
            dataProfilLain[i]['id_daftar_profil'], dataProfilLain[i]['id']);
      }
      await getRadiologiByIdDaftarProfil(dataProfil['id_daftar_profil']);
      for (var i = 0; i < dataProfilLain.length; i++) {
        await getRadiologiByIdDaftarProfilLain(
            dataProfilLain[i]['id_daftar_profil'], dataProfilLain[i]['id']);
      }
      await getNotifikasiByDaftarProfil(dataProfil['id_daftar_profil']);
      for (var i = 0; i < dataProfilLain.length; i++) {
        await getNotifikasiByDaftarProfilLain(
            dataProfilLain[i]['id_daftar_profil'], dataProfilLain[i]['id']);
      }
    } else {
      emit(
        AuthModel(
            userID: 0, accessToken: "", error: "Email atau password salah"),
      );
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

  // Loginkan
  Future<void> logout() async {
    emit(
      AuthModel(userID: 0, accessToken: "", error: ""),
    );
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
        Uri.parse('http://127.0.0.1:8000/profil_lain/$idProfilLain'),
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
    } else {
      throw Exception('Failed to load jam');
    }
  }

  // Mengambil data jam berdasarkan id jam yang diminta
  Future<dynamic> getJamById(int idJam) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/jam/id_jam/$idJam'), headers: {
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
        .get(Uri.parse('http://127.0.0.1:8000/dokter/$idDokter'), headers: {
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
      dataJamKerjaDokter['id_spesialis'] = tempDokter['id_spesialis'];
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
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil/id_daftar_profil/$idDaftarProfil'),
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
        Uri.parse('http://127.0.0.1:8000/daftar_profil/id_profil/$idProfil'),
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
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil/id_profil_lain/$idProfilLain'),
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
      Uri.parse('http://127.0.0.1:8000/dokter/spesialis/$idSpesialis'),
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
    } else {
      throw Exception('Failed to load jadwal');
    }
  }

  /*
  
    ENDPOINT MENGENAI RESERVASI
  
   */

  Future<void> getReservasiById(
      int idReservasi, bool isProfil, int idSpesialis) async {
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
      var nama =
          await getDaftarProfilByIdDaftarProfil(body['id_daftar_profil']);
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
      Reservasi['status'] = body['status'];
      Reservasi['id_spesialis'] = idSpesialis;
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> setStatusReservasiById(int idReservasi, int status) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/reservasi/edit_status/$idReservasi'),
      headers: {
        'Authorization': 'Bearer ${state.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "status": status,
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Reservasi['status'] = body['status'];
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> getReservasiByTanggal(String Tanggal) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/reservasi/tgl/$Tanggal'),
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
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/$idDaftarProfil'),
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
        dataReservasi[i]['id_spesialis'] = temp['id_spesialis'];
        dataReservasi[i]['spesialis'] = temp['spesialis'];
        dataReservasi[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        dataReservasi[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
        dataReservasi[i]['nama'] = dataProfil['nama'];
      }
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<void> getReservasiDoneByDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataHistoryReservasi = hasil;
      for (var i = 0; i < dataHistoryReservasi.length; i++) {
        var temp = await getJamKerjaDokterById(
            dataHistoryReservasi[i]['id_jam_kerja_dokter']);
        dataHistoryReservasi[i]['dokter'] = temp['dokter'];
        dataHistoryReservasi[i]['spesialis'] = temp['spesialis'];
        dataHistoryReservasi[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        dataHistoryReservasi[i]['jam_akhir'] =
            temp['jam_akhir'].substring(0, 5);
        dataHistoryReservasi[i]['nama'] = dataProfil['nama'];
      }
    } else {
      throw Exception('Failed to load history reservasi');
    }
  }

  Future<void> getRekamMedisByDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataRekamMedis = hasil;
      for (var i = 0; i < dataRekamMedis.length; i++) {
        var temp = await getJamKerjaDokterById(
            dataRekamMedis[i]['id_jam_kerja_dokter']);
        dataRekamMedis[i]['dokter'] = temp['dokter'];
        dataRekamMedis[i]['nama'] = dataProfil['nama'];
        dataRekamMedis[i]['tanggal_lahir'] = dataProfil['tanggal_lahir'];
        dataRekamMedis[i]['foto'] = dataProfil['foto'];
        var tempPenyakit =
            await getDaftarProfilPenyakitByReservasi(dataRekamMedis[i]['id']);

        // Mengambil semua nilai `id_penyakit` dari setiap elemen dalam data
        List<String> daftarPenyakit =
            tempPenyakit.map((item) => item['penyakit'] as String).toList();

        // Menggabungkan nilai-nilai tersebut menjadi satu string yang dipisahkan oleh koma
        String printPenyakit = daftarPenyakit.join(', ');
        dataRekamMedis[i]['penyakit'] = printPenyakit;

        List<Map<String, dynamic>> daftarObat = [];

        for (var i = 0; i < tempPenyakit.length; i++) {
          tempDataObat = {};
          var obat = await getObatByIdPenyakit(tempPenyakit[i]['id_penyakit']);
          daftarObat = [...daftarObat, ...tempDataObat];
        }

        List<String> obatString =
            daftarObat.map((item) => item['nama'] as String).toList();

        obatString = obatString.toSet().toList();

        String hasilobat = obatString.join(', ');
        dataRekamMedis[i]['obat'] = hasilobat;
      }
    } else {
      throw Exception('Failed to load rekam medis');
    }
  }

  Future<void> getReservasiByDaftarProfilLain(
      int idDaftarProfil, int idx) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/$idDaftarProfil'),
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
        hasil[i]['id_spesialis'] = temp['id_spesialis'];
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

  Future<void> getReservasiDoneByDaftarProfilLain(
      int idDaftarProfil, int idx) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
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
      dataHistoryReservasi.addAll(hasil);
    } else {
      throw Exception('Failed to load history reservasi');
    }
  }

  Future<void> getRekamMedisByDaftarProfilLain(
      int idDaftarProfil, int idx) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var temp = await getJamKerjaDokterById(hasil[i]['id_jam_kerja_dokter']);
        hasil[i]['dokter'] = temp['dokter'];
        var tempPenyakit =
            await getDaftarProfilPenyakitByReservasi(hasil[i]['id']);

        var nama = await getProfilLainById(idx);
        hasil[i]['nama'] = nama['nama'];
        hasil[i]['tanggal_lahir'] = nama['tanggal_lahir'];
        hasil[i]['foto'] = nama['foto'];

        // Mengambil semua nilai `id_penyakit` dari setiap elemen dalam data
        List<String> daftarPenyakit =
            tempPenyakit.map((item) => item['penyakit'] as String).toList();

        // Menggabungkan nilai-nilai tersebut menjadi satu string yang dipisahkan oleh koma
        String printPenyakit = daftarPenyakit.join(', ');
        hasil[i]['penyakit'] = printPenyakit;

        List<Map<String, dynamic>> daftarObat = [];

        for (var i = 0; i < tempPenyakit.length; i++) {
          tempDataObat = {};
          var obat = await getObatByIdPenyakit(tempPenyakit[i]['id_penyakit']);
          daftarObat = [...daftarObat, ...tempDataObat];
        }

        // Mengambil nilai 'penyakit' dari setiap elemen dalam list yang digabungkan
        List<String> obatString =
            daftarObat.map((item) => item['nama'] as String).toList();

        obatString = obatString.toSet().toList();

        String hasilobat = obatString.join(', ');
        hasil[i]['obat'] = hasilobat;
      }
      dataRekamMedis.addAll(hasil);
    } else {
      throw Exception('Failed to load rekam medis');
    }
  }

  Future<void> getObatByIdDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      dataAkhirObat = [];
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataObatProfil = hasil;
      var tempObat = tempDataObat;

      for (var i = 0; i < dataObatProfil.length; i++) {

        dataObatProfil[i]['nama'] = dataProfil['nama'];

        var tempDaftarPenyakit =
            await getDaftarProfilPenyakitByReservasi(dataObatProfil[i]['id']);

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          tempDataObat = {};
          tempDaftarPenyakit[j]['max_hari'] = 0;
          var namaPenyakit =
              await getPenyakitById(tempDaftarPenyakit[j]['id_penyakit']);
          tempDaftarPenyakit[j]['nama_penyakit'] = namaPenyakit['nama'];
          await getObatByIdPenyakit(tempDaftarPenyakit[j]['id_penyakit']);
          var daftarObat = tempDataObat.toList();
          for (var k = 0; k < daftarObat.length; k++) {
            if (tempDaftarPenyakit[j]['max_hari'] < daftarObat[k]['durasi']) {
              tempDaftarPenyakit[j]['max_hari'] = daftarObat[k]['durasi'];
            }
          }
        }

        // Mengambil tanggal hari ini
        DateTime now = DateTime.now();

        // Mengonversi tanggal ke format yang diinginkan
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);

        // Membuat objek DateTime untuk kedua tanggal
        DateTime date1 = DateTime.parse(dataObatProfil[i]['tanggal']);
        DateTime date2 = DateTime.parse(formattedDate);

        // Menghitung selisih antara kedua tanggal
        Duration difference = date2.difference(date1);

        // Mendapatkan selisih dalam hari
        int differenceInDays = difference.inDays;

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          if (differenceInDays >= tempDaftarPenyakit[j]['max_hari']) {
            await setStatusDaftarProfilPenyakitById(
                tempDaftarPenyakit[j]['id'], 0);
          }
        }
      }
      tempDataObat = tempObat;
      for (var i = 0; i < dataObatProfil.length; i++) {
        dataObatProfil[i]['nama'] = dataProfil['nama'];

        var tempDaftarPenyakit = await getDaftarProfilPenyakitAktifByReservasi(
            dataObatProfil[i]['id']);

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          tempDataObat = {};
          var namaPenyakit =
              await getPenyakitById(tempDaftarPenyakit[j]['id_penyakit']);
          tempDaftarPenyakit[j]['nama_penyakit'] = namaPenyakit['nama'];
          await getObatByIdPenyakit(tempDaftarPenyakit[j]['id_penyakit']);
          var daftarObat = tempDataObat.toList();
          for (var k = 0; k < daftarObat.length; k++) {
            daftarObat[k]['nama_pasien'] = dataProfil['nama'];
            daftarObat[k]['nama_penyakit'] =
                tempDaftarPenyakit[j]['nama_penyakit'];
          }
          dataAkhirObat.addAll(daftarObat);
        }
      }
    } else {
      throw Exception('Failed to load rekam medis');
    }
  }

  Future<void> getObatByIdDaftarProfilLain(int idDaftarProfil, int idx) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/status_done/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataObatProfil = hasil;
      var tempObat = tempDataObat;

      for (var i = 0; i < dataObatProfil.length; i++) {
        var tempDaftarPenyakit =
            await getDaftarProfilPenyakitByReservasi(dataObatProfil[i]['id']);

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          tempDataObat = {};
          tempDaftarPenyakit[j]['max_hari'] = 0;
          var namaPenyakit =
              await getPenyakitById(tempDaftarPenyakit[j]['id_penyakit']);
          tempDaftarPenyakit[j]['nama_penyakit'] = namaPenyakit['nama'];
          await getObatByIdPenyakit(tempDaftarPenyakit[j]['id_penyakit']);
          var daftarObat = tempDataObat.toList();
          for (var k = 0; k < daftarObat.length; k++) {
            if (tempDaftarPenyakit[j]['max_hari'] < daftarObat[k]['durasi']) {
              tempDaftarPenyakit[j]['max_hari'] = daftarObat[k]['durasi'];
            }
          }
        }

        // Mengambil tanggal hari ini
        DateTime now = DateTime.now();

        // Mengonversi tanggal ke format yang diinginkan
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);

        // Membuat objek DateTime untuk kedua tanggal
        DateTime date1 = DateTime.parse(dataObatProfil[i]['tanggal']);
        DateTime date2 = DateTime.parse(formattedDate);

        // Menghitung selisih antara kedua tanggal
        Duration difference = date2.difference(date1);

        // Mendapatkan selisih dalam hari
        int differenceInDays = difference.inDays;

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          if (differenceInDays >= tempDaftarPenyakit[j]['max_hari']) {
            await setStatusDaftarProfilPenyakitById(
                tempDaftarPenyakit[j]['id'], 0);
          }
        }
      }
      tempDataObat = tempObat;
      for (var i = 0; i < dataObatProfil.length; i++) {
        var tempDaftarPenyakit = await getDaftarProfilPenyakitAktifByReservasi(
            dataObatProfil[i]['id']);

        for (var j = 0; j < tempDaftarPenyakit.length; j++) {
          tempDataObat = {};
          var namaPenyakit =
              await getPenyakitById(tempDaftarPenyakit[j]['id_penyakit']);
          tempDaftarPenyakit[j]['nama_penyakit'] = namaPenyakit['nama'];
          await getObatByIdPenyakit(tempDaftarPenyakit[j]['id_penyakit']);
          var daftarObat = tempDataObat.toList();
          for (var k = 0; k < daftarObat.length; k++) {
            var nama = await getProfilLainById(idx);
            daftarObat[k]['nama_pasien'] = nama['nama'];
            daftarObat[k]['nama_penyakit'] =
                tempDaftarPenyakit[j]['nama_penyakit'];
          }
          dataAkhirObat.addAll(daftarObat);
        }
      }
    } else {
      throw Exception('Failed to load rekam medis');
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

  Future<void> postDaftarPenyakitProfil(
      int idDaftarProfil, int idPenyakit, int idReservasi) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/daftar_profil_penyakit/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${state.accessToken}',
      },
      body: jsonEncode(
        {
          "id_daftar_profil": idDaftarProfil,
          "id_penyakit": idPenyakit,
          "status": 1,
          "id_reservasi": idReservasi,
        },
      ),
    );

    if (response.statusCode == 200) {
      var DaftarProfilPenyakit = jsonDecode(response.body);
    } else {
      throw Exception('Failed to post daftar profil penyakit');
    }
  }

  Future<void> getProfilLain(int idUser) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/profil_lain/id_user/$idUser'),
        headers: {
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

  // Mengambil data profil lain berdasarkan id nya
  Future<Map<String, dynamic>> getPenyakitById(int idPenyakit) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/penyakit/$idPenyakit'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      var Penyakit = jsonDecode(response.body);
      return Penyakit;
    } else {
      throw Exception('Failed to load penyakit');
    }
  }

  Future<void> getPenyakitDariObatByIdSpesialis(int idSpesialis) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/obat/spesialis/$idSpesialis'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      var dataObat = hasil;
      Set<int> idPenyakit = {};
      for (var item in dataObat) {
        idPenyakit.add(item['id_penyakit']);
      }
      List<int> idPenyakitList = idPenyakit.toList();
      for (var i = 0; i < idPenyakitList.length; i++) {
        dataPenyakitReservasi.add(await getPenyakitById(idPenyakitList[i]));
      }
    } else {
      throw Exception('Failed to load penyakit');
    }
  }

  Future<void> getObatByIdPenyakit(int idPenyakit) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/obat/penyakit/$idPenyakit'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      tempDataObat.addAll(hasil);
    } else {
      throw Exception('Failed to load penyakit');
    }
  }

  Future<List<Map<String, dynamic>>> getDaftarProfilPenyakitByReservasi(
      int idReservasi) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftar_profil_penyakit/$idReservasi'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var penyakit = await getPenyakitById(hasil[i]['id_penyakit']);
        hasil[i]['penyakit'] = penyakit['nama'];
      }
      return hasil;
    } else {
      throw Exception('Failed to load daftar profil penyakit');
    }
  }

  Future<void> setStatusDaftarProfilPenyakitById(
      int idDaftarProfilPenyakit, int status) async {
    final response = await http.put(
      Uri.parse(
          'http://127.0.0.1:8000/daftar_profil_penyakit/edit_status/$idDaftarProfilPenyakit'),
      headers: {
        'Authorization': 'Bearer ${state.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "status": status,
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load reservasi');
    }
  }

  Future<List<Map<String, dynamic>>> getDaftarProfilPenyakitAktifByReservasi(
      int idReservasi) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil_penyakit/aktif/$idReservasi'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var penyakit = await getPenyakitById(hasil[i]['id_penyakit']);
        hasil[i]['penyakit'] = penyakit['nama'];
      }
      return hasil;
    } else if (response.statusCode == 404) {
      List<Map<String, dynamic>> hasil = [];
      return hasil;
    } else {
      throw Exception('Failed to load daftar profil penyakit');
    }
  }

  Future<void> getDiagnosaPenyakitByReservasi(int idReservasi) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/daftar_profil_penyakit/$idReservasi'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataDiagnosaReservasi.addAll(hasil);
    } else {
      throw Exception('Failed to load diagnosa');
    }
  }

  Future<void> tambahProfilLain(int userID, String nama, String jenisKelamin,
      String tanggalLahir, String foto) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/profil_lain/$userID'),
      headers: {
        'Authorization': 'Bearer ${state.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "nama": nama,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": tanggalLahir,
        "foto": foto
      }),
    );

    if (response.statusCode == 200) {
      // Jika server mengembalikan respons OK
      print('Profil berhasil ditambahkan.');
    } else {
      // Jika server mengembalikan respons selain 200
      print('Gagal menambahkan profil: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> deleteReservasi(int reservasiId) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/reservasi/delete/$reservasiId'),
      headers: {
        'Authorization': 'Bearer ${state.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Menghapus reservasi dari local state jika diperlukan
      dataReservasi.removeWhere((reservasi) => reservasi['id'] == reservasiId);
      emit(AuthModel(
          userID: state.userID, accessToken: state.accessToken, error: ""));
    } else if (response.statusCode == 404) {
      emit(AuthModel(
          userID: state.userID,
          accessToken: state.accessToken,
          error: "Reservasi tidak ditemukan"));
    } else {
      emit(AuthModel(
          userID: state.userID,
          accessToken: state.accessToken,
          error: "Gagal menghapus reservasi"));
    }
  }

  Future<void> deleteProfilLainById(
      int idProfilLain, String accessToken) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/profil_lain/$idProfilLain'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        dataReservasi
            .removeWhere((profilLain) => profilLain['id'] == idProfilLain);
        emit(AuthModel(
            userID: state.userID, accessToken: state.accessToken, error: ""));
        print('Profile deleted successfully.');
      } else if (response.statusCode == 404) {
        emit(AuthModel(
            userID: state.userID,
            accessToken: state.accessToken,
            error: "Profil tidak ditemukan"));
        print('Profile not found.');
      } else {
        // Handle other errors
        print('Failed to delete profile.');
      }
    } catch (e) {
      // Handle exceptions
      print('Error deleting profile: $e');
    }
  }

  // Mengambil data radiologi berdasarkan id penyakit nya
  Future<Map<String, dynamic>> getRadiologiByIdPenyakit(int idPenyakit) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/radiologi/$idPenyakit'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      var Radiologi = jsonDecode(response.body);
      return Radiologi;
    } else {
      throw Exception('Failed to load radiologi');
    }
  }

  // Mengambil data lab berdasarkan id penyakit nya
  Future<Map<String, dynamic>> getLabByIdPenyakit(int idPenyakit) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/lab/$idPenyakit'), headers: {
      'Authorization': 'Bearer ${state.accessToken}',
    });

    if (response.statusCode == 200) {
      var Lab = jsonDecode(response.body);
      return Lab;
    } else {
      throw Exception('Failed to load Lab');
    }
  }

  Future<void> getLabByIdDaftarProfil(int idDaftarProfil) async {
    initializeDateFormatting('id_ID', null);
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil_penyakit/aktif/id_daftar_profil/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var tempPenyakit = await getPenyakitById(hasil[i]['id_penyakit']);

        var tanggal_lahir = dataProfil['tanggal_lahir'];
        DateTime tgl_lahir = DateTime.parse(tanggal_lahir);
        final hari_ini = DateTime.now();
        int umur = hari_ini.year - tgl_lahir.year;

        if (hari_ini.month < tgl_lahir.month ||
            (hari_ini.month == tgl_lahir.month &&
                hari_ini.day < tgl_lahir.day)) {
          umur--;
        }

        DateTime date = DateTime.parse(dataProfil['tanggal_lahir']);

        // Mengubah format tanggal ke '5 Juni 2019'
        String formattedDate = DateFormat('d MMMM y', 'id_ID').format(date);

        hasil[i]['nama_pasien'] = dataProfil['nama'];
        hasil[i]['tanggal_lahir'] = formattedDate;
        hasil[i]['jenis_kelamin'] = dataProfil['jenis_kelamin'];
        hasil[i]['umur'] = umur;
        hasil[i]['nama_penyakit'] = tempPenyakit['nama'];

        var tempLab = await getLabByIdPenyakit(hasil[i]['id_penyakit']);
        hasil[i]['nama_lab'] = tempLab['nama'];
        hasil[i]['deskripsi_lab'] = tempLab['deskripsi'];
      }
      dataLabProfil = hasil;
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load Daftar Lab Profil');
    }
  }

  Future<void> getLabByIdDaftarProfilLain(int idDaftarProfil, int idx) async {
    initializeDateFormatting('id_ID', null);
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil_penyakit/aktif/id_daftar_profil/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var tempPenyakit = await getPenyakitById(hasil[i]['id_penyakit']);

        var daftarprolin = await getProfilLainById(idx);
        var tanggal_lahir = daftarprolin['tanggal_lahir'];
        DateTime tgl_lahir = DateTime.parse(tanggal_lahir);
        final hari_ini = DateTime.now();
        int umur = hari_ini.year - tgl_lahir.year;

        if (hari_ini.month < tgl_lahir.month ||
            (hari_ini.month == tgl_lahir.month &&
                hari_ini.day < tgl_lahir.day)) {
          umur--;
        }

        String formattedDate =
            DateFormat('d MMMM y', 'id_ID').format(tgl_lahir);

        hasil[i]['nama_pasien'] = daftarprolin['nama'];
        hasil[i]['tanggal_lahir'] = formattedDate;
        hasil[i]['jenis_kelamin'] = daftarprolin['jenis_kelamin'];
        hasil[i]['umur'] = umur;
        hasil[i]['nama_penyakit'] = tempPenyakit['nama'];

        var tempLab = await getLabByIdPenyakit(hasil[i]['id_penyakit']);
        hasil[i]['nama_lab'] = tempLab['nama'];
        hasil[i]['deskripsi_lab'] = tempLab['deskripsi'];
      }
      dataLabProfilLain.addAll(hasil);
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load Daftar Lab Profil Lain');
    }
  }

  Future<void> getRadiologiByIdDaftarProfil(int idDaftarProfil) async {
    initializeDateFormatting('id_ID', null);
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil_penyakit/aktif/id_daftar_profil/radiologi/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var tempPenyakit = await getPenyakitById(hasil[i]['id_penyakit']);

        var tanggal_lahir = dataProfil['tanggal_lahir'];
        DateTime tgl_lahir = DateTime.parse(tanggal_lahir);
        final hari_ini = DateTime.now();
        int umur = hari_ini.year - tgl_lahir.year;

        if (hari_ini.month < tgl_lahir.month ||
            (hari_ini.month == tgl_lahir.month &&
                hari_ini.day < tgl_lahir.day)) {
          umur--;
        }

        DateTime date = DateTime.parse(dataProfil['tanggal_lahir']);

        // Mengubah format tanggal ke '5 Juni 2019'
        String formattedDate = DateFormat('d MMMM y', 'id_ID').format(date);

        hasil[i]['nama_pasien'] = dataProfil['nama'];
        hasil[i]['tanggal_lahir'] = formattedDate;
        hasil[i]['umur'] = umur;
        hasil[i]['nama_penyakit'] = tempPenyakit['nama'];

        var tempRadiologi = await getRadiologiByIdPenyakit(hasil[i]['id_penyakit']);
        hasil[i]['nama_radiologi'] = tempRadiologi['nama'];
        hasil[i]['deskripsi_radiologi'] = tempRadiologi['deskripsi'];
        hasil[i]['foto'] = tempRadiologi['foto'];
      }
      dataRadiologiProfil = hasil;
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load Daftar Radiologi Profil');
    }
  }

  Future<void> getRadiologiByIdDaftarProfilLain(int idDaftarProfil, int idx) async {
    initializeDateFormatting('id_ID', null);
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/daftar_profil_penyakit/aktif/id_daftar_profil/radiologi/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      for (var i = 0; i < hasil.length; i++) {
        var tempPenyakit = await getPenyakitById(hasil[i]['id_penyakit']);

        var daftarprolin = await getProfilLainById(idx);
        var tanggal_lahir = daftarprolin['tanggal_lahir'];
        DateTime tgl_lahir = DateTime.parse(tanggal_lahir);
        final hari_ini = DateTime.now();
        int umur = hari_ini.year - tgl_lahir.year;

        if (hari_ini.month < tgl_lahir.month ||
            (hari_ini.month == tgl_lahir.month &&
                hari_ini.day < tgl_lahir.day)) {
          umur--;
        }

        String formattedDate =
            DateFormat('d MMMM y', 'id_ID').format(tgl_lahir);

        hasil[i]['nama_pasien'] = daftarprolin['nama'];
        hasil[i]['tanggal_lahir'] = formattedDate;
        hasil[i]['umur'] = umur;
        hasil[i]['nama_penyakit'] = tempPenyakit['nama'];

        var tempRadiologi = await getRadiologiByIdPenyakit(hasil[i]['id_penyakit']);
        hasil[i]['nama_radiologi'] = tempRadiologi['nama'];
        hasil[i]['deskripsi_radiologi'] = tempRadiologi['deskripsi'];
        hasil[i]['foto'] = tempRadiologi['foto'];
      }
      dataRadiologiProfilLain.addAll(hasil);
    } else if (response.statusCode == 404) {
    } else {
      throw Exception('Failed to load Daftar Radiologi Profil Lain');
    }
  }

  Future<void> getNotifikasiByDaftarProfil(int idDaftarProfil) async {
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/$idDaftarProfil'),
        headers: {
          'Authorization': 'Bearer ${state.accessToken}',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Map<String, dynamic>> hasil =
          body.map((dynamic item) => item as Map<String, dynamic>).toList();
      dataNotifikasiProfil = hasil;
      for (var i = 0; i < dataNotifikasiProfil.length; i++) {
        var temp = await getJamKerjaDokterById(
            dataNotifikasiProfil[i]['id_jam_kerja_dokter']);
        dataNotifikasiProfil[i]['dokter'] = temp['dokter'];
        dataNotifikasiProfil[i]['id_spesialis'] = temp['id_spesialis'];
        dataNotifikasiProfil[i]['spesialis'] = temp['spesialis'];
        dataNotifikasiProfil[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        dataNotifikasiProfil[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
        dataNotifikasiProfil[i]['nama'] = dataProfil['nama'];
      }
    } else {
      throw Exception('Failed to load notifikasi');
    }
  }

  Future<void> getNotifikasiByDaftarProfilLain(
      int idDaftarProfil, int idx) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/reservasi/by_id_daftar_profil/$idDaftarProfil'),
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
        hasil[i]['id_spesialis'] = temp['id_spesialis'];
        hasil[i]['jam_awal'] = temp['jam_awal'].substring(0, 5);
        hasil[i]['jam_akhir'] = temp['jam_akhir'].substring(0, 5);
        var nama = await getProfilLainById(idx);
        hasil[i]['nama'] = nama['nama'];
      }
      dataNotifikasiProfilLain.addAll(hasil);
    } else {
      throw Exception('Failed to load notifikasi');
    }
  }
}
