# ScrollingCarousel

A customizable and interactive horizontal carousel for SwiftUI, designed to display a series of views with smooth scrolling, scaling effects, and optional indicators.

## Features
- Supports dynamic scaling of items during scrolling.
- View alignment behavior for smooth transitions.
- Customizable item spacing, scaling, and indicators.
- Uses `scrollPosition` to track the current visible item.
- Indicator bar that scrolls along with content.

## Compatibility
- **iOS 17+**
- **SwiftUI-based**

## Swift Package Manager (SPM)
1. Open your Xcode project.
2. Go to `File > Add Packages`.
3. Enter the repository URL:
   ```
   https://github.com/Iteraciona/ScrollingCarousel.git
   ```
4. Choose the latest version and click **Add Package**.

## Usage

```swift
import SwiftUI
import ScrollingCarousel

struct ContentView: View {
    let items = [
        Color.red.frame(width: 200, height: 300),
        Color.blue.frame(width: 200, height: 300),
        Color.green.frame(width: 200, height: 300)
    ]
    
    var body: some View {
        ScrollingCarousel(content: items) { index in
            print("Current index: \(index)")
        }
    }
}
```

## Parameters
| Parameter         | Type             | Description |
|------------------|----------------|-------------|
| `content`        | `[Content]`     | An array of SwiftUI views to display in the carousel. |
| `gap`            | `CGFloat`       | Space between items. Default: `20`. |
| `normalState`    | `CGFloat`       | Scale factor for the selected item. Default: `1`. |
| `reducedState`   | `CGFloat`       | Scale factor for unselected items. Default: `0.85`. |
| `showIndicators` | `Bool`          | Whether to show the indicator bar. Default: `true`. |
| `indicatorSize`  | `CGFloat`       | Size of indicator dots. Default: `8`. |
| `indicatorColor` | `Color`         | Color of the indicators. Default: `.gray`. |
| `indicatorGap`   | `CGFloat`       | Space between indicators. Default: `4`. |
| `currentIndex`   | `(Int) -> Void` | Closure that receives the current index on scroll. |

## Customization
You can customize the appearance and behavior by adjusting the parameters.

```swift
ScrollingCarousel(
    content: items,
    gap: 15,
    normalState: 1,
    reducedState: 0.8,
    showIndicators: true,
    indicatorSize: 10,
    indicatorColor: .blue,
    indicatorGap: 6
) { index in
    print("Viewing item at index: \(index)")
}
```

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

