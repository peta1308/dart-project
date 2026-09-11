import 'package:test/test.dart';
import '../lib/services/hotel.dart';

void main() {
  test('T04 - Login incorrecto', () {
    var hotel = Hotel();
    hotel.registrarRecepcionista('admin', '1234');
    var resultado = hotel.iniciarSesion('admin', 'clave_mala');
    expect(resultado, isFalse);
  });
}
