import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/huesped.dart';

void main() {
  var hotel = Hotel();
  var huesped = Huesped('123', 'Emanuel');

  try {
    hotel.reservarHabitacion(
      huesped: huesped,
      numeroHabitacion: 999,
      diasEstadia: 2,
    );
    print("Error en T06: Debió fallar porque la habitación no existe");
  } catch (e) {
    print(
        "Prueba T06 Exitosa: Excepción capturada correctamente (${e.toString()})");
  }
}
