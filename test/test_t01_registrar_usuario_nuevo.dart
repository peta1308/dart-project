import 'package:test/test.dart';
import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';

void main() {
  test('T01 - Registrar usuario nuevo', () {
    var hotel = Hotel();
    hotel.registrarRecepcionista('admin', '1234');
    expect(hotel.recepcionistas.length, equals(1));
  });
} //.
