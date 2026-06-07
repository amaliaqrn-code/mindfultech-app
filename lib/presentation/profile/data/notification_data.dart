import '../models/notification_model.dart';

final List<NotificationModel> notifications = [
  NotificationModel(
    title: 'Streak - mu berlanjut',
    message:
        'Keren! kamu sudah 121 hari berturut turut menggunakan Mindful Tech.',
    time: 'Baru saja',
  ),

  NotificationModel(
    title: 'Batasi Waktu layar',
    message:
        'Kamu sudah mencapai 3 jam 45 menit hari ini. Ingat untuk beristirahat.',
    time: '08:45',
  ),

  NotificationModel(
    title: 'Saatnya fokus',
    message:
        'Sudah 45 menit sejak sesi fokus terakhirmu. Yuk mulai sesi fokus baru.',
    time: '09:30',
  ),

  NotificationModel(
    title: 'Jangan lupa bernafas',
    message: 'Ambil jeda sejenak dan lakukan latihan pernafasan.',
    time: '07:30',
  ),

  NotificationModel(
    title: 'Tips hari ini',
    message: 'Gunakan teknologi dengan sadar, bukan berlebihan.',
    time: '05:50',
  ),
];
