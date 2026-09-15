import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';

void main() {
  var hotel = Hotel();

  hotel.registrarRecepcionista('admin', '1234');
  var resultado = hotel.iniciarSesion('admin', '123');

  if (resultado) {
    print("login exitoso");
  } else {
    print("login fallido");
  }
}
