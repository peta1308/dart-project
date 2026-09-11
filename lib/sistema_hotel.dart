import 'dart:io';

import 'services/hotel.dart';
import 'models/huesped.dart';
import 'models/habitacion.dart';
import 'enums/tipo_habitacion.dart';

class SistemaHotel {
  final Hotel _hotel;

  SistemaHotel({Hotel? hotel})
      : _hotel = hotel ?? _crearHotelConDatosIniciales() {
    _menuInicio();
  }

  static Hotel _crearHotelConDatosIniciales() {
    return Hotel(
      habitacionesIniciales: [
        Habitacion(
            numero: 101,
            tipo: TipoHabitacion.individual,
            capacidad: 1,
            precioPorNoche: 80000),
        Habitacion(
            numero: 102,
            tipo: TipoHabitacion.individual,
            capacidad: 1,
            precioPorNoche: 80000),
        Habitacion(
            numero: 201,
            tipo: TipoHabitacion.doble,
            capacidad: 2,
            precioPorNoche: 130000),
        Habitacion(
            numero: 202,
            tipo: TipoHabitacion.doble,
            capacidad: 2,
            precioPorNoche: 130000),
        Habitacion(
            numero: 301,
            tipo: TipoHabitacion.triple,
            capacidad: 3,
            precioPorNoche: 170000),
        Habitacion(
            numero: 401,
            tipo: TipoHabitacion.cuadruple,
            capacidad: 4,
            precioPorNoche: 210000),
      ],
    );
  }

  void _menuInicio() {
    bool salir = false;

    while (!salir) {
      _limpiarPantallaLogica();
      print('==========================================');
      print('   HOTEL CARTAGENA - SISTEMA DE RESERVAS');
      print('==========================================');
      print('1. Registrar recepcionista');
      print('2. Iniciar sesión');
      print('3. Salir');

      String opcion = _leerOpcion(['1', '2', '3']);

      switch (opcion) {
        case '1':
          _registrarRecepcionista();
          break;
        case '2':
          _iniciarSesion();
          break;
        case '3':
          salir = true;
          print('\nGracias por usar el sistema del Hotel Cartagena.');
          break;
      }
    }
  }

  void _menuRecepcionista(String usuario) {
    bool cerrarSesion = false;

    while (!cerrarSesion) {
      _limpiarPantallaLogica();
      print('==========================================');
      print('   MENÚ RECEPCIONISTA - Sesión: $usuario');
      print('==========================================');
      print('1. Consultar habitaciones disponibles');
      print('2. Reservar habitación');
      print('3. Registrar check-in');
      print('4. Registrar check-out');
      print('5. Cerrar sesión');

      String opcion = _leerOpcion(['1', '2', '3', '4', '5']);

      switch (opcion) {
        case '1':
          _consultarHabitaciones();
          break;
        case '2':
          _reservarHabitacion();
          break;
        case '3':
          _realizarCheckIn();
          break;
        case '4':
          _realizarCheckOut();
          break;
        case '5':
          cerrarSesion = true;
          print('\nSesión cerrada. Hasta pronto, $usuario.');
          break;
      }
    }
  }

  void _registrarRecepcionista() {
    print('\n--- Registro de recepcionista ---');
    String usuario = _leerTextoNoVacio('Usuario: ');
    String contrasena = _leerTextoNoVacio('Contraseña: ');

    try {
      _hotel.registrarRecepcionista(usuario, contrasena);
      print('\nRecepcionista registrado exitosamente.');
    } on HotelException catch (e) {
      print('\nNo se pudo registrar: $e');
    }

    _pausar();
  }

  void _iniciarSesion() {
    print('\n--- Inicio de sesión ---');
    String usuario = _leerTextoNoVacio('Usuario: ');
    String contrasena = _leerTextoNoVacio('Contraseña: ');

    bool acceso = _hotel.iniciarSesion(usuario, contrasena);

    if (acceso) {
      print('\nAcceso concedido. Bienvenido, $usuario.');
      _pausar();
      _menuRecepcionista(usuario);
    } else {
      print('\nUsuario o contraseña incorrectos.');
      _pausar();
    }
  }

