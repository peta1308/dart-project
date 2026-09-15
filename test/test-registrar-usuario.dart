import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';

void main() {
  var hotel = Hotel();

  hotel.registrarRecepcionista('admin', '123');
  if (hotel.recepcionistas.length == 1) {
    print("Registro exitoso");
  } else {
    print("Error en el registro");
  }
}
