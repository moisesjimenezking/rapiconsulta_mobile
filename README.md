# RapiConsulta Mobile

Aplicacion Flutter para consultar cedulas y RIF venezolanos usando la API de RapiConsulta.

## Requisitos

- Flutter 3.x
- Dart 3.x
- Android SDK (para compilar APK)

## Instalacion

```bash
cd mobile
flutter pub get
```

## Ejecutar en modo desarrollo

```bash
flutter run
```

## Compilar

### Debug APK

```bash
flutter build apk --debug
```

El APK queda en `build/app/outputs/flutter-apk/app-debug.apk`.

### Release APK

```bash
flutter build apk --release
```

### Release con firma (produccion)

Configura tu archivo `android/key.properties`:

```properties
storePassword=tu_password
keyPassword=tu_password
keyAlias=upload
storeFile=/ruta/a/tu/keystore.jks
```

Luego compila:

```bash
flutter build apk --release
```

o genera un bundle para subirla a Play Store:

```bash
flutter build appbundle --release
```

La API endpoint se configura en `lib/services/api_service.dart`.
