import CWin32

public class MessageBox {
    public var title: String
    public var message: String
    public var options: Options
    /// owner window
    public var window: Window?

    public init(message: String, title: String = "Error", options: MessageBox.Options = .ok, owner: Window? = nil) {
        self.message = message
        self.title = title
        self.options = options
        window = owner
    }

    public func display() {
        var ownerHandle: HWND? = nil
        if let window = window {
            ownerHandle = window.handle
        }
        ///TODO: get return value and pass it to a delegate
        MessageBoxW(ownerHandle, message.utf16Pointer, title.utf16Pointer, options.rawValue)
    }
}

extension MessageBox {
    public struct Options: OptionSet {
        public var rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        //MARK: Buttons

        /// The message box contains one push button: OK. This is the default.
        public static let ok = Options(rawValue: 0)
        /// The message box contains two push buttons: OK and Cancel.
        public static let okCancel = Options(rawValue: 0x00000001)
        /// The message box contains three push buttons: Abort, Retry, and Ignore.
        public static let abortRetryIgnore = Options(rawValue: 0x00000002)
        /// The message box contains three push buttons: Yes, No, and Cancel.
        public static let yesNoCancel = Options(rawValue: 0x00000003)
        /// The message box contains two push buttons: Yes and No.
        public static let yesNo = Options(rawValue: 0x00000004)
        /// The message box contains two push buttons: Retry and Cancel.
        public static let retryCancel = Options(rawValue: 0x00000005)
        /// The message box contains three push buttons: Cancel, Try Again, Continue.
        public static let cancelTryContinue = Options(rawValue: 0x00000006)
        /// Adds a Help button to the message box.
        ///
        /// When the user clicks the Help button or presses F1,
        /// the system sends a WM_HELP message to the owner.
        public static let help = Options(rawValue: 0x00004000)

        // MARK: Icons

        /// An exclamation-point icon appears in the message box.
        public static let iconExclamation = Options(rawValue: 0x00000030)
        /// An icon consisting of a lowercase letter i in a circle appears in the message box.
        public static let iconInformation = Options(rawValue: 0x00000040)
        /// A stop-sign icon appears in the message box.
        public static let iconStop = Options(rawValue: 0x00000010)

        // MARK: Default button

        public static let defButton1 = Options(rawValue: 0)
        public static let defButton2 = Options(rawValue: 0x00000100)
        public static let defButton3 = Options(rawValue: 0x00000200)
        public static let defButton4 = Options(rawValue: 0x00000300)

        // MARK: Modality

        // MARK: Other

    }
}

extension MessageBox {
    /// Mapped to `MessageBoxW` return values
    public enum SelectedButton: Int32 {
        case abort = 3,
        cancel = 2,
        `continue` = 11,
        ignore = 5,
        no = 7,
        ok = 1,
        retry = 4,
        tryAgain = 10,
        yes = 6
    }
}
