import CWin32

//public typealias WindowProcedure = @convention(c) (HWND, UInt, WPARAM, LPARAM) -> LRESULT

class WindowClass {

    enum Errors: Error {
        case registrationFailed
    }

    private var wc = WNDCLASSEX()

    private let bgbPtr = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
    private let bgbOPtr: OpaquePointer

    public init(identifier: String, hInstance: HINSTANCE = Application.shared.hInstance) throws { //, windowProcedure: WNDPROC) throws {

        wc.cbSize = UInt32(MemoryLayout<WNDCLASSEX>.stride)
        wc.style = 0
        //wc.lpfnWndProc = windowProcedure
        wc.cbClsExtra = 0
        wc.cbWndExtra = 0
        wc.hInstance = hInstance
        //wc.hIcon = LoadIcon(nil, IDI_APPLICATION);
        ////wc.hCursor = LoadCursor(nil, IDC_ARROW);
        let bgb = COLOR_WINDOW + Int32(1)
        bgbPtr.initialize(to: bgb)
        bgbOPtr = OpaquePointer(bgbPtr)

        let hb = HBRUSH(bgbOPtr)

        wc.hbrBackground = hb
        wc.lpszMenuName = nil;

        //let len = indentifier.utf8.count
        //let identifierPtr = UnsafePointer<Int8>.allocate(capacity: len)
        //identifier.pointee = identifier

        identifier.withCString {
            wc.lpszClassName = $0
        }

        //wc.lpszClassName = identifierPtr
        //wc.hIconSm = LoadIcon(nil, IDI_APPLICATION);

        //let r = RegisterClassExW(&wc)

        if RegisterClassExW(&wc) != 0 {
            throw Errors.registrationFailed
        }
    }

    deinit {
        bgbPtr.deinitialize()
        bgbPtr.deallocate(capacity: 1)
    }
}

// class Window {
//     let handle: HWND
// }

// Brushes
// COLOR_ACTIVEBORDER
// COLOR_ACTIVECAPTION
// COLOR_APPWORKSPACE
// COLOR_BACKGROUND
// COLOR_BTNFACE
// COLOR_BTNSHADOW
// COLOR_BTNTEXT
// COLOR_CAPTIONTEXT
// COLOR_GRAYTEXT
// COLOR_HIGHLIGHT
// COLOR_HIGHLIGHTTEXT
// COLOR_INACTIVEBORDER
// COLOR_INACTIVECAPTION
// COLOR_MENU
// COLOR_MENUTEXT
// COLOR_SCROLLBAR
// COLOR_WINDOW
// COLOR_WINDOWFRAME
// COLOR_WINDOWTEXT
