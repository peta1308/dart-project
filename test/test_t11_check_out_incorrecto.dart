import 'package:test/test.dart';
import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/estado_habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/tipo_habitacion.dart';

void main() {
  test('T11 - Check-out incorrecto', () {
    var hab = Habitacion(
      numero: 101,
      tipo: TipoHabitacion.individual,
      capacidad: 2,
      precioPorNoche: 50.0,
      estado: estadoHabitacion.disponible,
    );
    var hotel = Hotel(habitacionesIniciales: [hab]);

    expect(
      () => hotel.hacerCheckOut(101),
      throwsA(isA<HotelException>()),
    );
  });
}
