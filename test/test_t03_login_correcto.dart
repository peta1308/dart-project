import 'package:test/test.dart';
import '../lib/services/hotel.dart';

void main() {
  test('T03 - Login correcto', () {
    var hotel = Hotel();
    hotel.registrarRecepcionista('admin', '1234');
    var resultado = hotel.iniciarSesion('admin', '1234');
    expect(resultado, isTrue);
  });
}
