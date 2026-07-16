# AsyncCacheImage

A Swift Package for loading and caching images.

## Architecture
<img width="1022" height="728" alt="Group 2" src="https://github.com/user-attachments/assets/41327278-20f0-45d7-a99c-5da750abdff6" />

## Requirements

- iOS 17.0+
- Swift 6.2+

## Installation

Add the package using Swift Package Manager:

```swift
.package(
    url: "https://github.com/UlianaGritchina/AsyncCacheImage.git",
    from: "1.0.1"
)
```

## Usage

```swift
import AsyncCacheImage
import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!

    var body: some View {
        AsyncCacheImage(url: url) { image in
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

### Default placeholder

```swift
AsyncCacheImage(url: url) { image in
    image
        .resizable()
        .frame(width: 200, height: 200)
        .cornerRadius(10)
}
```

### Initializer

Creates an `AsyncCacheImage` that asynchronously loads and caches an image from the specified URL.

#### Parameters

- `url` — The URL of the image to load.
- `content` — A view builder that receives the loaded `Image`.
- `placeholder` — A view builder displayed while the image is loading or if loading fails. Defaults to `DefaultPlaceholder()`.

## DefaultAsyncCacheImage
```
import AsyncCacheImage
import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!
    
    var body: some View {
        DefaultAsyncCacheImage(url: url)
    }
}

#Preview {
    ContentView()
}
```

## Features

- Async image loading
- In-memory image caching
- SwiftUI-native API
- Custom or default placeholder
- Built with Swift Concurrency
