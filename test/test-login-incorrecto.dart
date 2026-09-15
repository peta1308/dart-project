import 'package:hotel_cartagena_mod_reservas/models/recepcionista.dart';
import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';

void main() {
  var hotel = Hotel();
  hotel.registrarRecepcionista('e', '123');
  Recepcionista resultado = Recepcionista(usuario: 'e', contrasena: '321');

  // Llamas al método y evalúas si fue verdadero o falso
  var sesionIniciada =
      hotel.iniciarSesion(resultado.usuario!, resultado.contrasena!);

  if (sesionIniciada) {
    print('Inicio de sesión exitoso');
  } else {
    print('Error: Inicio de sesión fallido (usuario o contraseña incorrectos)');
  }
}