  void _consultarHabitaciones() {
    print('\n--- Habitaciones disponibles ---');
    Map<TipoHabitacion, List<Habitacion>> agrupadas =
        _hotel.habitacionesDisponiblesPorTipo();

    if (agrupadas.isEmpty) {
      print('No hay habitaciones disponibles en este momento.');
    } else {
      agrupadas.forEach((tipo, habitaciones) {
        print('\nTipo: ${_nombreTipo(tipo)}');
        for (var h in habitaciones) {
          print(
              '  - Habitación ${h.numero} | Capacidad: ${h.capacidad} | Precio/noche: \$${h.precioPorNoche.toStringAsFixed(0)}');
        }
      });
    }

    _pausar();
  }

  void _reservarHabitacion() {
    print('\n--- Reservar habitación ---');
    String cedula = _leerTextoNoVacio('Cédula del huésped: ');
    String nombre = _leerTextoNoVacio('Nombre del huésped: ');
    int numeroHabitacion = _leerEntero('Número de habitación: ');
    int dias = _leerEntero('Cantidad de días de estadía: ');

    try {
      var huesped = Huesped(cedula, nombre);
      var reserva = _hotel.reservarHabitacion(
        huesped: huesped,
        numeroHabitacion: numeroHabitacion,
        diasEstadia: dias,
      );
      print('\nReserva creada con éxito. ID de reserva: ${reserva.id}');
    } on HotelException catch (e) {
      print('\nNo se pudo crear la reserva: $e');
    }

    _pausar();
  }

  void _realizarCheckIn() {
    print('\n--- Registrar check-in ---');
    int numeroHabitacion = _leerEntero('Número de habitación: ');
    int personas = _leerEntero('Cantidad de personas: ');

    try {
      _hotel.hacerCheckIn(
          numeroHabitacion: numeroHabitacion, cantidadPersonas: personas);
      print(
          '\nCheck-in realizado con éxito. La habitación $numeroHabitacion está ahora ocupada.');
    } on HotelException catch (e) {
      print('\nNo se pudo realizar el check-in: $e');
    }

    _pausar();
  }

  void _realizarCheckOut() {
    print('\n--- Registrar check-out ---');
    int numeroHabitacion = _leerEntero('Número de habitación: ');

    try {
      var checkOut = _hotel.hacerCheckOut(numeroHabitacion);
      print(
          '\nCheck-out realizado con éxito. La habitación $numeroHabitacion quedó disponible.');
      print('Total a pagar: \$${checkOut.totalPagar.toStringAsFixed(0)}');
    } on HotelException catch (e) {
      print('\nNo se pudo realizar el check-out: $e');
    }

    _pausar();
  }

  String _leerTextoNoVacio(String mensaje) {
    String? entrada;
    do {
      stdout.write(mensaje);
      entrada = stdin.readLineSync()?.trim();
      if (entrada == null || entrada.isEmpty) {
        print('Este dato no puede estar vacío. Intente nuevamente.');
      }
    } while (entrada == null || entrada.isEmpty);

    return entrada;
  }

  int _leerEntero(String mensaje) {
    while (true) {
      String texto = _leerTextoNoVacio(mensaje);
      int? valor = int.tryParse(texto);
      if (valor != null) {
        return valor;
      }
      print('Debe ingresar un número entero válido. Intente nuevamente.');
    }
  }

  String _leerOpcion(List<String> opcionesValidas) {
    while (true) {
      stdout.write('\nSeleccione una opción: ');
      String? entrada = stdin.readLineSync()?.trim();
      if (entrada != null && opcionesValidas.contains(entrada)) {
        return entrada;
      }
      print('Opción inválida. Intente nuevamente.');
    }
  }

  String _nombreTipo(TipoHabitacion tipo) {
    switch (tipo) {
      case TipoHabitacion.individual:
        return 'Individual';
      case TipoHabitacion.doble:
        return 'Doble';
      case TipoHabitacion.triple:
        return 'Triple';
      case TipoHabitacion.cuadruple:
        return 'Cuádruple';
    }
  }

  void _pausar() {
    stdout.write('\nPresione ENTER para continuar...');
    stdin.readLineSync();
  }

  void _limpiarPantallaLogica() {
    print('\n' * 2);
  }
}
