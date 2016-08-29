import CWin32

public typealias WindowProcedure = @convention(c) (( HWND? /* UnsafeMutablePointer<HWND__>? */, UInt32, UInt64, Int64)) -> Int64

public class WindowClass {

    public enum Errors: Error {
        case registrationFailed
    }

    public let identifier: String

    public let identifierWChar: UnsafeMutablePointer<UInt16>

    private(set) var atom: UInt16? = nil

    let brushPtr = UnsafeMutablePointer<HBRUSH__>.allocate(capacity: 1)

    public init(identifier: String, hInstance: HINSTANCE = Application.shared.hInstance, windowProcedure: WindowProcedure) throws {
        self.identifier = identifier

        identifierWChar = identifier.utf16MPointer

        var wc = WNDCLASSEXW()

        wc.cbSize = UInt32(MemoryLayout<WNDCLASSEX>.size)

        let style: Style = [.vRedraw, .hRedraw]

        wc.style = style.rawValue
        wc.lpfnWndProc = windowProcedure
        wc.cbClsExtra = 0
        wc.cbWndExtra = 0
        wc.hInstance = hInstance

        wc.hIcon = nil//LoadIconA(nil, makeIntRessource(32512))
        wc.hCursor = LoadCursorW(nil, makeIntRessource(32513))

        wc.hbrBackground = SystemBrush.window.handle

        wc.lpszMenuName = nil

        wc.lpszClassName = UnsafePointer(identifierWChar)

        wc.hIconSm = nil //LoadIconA(nil, makeIntRessource(32512))

        atom = RegisterClassExW(&wc)
        let errorCode = GetLastError()
        let maybeError = SystemError(rawValue: errorCode)

        if let error = maybeError {
            throw error
        }

        if let errorAtom = atom, errorAtom == 0 {
            throw Errors.registrationFailed
        }
    }

    deinit {
        UnregisterClassW(identifierWChar, Application.shared.hInstance)
        let len = identifier.utf16.count + 1
        identifierWChar.deinitialize(count: len)
        identifierWChar.deallocate(capacity: len)
    }
}

//MARK: Window Class Styles
extension WindowClass {
    /// [MSDN](https://msdn.microsoft.com/en-us/library/ff729176(v=vs.85).aspx)
    public struct Style: OptionSet {
      public var rawValue: UInt32

      public init(rawValue: UInt32) {
          self.rawValue = rawValue
      }

      public static let byteAlignClient = Style(rawValue: 0x1000)
      public static let byteAlignWindow = Style(rawValue: 0x2000)
      public static let classDC = Style(rawValue: 0x0040)
      public static let doubleClicks = Style(rawValue: 0x0008)
      public static let dropShadow = Style(rawValue: 0x00020000)
      public static let globalClass = Style(rawValue: 0x4000)
      public static let hRedraw = Style(rawValue: 0x0002)
      public static let noClose = Style(rawValue: 0x0200)
      public static let ownDC = Style(rawValue: 0x0020)
      public static let parentDC = Style(rawValue: 0x0080)
      public static let saveBits = Style(rawValue: 0x0800)
      public static let vRedraw = Style(rawValue: 0x0001)
    }
}
