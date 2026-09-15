import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/estado_habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/tipo_habitacion.dart';

void main() {
  var hab = Habitacion(
    numero: 101,
    tipo: TipoHabitacion.individual,
    capacidad: 2,
    precioPorNoche: 50.0,
    estado: estadoHabitacion.disponible,
  );
  var hotel = Hotel(habitacionesIniciales: [hab]);

  try {
    hotel.hacerCheckOut(101);
    print("Error en T11: Debió fallar porque no estaba ocupada");
  } catch (e) {
    print(
        "Prueba T11 Exitosa: Excepción capturada correctamente (${e.toString()})");
  }
}
