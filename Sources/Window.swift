import CWin32

public class Window {

    public enum Errors: Error {
        case failedToCreate
    }

    public let windowClass: WindowClass
    public var title: String {
        didSet {
            title.withUTF16CString {
                SetWindowTextW(handle, $0)
            }
        }
    }

    public let titleWChar: UnsafeMutablePointer<UInt16>

    let handle: HWND

    public init(class windowClass: WindowClass, title: String = "Title") throws {

      self.windowClass = windowClass
      self.title = title
      titleWChar = title.utf16MPointer

      let style: Style = [.overlappedWindow]

      let maybeHandle = CreateWindowExW(0, windowClass.identifierWChar, titleWChar, style.rawValue, 0, 0, 500, 400, nil, nil, Application.shared.hInstance, nil)
      let errorCode = GetLastError()
      let maybeError = SystemError(rawValue: errorCode)

      if let error = maybeError {
          throw error
      }

      guard let actualHandle = maybeHandle else {
          throw Errors.failedToCreate
      }

      handle = actualHandle
    }

    public func display() {
        ShowWindow(handle, 10)
        UpdateWindow(handle)
    }

    deinit {
        let len = title.utf16.count + 1
        titleWChar.deinitialize(count: len)
        titleWChar.deallocate(capacity: len)
    }
}

// MARK: Window Styles

extension Window {
    public struct Style: OptionSet {
        public var rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        public static let overlapped = Style(rawValue: 0x00000000)
        public static let popup = Style(rawValue: 0x80000000)
        public static let child = Style(rawValue: 0x40000000)
        public static let minimize = Style(rawValue: 0x20000000)
        public static let visible = Style(rawValue: 0x10000000)
        public static let disabled = Style(rawValue: 0x08000000)
        public static let clipSiblings = Style(rawValue: 0x04000000)
        public static let clipChildren = Style(rawValue: 0x02000000)
        public static let maximize = 	Style(rawValue: 0x01000000)
        public static let caption = Style(rawValue: 0x00C00000) /* [.border, .dlgFrame] */
        public static let border = Style(rawValue: 0x00800000)
        public static let dlgFrame = Style(rawValue: 0x00400000)
        public static let verticalScroll = Style(rawValue: 0x00200000)
        public static let horizontalScroll = Style(rawValue: 0x00100000)
        public static let systemMenu = Style(rawValue: 0x00080000)
        public static let thickFrame = Style(rawValue: 0x00040000)
        public static let group = Style(rawValue: 0x00020000)
        public static let tabStop = Style(rawValue: 0x00010000)
        public static let minimizeBox = Style(rawValue: 0x00020000)
        public static let maximizeBox = Style(rawValue: 0x00010000)

        public static var overlappedWindow: Style {
            return [overlapped, caption, systemMenu, thickFrame, minimizeBox, maximizeBox]
        }

        public static var tiled: Style {
            return overlapped
        }

        public static var iconic: Style {
            return .minimize
        }

        public static var sizeBox: Style {
            return .thickFrame
        }

        public static var titledWindow: Style {
            return .overlappedWindow
        }

        public static var popupWindow: Style {
            return [popup, border, systemMenu]
        }

        public static var childWindow: Style {
            return child
        }

        // * Extended Window Styles
        // */
        //#define WS_EX_DLGMODALFRAME     0x00000001L
        //#define WS_EX_NOPARENTNOTIFY    0x00000004L
        //#define WS_EX_TOPMOST           0x00000008L
        //#define WS_EX_ACCEPTFILES       0x00000010L
        //#define WS_EX_TRANSPARENT       0x00000020L
        //#if(WINVER >= 0x0400)
        //    #define WS_EX_MDICHILD          0x00000040L
        //    #define WS_EX_TOOLWINDOW        0x00000080L
        //    #define WS_EX_WINDOWEDGE        0x00000100L
        //    #define WS_EX_CLIENTEDGE        0x00000200L
        //    #define WS_EX_CONTEXTHELP       0x00000400L
        //
        //#endif /* WINVER >= 0x0400 */
        //#if(WINVER >= 0x0400)
        //
        //    #define WS_EX_RIGHT             0x00001000L
        //    #define WS_EX_LEFT              0x00000000L
        //    #define WS_EX_RTLREADING        0x00002000L
        //    #define WS_EX_LTRREADING        0x00000000L
        //    #define WS_EX_LEFTSCROLLBAR     0x00004000L
        //    #define WS_EX_RIGHTSCROLLBAR    0x00000000L
        //
        //    #define WS_EX_CONTROLPARENT     0x00010000L
        //    #define WS_EX_STATICEDGE        0x00020000L
        //    #define WS_EX_APPWINDOW         0x00040000L
        //
        //
        //    #define WS_EX_OVERLAPPEDWINDOW  (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
        //    #define WS_EX_PALETTEWINDOW     (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)
        //
        //#endif /* WINVER >= 0x0400 */
        //
        //#if(_WIN32_WINNT >= 0x0500)
        //    #define WS_EX_LAYERED           0x00080000
        //
        //#endif /* _WIN32_WINNT >= 0x0500 */
        //
        //
        //#if(WINVER >= 0x0500)
        //    #define WS_EX_NOINHERITLAYOUT   0x00100000L // Disable inheritence of mirroring by children
        //#endif /* WINVER >= 0x0500 */
        //
        //#if(WINVER >= 0x0602)
        //    #define WS_EX_NOREDIRECTIONBITMAP 0x00200000L
        //#endif /* WINVER >= 0x0602 */
        //
        //#if(WINVER >= 0x0500)
        //    #define WS_EX_LAYOUTRTL         0x00400000L // Right to left mirroring
        //#endif /* WINVER >= 0x0500 */
        //
        //#if(_WIN32_WINNT >= 0x0501)
        //    #define WS_EX_COMPOSITED        0x02000000L
        //#endif /* _WIN32_WINNT >= 0x0501 */
        //#if(_WIN32_WINNT >= 0x0500)
        //    #define WS_EX_NOACTIVATE        0x08000000L
        //#endif /* _WIN32_WINNT >= 0x0500 */
    }
}
