import CWin32

public class MessageBox {
    
    public struct Options: OptionSet {
        var rawValue: UInt32

        public static let ok = Options(rawValue: 0)
        public static let abortRetryIgnore = Options(rawValue: 0x2)
        public static let iconExclamation = Options(rawValue: 0x30)
        public static let cancelTryContinue = Options(rawValue: 0x6)
        public static let help = Options(rawValue: 0x4000)
    }
    
    public var title: String
    public var message: String
    public var options: Options
    /// owner window
    //public var window: Window?
    
    public init(message: String, title: String = "Error", options: MessageBox.Options = .ok, owner: Window? = nil) {
        self.message = message
        self.title = title
        self.options = options
        window = owner
    }
    
    func display() {
        var ownerHandle: HWND = nil
        // if let window = window {
        //     ownerHandle = window.handle
        // }
        ///TODO: get return value and pass it to a delegate
        MessageBoxA(ownerHandle, message, title, options.rawValue)
    }
}