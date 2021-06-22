# SwiftUI-Particles
Playing with particles with SwiftUI ✨


## Screenshot/Preview

<img src="screenshot01.gif" width="240px" /> <img src="screenshot02.gif" width="240px" /> <img src="screenshot03.gif" width="240px" />

## Installation via Swift Package Manager
1. In your Xcode project, navigate to File → Swift Packages → Add Package Dependency...
2. Copy and paste `https://github.com/ArthurGuibert/SwiftUI-Particles` into the search bar and click Next.
3. For Rules, select "Branch" and set it to **master**.
4. Click Finish.

## How to use

Just use  the `ParticlesEmitter` class in your project as follow:

```swift
struct ContentView: View {
    var body: some View {
        ParticlesEmitter {
            EmitterCell()
                .content(.circle(1.0))
                .color(.white)
                .lifetime(20)
                .birthRate(5)
                .velocity(100)
                .scaleSpeed(-0.2)
                .yAcceleration(100)
        }
        .emitterSize(.init(width: 64, height: 8))
        .emitterShape(.rectangle)
    }
}
```

You can check out the example class in the project `ContentView.swift` for some emitter samples.

## References
Useful resources that I used for this small project:
* [CAEmitterLayer official documentation](https://developer.apple.com/documentation/quartzcore/caemitterlayer)
* [NSHipster's CAEmitterLayer Article](https://nshipster.com/caemitterlayer/)
