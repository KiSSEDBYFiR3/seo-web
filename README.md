[![Dart](https://github.com/KiSSEDBYFiR3/seo-web/actions/workflows/dart.yml/badge.svg)](https://github.com/KiSSEDBYFiR3/seo-web/actions/workflows/dart.yml) [![Codemagic build status](https://api.codemagic.io/apps/6588943748e4f246310c7932/6588943748e4f246310c7931/status_badge.svg)](https://codemagic.io/apps/6588943748e4f246310c7932/6588943748e4f246310c7931/latest_build)

# E-commerce приложение для тестирования SEO оптимизации в Flutter Web

## Конфигурация проекта

Flutter: 3.13.8 stable
Dart: 3.1.4

[Бэкенд](https://github.com/KiSSEDBYFiR3/e-com-backend)

Для запуска ввести команду `docker-compose up -d`

### Что было сделано:

- Добавлен robots.txt, который отдает nginx.
- Написал SEOHelper, который при вызове добавляет и обновляет в DOM метатеги и иную HTML информацию.
  Из-за того, что во Flutter Web отрисовка элементов происходит на канвасе (даже с HTML рендером), то полноценно выделить элементы в DOM не получится.
- Добавлена поддержка PWA.

### Что еще можно сделать

- Добавить sitemap.xml для подробного описания параметров индексации.
- Попытаться решить конфликт nginx и url стратегий.
  Сейчас если выбрать PathUrlStrategy, то при прямом переходе по ссылке отличной от корневой, nginx выдаст 404 ошибку.
- При необходимости добавить больше функционала в SEOHelper.
- Для удобства сделать SEOWidget, который будет делать то же самое, что и SEOHelper, но придерживаясь декларативной концепции. 

#### До оптимизации

**Desktop:**

![Desktop](https://github.com/KiSSEDBYFiR3/seo-web/assets/72256017/69a46a82-6488-4643-825b-f3b210e6cfc0)

**Mobile:**

![Mobile](https://github.com/KiSSEDBYFiR3/seo-web/assets/72256017/e65001f3-ee58-4079-9c81-c3c411f8a4a9)


#### После оптимизации

**Desktop:**

![Desktop](https://github.com/KiSSEDBYFiR3/seo-web/assets/72256017/7b3b9ba3-523e-42cd-a909-ab80aad243eb)

**Mobile:**

![Mobile](https://github.com/KiSSEDBYFiR3/seo-web/assets/72256017/d63275f1-4381-46a0-aa5d-5edfdeb330ba)
