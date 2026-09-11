import '../lib/models/habitacion.dart';
import '../lib/models/huesped.dart';
import '../lib/enums/tipo_habitacion.dart';
import '../lib/services/hotel.dart';

void main() {
  // Creamos el hotel con un par de habitaciones de ejemplo
  Hotel hotel = Hotel(habitacionesIniciales: [
    Habitacion(numero: 101, tipo: TipoHabitacion.individual, capacidad: 1, precioPorNoche: 80000),
    Habitacion(numero: 102, tipo: TipoHabitacion.doble, capacidad: 2, precioPorNoche: 120000),
  ]); 

  // Registrar un recepcionista y probar el login (RF01 y RF02)
  hotel.registrarRecepcionista('juan', '1234');
  print('Login correcto: ${hotel.iniciarSesion('juan', '1234')}');
  print('Login incorrecto: ${hotel.iniciarSesion('juan', 'malacontrasena')}');

  // Ver habitaciones disponibles agrupadas por tipo (RF03)
  print('\nHabitaciones disponibles:');
  Map<TipoHabitacion, List<Habitacion>> disponibles = hotel.habitacionesDisponiblesPorTipo();
  for (var tipo in disponibles.keys) {
    print('$tipo: ${disponibles[tipo]!.length} habitación(es)');
  }

  // Crear un huésped y hacer una reserva (RF04 y RF05)
  Huesped huesped = Huesped('123456', 'Carlos Pérez');
  var reserva = hotel.reservarHabitacion(
    huesped: huesped,
    numeroHabitacion: 101,
    diasEstadia: 3,
  );
  print('\nReserva creada: ${reserva.id}, estado habitación: ${reserva.habitacion.estado}');

  // 5 Hacer check-in (RF06)
  var checkIn = hotel.hacerCheckIn(numeroHabitacion: 101, cantidadPersonas: 1);
  print('Check-in hecho, estado habitación: ${checkIn.reserva.habitacion.estado}');

  // Hacer check-out (RF07)
  var checkOut = hotel.hacerCheckOut(101);
  print('Check-out hecho, total a pagar: ${checkOut.totalPagar}, estado habitación: ${checkOut.checkIn.reserva.habitacion.estado}');

  // Probamos a propósito un error, para ver que la excepción funciona
  try {
    hotel.reservarHabitacion(huesped: huesped, numeroHabitacion: 999, diasEstadia: 2);
  } catch (e) {
    print('Error esperado (habitación que no existe): $e');
  }
}
