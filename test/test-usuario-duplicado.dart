import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';

void main() {
  var hotel = Hotel();

  hotel.registrarRecepcionista('admin', '123');

  try {
    hotel.registrarRecepcionista('admin', '123');
  } catch (HotelException) {
    print(HotelException);
  }
}
