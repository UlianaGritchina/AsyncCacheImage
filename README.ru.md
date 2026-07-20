# AsyncCacheImage

**Swift Package для асинхронной загрузки изображений с кэшированием в памяти и на диске.**
<br>Используется так же, как `AsyncImage` в SwiftUI, но с автоматическим кэшированием изображений. [Read in English](README.md)

## Архитектура

<img width="1536" height="1024" alt="69DC92F2-940B-4DE0-9734-E397D5B8EE7A" src="https://github.com/user-attachments/assets/0ebe6977-ce7a-4733-8445-ca2631224cd7" />

### Конвейер загрузки

```text
Кэш в памяти
      │
      ▼ (не найдено)
Кэш на диске
      │
      ▼ (не найдено)
Сеть
```

При запросе изображения библиотека выполняет следующие шаги:

1. Проверяет наличие изображения в кэше памяти.
2. Если изображение отсутствует, проверяет кэш на диске.
3. Если изображение не найдено, загружает его из сети.
4. После успешной загрузки сохраняет изображение в память и на диск.

## Требования

- iOS 17.0+
- Swift 6.2+

## Установка

Добавьте пакет с помощью Swift Package Manager:

```swift
.package(
    url: "https://github.com/UlianaGritchina/AsyncCacheImage.git",
    from: "1.0.3"
)
```

## Использование

```swift
import AsyncCacheImage
import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!

    var body: some View {
        AsyncCacheImage(url: url) { image, data in
            image
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
    }
}
```

### Использование стандартного placeholder

```swift
AsyncCacheImage(url: url) { image, data in
    image
        .resizable()
        .frame(width: 200, height: 200)
        .cornerRadius(10)
}
```

## DefaultAsyncCacheImage

Готовый к использованию компонент с предустановленным оформлением и стандартным placeholder.

```swift
import AsyncCacheImage
import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!

    var body: some View {
        DefaultAsyncCacheImage(url: url)
    }
}
```

## Инициализатор

Создает `AsyncCacheImage`, который асинхронно загружает изображение по указанному URL и автоматически кэширует его.

### Параметры

- `url` — URL изображения.
- `content` — `ViewBuilder`, получающий загруженный `Image` и исходные данные изображения (`Data`).
- `placeholder` — `ViewBuilder`, отображаемый во время загрузки или при возникновении ошибки. По умолчанию используется `DefaultPlaceholder()`.

## Возможности

- Асинхронная загрузка изображений с использованием Swift Concurrency.
- Двухуровневое кэширование (память + диск).
- Автоматический поиск изображения по цепочке: память → диск → сеть.
- Автоматическое сохранение загруженных изображений в оба уровня кэша.
- Полностью настраиваемое отображение изображения.
- Поддержка собственного или встроенного placeholder.
- Доступ как к `Image`, так и к исходным данным изображения (`Data`).
- Легковесная библиотека без сторонних зависимостей.
- API, полностью соответствующий подходам SwiftUI.
- Расширяемая архитектура на основе протоколов.
