import CWin32

public typealias WindowProcedure = @convention(c) (( HWND?, UInt32, UInt64, Int64)) -> Int64

public protocol WindowClassDelegate: class {
    func onPaint(window: Window)
    func onCommand(param: UInt64)
    func onDestroy(window: Window) -> Bool
}

/// Unregisters at deinit.
public class WindowClass {

    public let identifier: String
    public private(set) var isRegistered = false

    public var backgroundBrush: Brush = SystemBrush.window {
        willSet {
            assertNotRegistered()
        }
        didSet {
            wc.hbrBackground = backgroundBrush.handle
        }
    }

    public var styleOptions: StyleOptions = [.vRedraw, .hRedraw] {
        willSet {
            assertNotRegistered()
        }
        didSet {
            wc.style = styleOptions.rawValue
        }
    }

    public weak var delegate: WindowClassDelegate?

    let identifierWChar: UnsafeMutablePointer<UInt16>
    private(set) var atom: UInt16? = nil
    private var wc = WNDCLASSEXW()

    public init(identifier: String) {
        precondition(identifier.utf16.count < 256,
            "The Window Class identifier cannot be longer than 256 characters")

        self.identifier = identifier

        identifierWChar = identifier.utf16MPointer
        wc.cbSize = UInt32(MemoryLayout<WNDCLASSEX>.size)
        wc.lpszClassName = UnsafePointer(identifierWChar)
        wc.hInstance = Application.shared.hInstance

        wc.style = styleOptions.rawValue
        wc.hbrBackground = backgroundBrush.handle

        wc.lpfnWndProc = { hwnd, messageCode, wParam, lParam in

            guard let message = SystemMessage.Window(rawValue: messageCode)
            else {
                print("received unknown message code : \(messageCode)")
                return DefWindowProcW(hwnd, messageCode, wParam, lParam)
            }

            print("received message : \(message)")

            guard let handle = hwnd,
                  let window = findWindowForHandle(handle),
                  let delegate = window.windowClass.delegate
            else {
                print("could not find window and/or class delegate")
                return DefWindowProcW(hwnd, messageCode, wParam, lParam)
            }

            switch message {
                case .paint:
                    delegate.onPaint(window: window)
                    return 0
                case .command:
                    delegate.onCommand(param: wParam)
                    return 0
                case .destroy:
                    return delegate.onDestroy(window: window) ? 0 : -1
                default:
                    return DefWindowProcW(hwnd, messageCode, wParam, lParam)
            }
        }

        wc.cbClsExtra = 0
        wc.cbWndExtra = 0
        wc.lpszMenuName = nil
        wc.hIconSm = nil //LoadIconA(nil, makeIntRessource(32512))
        wc.hIcon = nil//LoadIconA(nil, makeIntRessource(32512))
        wc.hCursor = LoadCursorW(nil, makeIntRessource(32513))
    }

    public func register() throws {
        atom = RegisterClassExW(&wc)
        let errorCode = GetLastError()
        let maybeError = SystemError(rawValue: errorCode)

        if let error = maybeError {
            throw error
        }

        if let errorAtom = atom, errorAtom == 0 {
            throw Errors.unknownError(code: errorCode)
        }

        isRegistered = true
    }

    public func unregister() {
        if isRegistered {
            UnregisterClassW(identifierWChar, Application.shared.hInstance)
        }
        isRegistered = false
    }

    private func assertNotRegistered() {
        precondition(!isRegistered,
            "You cannot modify the Window Class after it has been registered")
    }

    deinit {
        unregister()
        let len = identifier.utf16.count + 1
        identifierWChar.deinitialize(count: len)
        identifierWChar.deallocate(capacity: len)
    }
}

//MARK: Window Class Styles
extension WindowClass {
    /// [MSDN](https://msdn.microsoft.com/en-us/library/ff729176(v=vs.85).aspx)
    public struct StyleOptions: OptionSet {
      public var rawValue: UInt32

      public init(rawValue: UInt32) {
          self.rawValue = rawValue
      }

      public static let byteAlignClient = StyleOptions(rawValue: 0x1000)
      public static let byteAlignWindow = StyleOptions(rawValue: 0x2000)
      public static let classDC = StyleOptions(rawValue: 0x0040)
      public static let doubleClicks = StyleOptions(rawValue: 0x0008)
      public static let dropShadow = StyleOptions(rawValue: 0x00020000)
      public static let globalClass = StyleOptions(rawValue: 0x4000)
      public static let hRedraw = StyleOptions(rawValue: 0x0002)
      public static let noClose = StyleOptions(rawValue: 0x0200)
      public static let ownDC = StyleOptions(rawValue: 0x0020)
      public static let parentDC = StyleOptions(rawValue: 0x0080)
      public static let saveBits = StyleOptions(rawValue: 0x0800)
      public static let vRedraw = StyleOptions(rawValue: 0x0001)
    }
}
