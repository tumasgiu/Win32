import CWin32

public struct DrawTextOptions: OptionSet {

    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    // DT_TOP
    public static let top = DrawTextOptions(rawValue: 0x00000000)
    // DT_LEFT
    public static let left = DrawTextOptions(rawValue: 0x00000000)
    // DT_CENTER
    public static let center = DrawTextOptions(rawValue: 0x00000001)
    // DT_RIGHT
    public static let right = DrawTextOptions(rawValue: 0x00000002)
    // DT_VCENTER
    public static let centerVertically = DrawTextOptions(rawValue: 0x00000004)
    // DT_BOTTOM
    public static let bottom = DrawTextOptions(rawValue: 0x00000008)
    // DT_WORDBREAK
    public static let wordBreak = DrawTextOptions(rawValue: 0x00000010)
    // DT_SINGLELINE
    public static let singleLine = DrawTextOptions(rawValue: 0x00000020)
    // DT_EXPANDTABS
    public static let expandTabs = DrawTextOptions(rawValue: 0x00000040)
    // DT_TABSTOP
    public static let tabStop = DrawTextOptions(rawValue: 0x00000080)
    // DT_NOCLIP
    public static let noClip = DrawTextOptions(rawValue: 0x00000100)
    // DT_EXTERNALLEADING
    public static let externalLeading = DrawTextOptions(rawValue: 0x00000200)
    // DT_CALCRECT
    public static let calcRect = DrawTextOptions(rawValue: 0x00000400)
    // DT_NOPREFIX
    public static let noPrefix = DrawTextOptions(rawValue: 0x00000800)
    // DT_INTERNAL
    public static let `internal` = DrawTextOptions(rawValue: 0x00001000)

    // #if(WINVER >= 0x0400)
    // #define DT_EDITCONTROL              0x00002000
    // #define DT_PATH_ELLIPSIS            0x00004000
    // #define DT_END_ELLIPSIS             0x00008000
    // #define DT_MODIFYSTRING             0x00010000
    // #define DT_RTLREADING               0x00020000
    // #define DT_WORD_ELLIPSIS            0x00040000
    // #if(WINVER >= 0x0500)
    // #define DT_NOFULLWIDTHCHARBREAK     0x00080000
    // #if(_WIN32_WINNT >= 0x0500)
    // #define DT_HIDEPREFIX               0x00100000
    // #define DT_PREFIXONLY               0x00200000
    // #endif /* _WIN32_WINNT >= 0x0500 */
    // #endif /* WINVER >= 0x0500 */
}

public class DeviceContext {

    public let handle: HDC // FIXME: Sould be hidden when Swift API is complete

    init(handle: HDC) {
        self.handle = handle
    }

    public func drawText(_ text: String, inRect rect: inout RECT, options: DrawTextOptions = DrawTextOptions(rawValue: 0)) {
        let strPtr = text.utf16MPointer
        DrawTextW(handle, strPtr, -1, &rect, options.rawValue)
        let len = text.utf16.count + 1
        strPtr.deinitialize(count: len)
        strPtr.deallocate(capacity: len)
    }

}
