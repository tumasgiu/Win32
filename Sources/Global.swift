
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
