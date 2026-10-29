
import 'package:flutter/material.dart';

class DashboardHR extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const DashboardHR({
    super.key,
    required this.onToggleTheme,
  });

  static const List<Map<String, dynamic>> _statistik = [
    {
      'judul': 'Karyawan',
      'nilai': '248',
      'icon': Icons.people,
      'warna': Color(0xFF1565C0),
    },
    {
      'judul': 'Hadir',
      'nilai': '95%',
      'icon': Icons.check_circle,
      'warna': Color(0xFF00897B),
    },
    {
      'judul': 'Cuti',
      'nilai': '12',
      'icon': Icons.beach_access,
      'warna': Color(0xFF8E24AA),
    },
    {
      'judul': 'Rekrut',
      'nilai': '3',
      'icon': Icons.person_add,
      'warna': Color(0xFFB71C1C),
    },
  ];

  static const List<Map<String, dynamic>> _kehadiran = [
    {'divisi': 'Engineering', 'persentase': 92},
    {'divisi': 'Sales', 'persentase': 85},
    {'divisi': 'HR', 'persentase': 97},
    {'divisi': 'Finance', 'persentase': 90},
  ];

  static const List<Map<String, dynamic>> _aktivitas = [
    {
      'nama': 'Budi Santoso',
      'aksi': 'Mengajukan cuti',
      'waktu': '09:14',
      'icon': Icons.beach_access,
      'warna': Color(0xFFEF9A32),
    },
    {
      'nama': 'Citra Dewi',
      'aksi': 'Check-in absensi',
      'waktu': '08:02',
      'icon': Icons.check_circle,
      'warna': Color(0xFF43A047),
    },
    {
      'nama': 'Eko Wahyudi',
      'aksi': 'Upload kontrak baru',
      'waktu': '07:45',
      'icon': Icons.description,
      'warna': Color(0xFF1E88E5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.business, size: 26),
            const SizedBox(width: 10),
            const Flexible(
              child: Text(
                'PT Maju Bersama',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Aktifkan light mode' : 'Aktifkan dark mode',
            onPressed: onToggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                tooltip: 'Notifikasi',
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 4),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white24,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/id/64/100/100',
                  width: 34,
                  height: 34,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bannerSapaan(context, isDark),
                    const SizedBox(height: 20),

                    GridView.count(
                      crossAxisCount: isTablet ? 4 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      childAspectRatio: isTablet ? 1.8 : 1.45,
                      children: _statistik.map((item) {
                        return _kartuStatistik(
                          context,
                          item,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Kehadiran per Divisi',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: _kehadiran.map((item) {
                            final index =
                                _kehadiran.indexOf(item);

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index ==
                                        _kehadiran.length - 1
                                    ? 0
                                    : 18,
                              ),
                              child: _barKehadiran(
                                context,
                                item['divisi'] as String,
                                item['persentase'] as int,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Aktivitas Terkini',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Lihat Semua'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    ..._aktivitas.map((item) {
                      return _kartuAktivitas(context, item);
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bannerSapaan(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: isDark
              ? const [
                  Color(0xFF17365D),
                  Color(0xFF34234F),
                ]
              : const [
                  Color(0xFF1565C0),
                  Color(0xFF7B4397),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Pagi, Admin!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Selamat bekerja hari ini.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.waving_hand,
            color: Colors.white,
            size: 42,
          ),
        ],
      ),
    );
  }

  Widget _kartuStatistik(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final warna = item['warna'] as Color;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: warna.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: warna,
                size: 23,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['nilai'] as String,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: warna,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['judul'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? Colors.white70
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _barKehadiran(
    BuildContext context,
    String divisi,
    int persentase,
  ) {
    final warna = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            divisi,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: persentase / 100,
              minHeight: 12,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              valueColor:
                  AlwaysStoppedAnimation<Color>(warna),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 38,
          child: Text(
            '$persentase%',
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _kartuAktivitas(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final warna = item['warna'] as Color;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        leading: CircleAvatar(
          backgroundColor: warna.withOpacity(0.15),
          child: Icon(
            item['icon'] as IconData,
            color: warna,
            size: 20,
          ),
        ),
        title: Text(
          item['nama'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(item['aksi'] as String),
        trailing: Text(
          item['waktu'] as String,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
