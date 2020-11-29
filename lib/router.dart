import 'dart:typed_data';

import 'package:amr_apps/ui/auth_screen.dart';
import 'package:amr_apps/ui/cari_member_pasang_baru_screen.dart';
import 'package:amr_apps/ui/cari_member_pemeriksaan_screen.dart';
import 'package:amr_apps/ui/detail_wo_pemasangan_screen.dart';
import 'package:amr_apps/ui/detail_wo_pemeriksaan_screen.dart';
import 'package:amr_apps/ui/hasil_pemeriksaan_screen.dart';
import 'package:amr_apps/ui/history_screen.dart';
import 'package:amr_apps/ui/home_dashboard.dart';
import 'package:amr_apps/ui/home_screen.dart';
import 'package:amr_apps/ui/login_screen.dart';
import 'package:amr_apps/ui/pemasangan_pelanggan_kedua.dart';
import 'package:amr_apps/ui/pemasangan_pelanggan_pertama.dart';
import 'package:amr_apps/ui/pemeriksaan_pelanggan_kedua.dart';
import 'package:amr_apps/ui/pemeriksaan_pelanggan_ketiga_screen.dart';
import 'package:amr_apps/ui/pemeriksaan_pelanggan_pertama.dart';
import 'package:amr_apps/ui/search_sreen.dart';
import 'package:amr_apps/ui/signature_pemasangan_pelanggan_view.dart';
import 'package:amr_apps/ui/signature_pemasangan_petugas_view.dart';
import 'package:amr_apps/ui/signature_pemeriksaan_pelanggan_view.dart';
import 'package:amr_apps/ui/signature_pemeriksaan_petugas_view.dart';
import 'package:amr_apps/ui/tindak_lanjut_screen.dart';
import 'package:amr_apps/ui/ubah_password.dart';
import 'package:amr_apps/ui/upload_foto_screen.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'core/model/Berita_Acara.dart';
import 'core/model/Pelanggan.dart';
import 'core/model/WorkOrder.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        print("Load Home Screen");
        return MaterialPageRoute(builder: (_) => HomeDashboard());
      case 'auth':
        print("Load Auth Screen");
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/detail_pemeriksaan':
        var wo = settings.arguments as WorkOrder;
        return MaterialPageRoute(
            builder: (_) => DetailWoPemeriksaanScreen(
              workOrder: wo,
              ));
      case '/detail_pemasangan':
        var wo = settings.arguments as WorkOrder;
        return MaterialPageRoute(
            builder: (_) => DetailWoPemasanganScreen(
                  workOrder: wo,
                ));
      case '/detail_pemeriksaan/first':
        var pel = settings.arguments as Pelanggan;
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganPertamaScreen(
                  pelangganID: pel.id,
                  pelanggan: pel,
                ));
      case '/hasil_pemeriksaan':
        var pel = settings.arguments as Pelanggan;
        return MaterialPageRoute(
            builder: (_) => HasilPemeriksaanScreen(
                  enableForm: true,
                  pelangganID: pel.id,
                  pelanggan: pel,
                ));
      case '/tindak_lanjut':
        var map = settings.arguments as Map<String, dynamic>;
        var pel = map['pelanggan'] as Pelanggan;
        var hasil_pemeriksaan = map['hasil_pemeriksaan'] as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => TindakLanjutScreen(
                enableForm: true,
                pelanggan: pel,
                pelangganID: pel.id,
                hasil_pemeriksaan: hasil_pemeriksaan));
      case '/detail_pemasangan/first':
        var pel = settings.arguments as Pelanggan;
        return MaterialPageRoute(
            builder: (_) => PemasanganPelangganPertamaScreen(
                  pelangganID: pel.id,
                ));
      case '/view/detail_pemasangan/first':
        var ba = settings.arguments as Berita_Acara;
        return MaterialPageRoute(
            builder: (_) => PemasanganPelangganPertamaScreen(
                  pemeriksaanID: ba.id,
                  pelangganID: ba.pelangganID,
                  beritaAcara: ba,
                  enableForm: false,
                ));
      case '/detail_pemasangan/second':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var result = data['result'];
        return MaterialPageRoute(
            builder: (_) => PemasanganPelangganKeduaScreen(
                beritaAcara: ba, result: result));
      case '/view/detail_pemasangan/second':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var result = data['result'];
        return MaterialPageRoute(
            builder: (_) => PemasanganPelangganKeduaScreen(
                beritaAcara: ba, result: result, enableForm: false));
      case '/detail_pemeriksaan/first':
        var pel = settings.arguments as Pelanggan;
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganPertamaScreen(
                  pelangganID: pel.id,
                ));
      case '/view/detail_pemeriksaan/first':
        var ba = settings.arguments as Berita_Acara;
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganPertamaScreen(
                pemeriksaanID: ba.id,
                pelangganID: ba.pelangganID,
                beritaAcara: ba,
                enableForm: false));
      case '/detail_pemeriksaan/second':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var hasil_pemeriksaan = data['hasil_pemeriksaan'] as List;
        var tindak_lanjut = data['tindak_lanjut'] as List;
        var pelanggan = data['pelanggan'] as Pelanggan;
        print("Result : " + data.toString());
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganKeduaScreen(
                  pelangganID: pelanggan.id,
                  tindak_lanjut: tindak_lanjut,
                  pelanggan: pelanggan,
                  hasil_pemeriksaan: hasil_pemeriksaan,
                  beritaAcara: ba,
                ));
      case '/view/detail_pemeriksaan/second':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var enableForm = data['enableForm'];
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganKeduaScreen(
                pelangganID: ba.pelangganID,
                beritaAcara: ba,
                enableForm: enableForm));
      case '/detail_pemeriksaan/third':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var hasil_pemeriksaan = data['hasil_pemeriksaan'] as List;
        var tindak_lanjut = data['tindak_lanjut'] as List;
        var pelanggan = data['pelanggan'] as Pelanggan;
        print(ba);
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganKetigaScreen(
                  beritaAcara: ba,
                  pelanggan: pelanggan,
                  hasil_pemeriksaan: hasil_pemeriksaan,
                  tindak_lanjut: tindak_lanjut,
                  pelangganID: pelanggan.id,
                ));
      case '/view/detail_pemeriksaan/third':
        var ba = settings.arguments as Berita_Acara;
        print(ba);
        return MaterialPageRoute(
            builder: (_) => PemeriksaanPelangganKetigaScreen(
                beritaAcara: ba, enableForm: false));
      case '/signaturePelanggan':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var hasil_pemeriksaan = data['hasil_pemeriksaan'] as List;
        var tindak_lanjut = data['tindak_lanjut'] as List;
        var pelanggan = data['pelanggan'] as Pelanggan;
        return MaterialPageRoute(
            builder: (_) => SignatureView(
                beritaacara: ba,
                pelanggan: pelanggan,
                hasil_pemeriksaan: hasil_pemeriksaan,
                tindak_lanjut: tindak_lanjut));
      case '/signaturePetugas':
        var data = settings.arguments as Map<String, dynamic>;
        var ba = data['berita_acara'] as Berita_Acara;
        var hasil_pemeriksaan = data['hasil_pemeriksaan'] as List;
        var tindak_lanjut = data['tindak_lanjut'] as List;
        var pelanggan = data['pelanggan'] as Pelanggan;
        var signaturePelanggan = data['signature_pelanggan'] as Uint8List;
        print("Signature Pelanggan :" + signaturePelanggan.toString());
        return MaterialPageRoute(
            builder: (_) => SignaturePetugasScreen(
                beritaacara: ba,
                signaturePelanggan: signaturePelanggan,
                pelanggan: pelanggan,
                hasil_pemeriksaan: hasil_pemeriksaan,
                tindak_lanjut: tindak_lanjut));
      case '/cari_pasang_baru':
        return MaterialPageRoute(builder: (_) => CariMemberPasangBaruScreen());
      case '/cari_pemeriksaan':
        return MaterialPageRoute(builder: (_) => CariMemberPemeriksaanScreen());
      case '/history':
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case '/search_history':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/ubah_password':
        return MaterialPageRoute(builder: (_) => UbahPassword());
      case '/upload_foto':
       var data = settings.arguments as Map<String, dynamic>;
      var pelanggan = data['pelanggan'] as Pelanggan;
        return MaterialPageRoute(builder: (_) => UploadFotoScreen(
          pelanggan: pelanggan,
        ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text("No route defined for ${settings.name}")),
                ));
    }
  }
}
