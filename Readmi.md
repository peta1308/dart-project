# Hotel_cartagenena_mod_reservas

## Objetivo

Sistema de consola en Dart que permite a los recepcionistas del **Hotel Cartagena** administrar
habitaciones y huéspedes: registrar recepcionistas, iniciar sesión, consultar habitaciones
disponibles, reservar habitaciones, realizar check-in y realizar check-out. El proyecto se
desarrolló de forma modular, separando modelos, enumeraciones, lógica de negocio e interfaz de
consola en archivos independientes.

## Descripción breve del funcionamiento

Al iniciar el programa se muestra un menú principal donde el usuario puede **registrarse como
recepcionista** o **iniciar sesión**. Una vez autenticado, accede al menú de recepcionista, desde
donde puede:

- Consultar las habitaciones disponibles, agrupadas por tipo (individual, doble, triple, cuádruple).
- Reservar una habitación disponible indicando los datos del huésped y la cantidad de días.
- Registrar el check-in de una reserva activa, validando la capacidad de la habitación.
- Registrar el check-out de una habitación ocupada, liberándola y calculando el total a pagar.

Toda la lógica de negocio y las validaciones viven en la clase `Hotel`
(`lib/services/hotel.dart`); la clase `SistemaHotel` (`lib/sistema_hotel.dart`) solo se encarga de
mostrar los menús y capturar datos del usuario; `bin/main.dart` únicamente arranca la aplicación.

## Estructura de carpetas

```
Hotel_cartagenena_mod_reservas/
├── bin/
│   └── main.dart                # Punto de entrada de la aplicación
├── lib/
│   ├── models/
│   │   ├── habitacion.dart
│   │   ├── huesped.dart
│   │   ├── recepcionista.dart
│   │   ├── reserva.dart
│   │   ├── check_in.dart
│   │   └── check_out.dart
│   ├── enums/
│   │   ├── tipo_habitacion.dart
│   │   └── estado_habitacion.dart
│   ├── services/
│   │   └── hotel.dart           # Lógica de negocio y reglas de reservas
│   └── sistema_hotel.dart       # Menús e interfaz de consola
├── test/
│   ├── test_t01_registrar_usuario_nuevo.dart
│   ├── test_t02_registrar_usuario_duplicado.dart
│   ├── test_t03_login_correcto.dart
│   ├── test_t04_login_incorrecto.dart
│   ├── test_t05_reserva_correcta.dart
│   ├── test_t06_reserva_inexistente.dart
│   ├── test_t07_reserva_no_disponible.dart
│   ├── test_t08_check_in_correcto.dart
│   ├── test_t09_check_in_excede_capacidad.dart
│   ├── test_t10_check_out_correcto.dart
│   ├── test_t11_check_out_incorrecto.dart
│   └── test_t12_entrada_vacia.dart
├── pubspec.yaml
└── README.md
```

## Cómo instalar / ejecutar el proyecto

1. Tener instalado el [Dart SDK](https://dart.dev/get-dart) (versión 3.0.0 o superior).
2. Ubicarse en la carpeta raíz del proyecto.
3. Instalar las dependencias:
   ```
   dart pub get
   ```
4. Ejecutar la aplicación:
   ```
   dart run bin/main.dart
   ```
5. Ejecutar las pruebas automatizadas:
   ```
   dart test
   ```

## Reglas de negocio implementadas

- Una habitación nueva comienza en estado **disponible**.
- Una habitación solo puede reservarse si está **disponible**; al reservarse pasa a **reservada**.
- El check-in solo se permite sobre una habitación **reservada** con una reserva activa asociada;
  al completarse, la habitación pasa a **ocupada**.
- El número de personas del check-in debe ser mayor que cero y no puede superar la capacidad de la
  habitación.
- El check-out solo se permite sobre una habitación **ocupada**; al completarse, la habitación
  vuelve a **disponible** y se calcula el total a pagar (`días de estadía × precio por noche`).
- **Decisión de diseño:** al hacer check-out, la reserva no se elimina; se marca como `activa =
  false` y queda almacenada en la lista de reservas del hotel, funcionando como historial. Esto
  permite conservar un registro de todas las reservas realizadas, incluso las ya finalizadas.

## Casos de prueba realizados

| ID | Caso | Resultado esperado | Archivo |
|----|------|---------------------|---------|
| T01 | Registrar usuario nuevo | Registro exitoso | `test_t01_registrar_usuario_nuevo.dart` |
| T02 | Registrar usuario duplicado | El segundo registro se rechaza | `test_t02_registrar_usuario_duplicado.dart` |
| T03 | Login correcto | Acceso permitido | `test_t03_login_correcto.dart` |
| T04 | Login incorrecto | Acceso rechazado | `test_t04_login_incorrecto.dart` |
| T05 | Reserva correcta | Reserva creada, estado reservada | `test_t05_reserva_correcta.dart` |
| T06 | Reserva sobre habitación inexistente | Operación rechazada | `test_t06_reserva_inexistente.dart` |
| T07 | Reserva sobre habitación no disponible | Operación rechazada | `test_t07_reserva_no_disponible.dart` |
| T08 | Check-in correcto | Estado ocupado | `test_t08_check_in_correcto.dart` |
| T09 | Check-in excede capacidad | Operación rechazada | `test_t09_check_in_excede_capacidad.dart` |
| T10 | Check-out correcto | Estado disponible | `test_t10_check_out_correcto.dart` |
| T11 | Check-out sobre habitación disponible | Operación rechazada | `test_t11_check_out_incorrecto.dart` |
| T12 | Entrada vacía | Se solicita el dato nuevamente | `test_t12_entrada_vacia.dart` |

Para ejecutar todos los casos: `dart test`.

## Integrantes y responsabilidad de cada uno

| Integrante | Responsabilidad |
|------------|------------------|
| Libardo Villero | _(completar: p. ej. Modelos y enumeraciones)_ |
| Jean Paul Vega | _(completar: p. ej. Lógica de negocio — clase Hotel)_ |
| Keiner Tetay | _(completar: p. ej. Interfaz de consola)_ |
| Emanuel Arroyo | _(completar: p. ej. Pruebas y calidad)_ |

> Reemplacen cada campo "(completar...)" con la responsabilidad real de cada integrante, según lo
> acordado en el grupo (sección 5 de la guía).

## Dificultades encontradas y cómo fueron solucionadas

_(completar por el grupo, por ejemplo:)_

- **Manejo de la relación entre reserva, check-in y check-out:** se resolvió creando una clase
  `CheckIn` que referencia a la `Reserva`, y una clase `CheckOut` que referencia al `CheckIn`, de
  forma que cada estado del ciclo de vida de la habitación queda registrado en una clase distinta.
- **Validación de entradas del usuario en consola:** se centralizó en métodos reutilizables
  (`_leerTextoNoVacio`, `_leerEntero`, `_leerOpcion`) dentro de `SistemaHotel`, evitando repetir la
  lógica de validación en cada opción del menú.
- _(agreguen aquí las dificultades reales que tuvo el equipo)_