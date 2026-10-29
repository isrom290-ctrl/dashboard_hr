// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_hr/main.dart';

void main() {
  testWidgets('Dashboard HR tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiHR());

    // Memastikan halaman dashboard tampil.
    expect(find.text('PT Maju Bersama'), findsOneWidget);
    expect(find.text('Karyawan'), findsOneWidget);
    expect(find.text('Hadir'), findsOneWidget);
    expect(find.text('Cuti'), findsOneWidget);
    expect(find.text('Rekrut'), findsOneWidget);
  });
}


