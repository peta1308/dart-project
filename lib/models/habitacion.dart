import '../enums/estado_habitacion.dart';

class habitacion {
  var estado = estadoHabitacion.disponible;
  var tipoHabitacion;
  int? numeroAbitacion;

  habitacion(this.estado, this.tipoHabitacion, this.numeroAbitacion);
}
