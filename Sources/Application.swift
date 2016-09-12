import CWin32

public class Application {

    public private(set) static var shared: Application!

    public static weak var delegate: ApplicationDelegate?

    public static func run() -> Int {

        guard let hInst = GetModuleHandleW(nil) else {
            let errorCode = GetLastError()
            fatalError("Could not get handle : \(errorCode)")
        }
        // TODO: replace this dummy with CommandLine
        let dummy: UnsafeMutablePointer<CHAR>? = UnsafeMutablePointer.allocate(capacity: 1)

        shared = Application(hInstance: hInst, lpCmdLine: dummy!, nCmdShow: 10)

        guard let delegate = delegate else { fatalError("You must assign a delegate first.") }

        delegate.main()

        func getMessage(_ ptr: UnsafeMutablePointer<MSG>) -> Bool {
            let retVal = GetMessageW(ptr, nil, 0, 0)
            if retVal <= 0 {
                return false
            }
            return true
        }

        var msg = MSG()

        while getMessage(&msg) {
            DispatchMessageW(&msg)
        }

        return Int(msg.wParam)
    }

    public let hInstance: HINSTANCE
    public let arguments: UnsafeMutablePointer<Int8>
    let nCmdShow: Int

    init(hInstance: HINSTANCE, lpCmdLine: LPSTR, nCmdShow: Int) {
        self.hInstance = hInstance
        arguments = lpCmdLine
        self.nCmdShow = nCmdShow
    }
}

public protocol ApplicationDelegate: class {
    //func mainWindow() -> Window
    func main()
}
