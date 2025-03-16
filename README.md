# ScrollingCarousel

A smooth and customizable horizontal carousel for SwiftUI with dynamic scaling effects.

## Features
- Supports dynamic scaling of items during scrolling.
- View alignment behavior for smooth transitions.
- Configurable item spacing and scaling effects.
- Uses `scrollPosition` to track the current visible item.

## Installation

### Swift Package Manager (SPM)
1. Open your Xcode project.
2. Go to `File > Add Packages`.
3. Enter the repository URL:
   ```
   https://github.com/Iteraciona/ScrollingCarousel.git
   ```
4. Choose the latest version and click **Add Package**.

## Usage

```swift
import ScrollingCarousel

struct ContentView: View {
    let items = [
        Color.red.frame(width: 200, height: 300),
        Color.blue.frame(width: 200, height: 300),
        Color.green.frame(width: 200, height: 300)
    ]
    
    var body: some View {
        ScrollingCarousel(content: items, currentIndex: { index in
            print("Current index: \(index)")
        })
    }
}
```

## Parameters
| Parameter       | Type         | Description |
|----------------|-------------|-------------|
| `content`      | `[Content]` | Array of SwiftUI views to display. |
| `gap`          | `CGFloat`   | Spacing between items (default: `20`). |
| `normalState`  | `CGFloat`   | Scale factor for the centered item (default: `1`). |
| `reducedState` | `CGFloat`   | Scale factor for non-centered items (default: `0.85`). |
| `currentIndex` | `(Int) -> Void` | Closure that returns the currently visible index. |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

