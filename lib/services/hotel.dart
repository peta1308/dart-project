import '../models/habitacion.dart';
import '../models/huesped.dart';
import '../models/recepcionista.dart';
import '../models/reserva.dart';
import '../models/check_in.dart';
import '../models/check_out.dart';
import '../enums/estado_habitacion.dart';
import '../enums/tipo_habitacion.dart';

class HotelException implements Exception {
  final String mensaje;
  HotelException(this.mensaje);

  @override
  String toString() => mensaje;

  String getMessage() {
    return mensaje;
  }
}

class Hotel {
  final List<Recepcionista> recepcionistas = [];
  final List<Habitacion> habitaciones = [];
  final List<Reserva> reservas = [];
  final List<CheckIn> checkIns = [];
  final List<CheckOut> checkOuts = [];

  Hotel({List<Habitacion>? habitacionesIniciales}) {
    if (habitacionesIniciales != null) {
      for (var h in habitacionesIniciales) {
        habitaciones.add(h);
      }
    }
  }

  void registrarRecepcionista(String usuario, String contrasena) {
    bool existeUsuario = false;

    for (var r in recepcionistas) {
      if (r.usuario == usuario) {
        existeUsuario = true;
      }
    }

    if (existeUsuario) {
      throw HotelException(
        'Ya existe un recepcionista con el usuario "$usuario".',
      );
    }

    recepcionistas.add(Recepcionista(usuario: usuario, contrasena: contrasena));
  }

  bool iniciarSesion(String usuario, String contrasena) {
    for (var r in recepcionistas) {
      if (r.usuario == usuario && r.contrasena == contrasena) {
        return true;
      }
    }
    return false;
  }

  Map<TipoHabitacion, List<Habitacion>> habitacionesDisponiblesPorTipo() {
    Map<TipoHabitacion, List<Habitacion>> agrupadas = {};

    for (var h in habitaciones) {
      if (h.estado == estadoHabitacion.disponible) {
        if (agrupadas[h.tipo] == null) {
          agrupadas[h.tipo] = [];
        }
        agrupadas[h.tipo]!.add(h);
      }
    }

    return agrupadas;
  }

  Habitacion _buscarHabitacion(int numero) {
    for (var h in habitaciones) {
      if (h.numero == numero) {
        return h;
      }
    }
    throw HotelException('No existe una habitación con el número $numero.');
  }

  Reserva reservarHabitacion({
    required Huesped huesped,
    required int numeroHabitacion,
    required int diasEstadia,
  }) {
    Habitacion habitacion = _buscarHabitacion(numeroHabitacion);

    if (habitacion.estado != estadoHabitacion.disponible) {
      throw HotelException(
        'La habitación $numeroHabitacion no está disponible.',
      );
    }

    if (diasEstadia <= 0) {
      throw HotelException('Los días de estadía deben ser mayores que cero.');
    }

    Reserva reserva = Reserva(
      id: 'R${reservas.length + 1}',
      huesped: huesped,
      habitacion: habitacion,
      diasEstadia: diasEstadia,
      activa: true,
    );

    habitacion.estado = estadoHabitacion.reservada;
    reservas.add(reserva);

    return reserva;
  }

  CheckIn hacerCheckIn({
    required int numeroHabitacion,
    required int cantidadPersonas,
  }) {
    Habitacion habitacion = _buscarHabitacion(numeroHabitacion);

    Reserva? reservaEncontrada;
    for (var r in reservas) {
      if (r.habitacion.numero == numeroHabitacion && r.activa) {
        reservaEncontrada = r;
      }
    }

    if (reservaEncontrada == null) {
      throw HotelException(
        'No hay una reserva activa para la habitación $numeroHabitacion.',
      );
    }

    if (habitacion.estado != estadoHabitacion.reservada) {
      throw HotelException(
        'La habitación $numeroHabitacion no está en estado reservada.',
      );
    }

    if (cantidadPersonas <= 0) {
      throw HotelException('La cantidad de personas debe ser mayor que cero.');
    }

    if (cantidadPersonas > habitacion.capacidad) {
      throw HotelException(
        'La cantidad de personas supera la capacidad de la habitación.',
      );
    }

    CheckIn checkIn = CheckIn(
      reserva: reservaEncontrada,
      cantidadPersonas: cantidadPersonas,
      fechaEntrada: null,
    );

    habitacion.estado = estadoHabitacion.ocupada;
    checkIns.add(checkIn);

    return checkIn;
  }

  CheckOut hacerCheckOut(int numeroHabitacion) {
    Habitacion habitacion = _buscarHabitacion(numeroHabitacion);

    if (habitacion.estado != estadoHabitacion.ocupada) {
      throw HotelException('La habitación $numeroHabitacion no está ocupada.');
    }

    CheckIn? checkInEncontrado;
    for (var c in checkIns) {
      if (c.reserva.habitacion.numero == numeroHabitacion) {
        checkInEncontrado = c;
      }
    }

    if (checkInEncontrado == null) {
      throw HotelException(
        'No se encontró el check-in de la habitación $numeroHabitacion.',
      );
    }

    CheckOut checkOut = CheckOut(checkIn: checkInEncontrado, fechaSalida: null);

    checkInEncontrado.reserva.activa = false;
    habitacion.estado = estadoHabitacion.disponible;
    checkOuts.add(checkOut);

    return checkOut;
  }
}
