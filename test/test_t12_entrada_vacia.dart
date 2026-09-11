import 'package:test/test.dart';

void main() {
  test('T12 - Entrada vacia', () {
    String entrada = '';
    bool esInvalido = entrada.trim().isEmpty;
    expect(esInvalido, isTrue);
  });
}
