import 'package:test/test.dart';

import '../lib/services/hotel.dart';

void main() {
  test('T02 - Registrar usuario duplicado', () {
    var hotel = Hotel();
    hotel.registrarRecepcionista('admin', '1234');
    expect(
      () => hotel.registrarRecepcionista('admin', '9999'),
      throwsA(isA<HotelException>()),
    );
  });
}
