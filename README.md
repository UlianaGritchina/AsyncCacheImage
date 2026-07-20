# AsyncCacheImage

**A Swift Package for asynchronous image loading with memory and disk caching.**
<br>Use `AsyncCacheImage` just like SwiftUI's `AsyncImage`, but with automatic memory and disk caching built in.
[Читать на русском](README.ru.md)
## Architecture

<img width="1536" height="1024" alt="69DC92F2-940B-4DE0-9734-E397D5B8EE7A" src="https://github.com/user-attachments/assets/0ebe6977-ce7a-4733-8445-ca2631224cd7" />

### Loading pipeline

```text
Memory Cache
     │
     ▼ (miss)
Disk Cache
     │
     ▼ (miss)
Network
```

When an image is requested:

1. Memory cache is checked.
2. If not found, disk cache is checked.
3. If still not found, the image is downloaded from the network.
4. The downloaded image is stored in both memory and disk caches.

## Requirements

- iOS 17.0+
- Swift 6.2+

## Installation

Add the package using Swift Package Manager:

```swift
.package(
    url: "https://github.com/UlianaGritchina/AsyncCacheImage.git",
    from: "1.0.3"
)
```

## Usage

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

### Using the default placeholder

```swift
AsyncCacheImage(url: url) { image, data in
    image
        .resizable()
        .frame(width: 200, height: 200)
        .cornerRadius(10)
}
```

## DefaultAsyncCacheImage

A ready-to-use image view with built-in styling and placeholder.

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

## Initializer

Creates an `AsyncCacheImage` that asynchronously loads and caches an image from the specified URL.

### Parameters

- `url` — The URL of the image to load.
- `content` — A view builder that receives the loaded `Image` and the original image `Data`.
- `placeholder` — A view builder displayed while the image is loading or if loading fails. Defaults to `DefaultPlaceholder()`.

## Features

- Asynchronous image loading with Swift Concurrency
- Multi-level caching (memory + disk)
- Automatic cache lookup (memory → disk → network)
- Automatic cache population after download
- Customizable image content
- Custom or built-in placeholder
- Access to both `Image` and original `Data`
- Lightweight and dependency-free
- SwiftUI-native API
- Extensible architecture based on protocols
