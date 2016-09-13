# Win32
An experimental Swift wrapper around Win32 API  

Tested on [Cygwin](https://github.com/tinysun212/swift-windows/releases/tag/swift-cygwin-20160913)

## Usage

Just add to your `Package.swift` file

```
let package = Package(
    name: "W32App",
    dependencies: [
        .Package(url: "https://github.com/tumasgiu/Win32.git", majorVersion: 0, minor: 1)
    ]
 )
```
