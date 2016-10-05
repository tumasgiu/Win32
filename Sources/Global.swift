
import CWin32

class Weak<T: AnyObject> {
    weak var value: T?
    init(_ value: T) {
        self.value = value
    }
}

var windowRegistry: [UInt32 : Weak<Window>] = [:]

func findWindowForHandle(_ handle: HWND) -> Window? {
    guard let weakBox = windowRegistry[unsafeBitCast(handle.pointee, to: UInt32.self)],
          let window = weakBox.value
    else {
        return nil
    }

    return window
}

/// Equivalent to CW_USEDEFAULT
var useDefault: Int32 {
    let base = UInt32(0x80000000)
    return unsafeBitCast(base, to: Int32.self)
}

func lowWord<T>(of param: T) -> UInt16 {
    var param = param
    var result: UInt16 = 0
    withUnsafePointer(to: &param) {
        $0.withMemoryRebound(to: UInt16.self, capacity: 2) {
            result = $0.pointee
        }
    }
    return result
}

func highWord<T>(of param: T) -> UInt16 {
    var param = param
    var result: UInt16 = 0
    withUnsafePointer(to: &param) {
        $0.withMemoryRebound(to: UInt16.self, capacity: 2) {
            result = $0.advanced(by: 1).pointee
        }
    }
    return result
}
