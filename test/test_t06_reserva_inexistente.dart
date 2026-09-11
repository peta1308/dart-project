import 'package:test/test.dart';
import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/huesped.dart';

void main() {
  test('T06 - Reserva inexistente', () {
    var hotel = Hotel();
    var huesped = Huesped('123', 'Emanuel');

    expect(
      () => hotel.reservarHabitacion(
        huesped: huesped,
        numeroHabitacion: 999,
        diasEstadia: 2,
      ),
      throwsA(isA<HotelException>()),
    );
  });
}
