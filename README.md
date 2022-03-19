# flutter_integration_test

A new Flutter project.

## Запуск теста

```shell
flutter test integration_test/app_test.dart
```

Если используем fvm и flavor:

```shell
fvm flutter test --flavor dev integration_test/app_test.dart
```

## Запуск теста с записью шейдеров
```shell
flutter drive --profile --no-dds --cache-sksl --purge-persistent-cache --write-sksl-on-exit integration_test_output/warming_up.sksl.json --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

Если используем fvm и flavor:

```shell
fvm flutter drive --profile --flavor dev --no-dds --cache-sksl --purge-persistent-cache --write-sksl-on-exit integration_test_output/warming_up.sksl.json --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```