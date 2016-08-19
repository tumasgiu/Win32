import CWin32

public class Application {

    public private(set) static var shared: Application!

    public static weak var delegate: ApplicationDelegate?

    public static func entryPoint(hInstance: HINSTANCE, lpCmdLine: LPSTR, nCmdShow: Int) {
        shared = Application()
    }

    public static func run() -> Int {
        guard let delegate = delegate else { fatalError("You must call entryPoint() and assign a delegate first.") }
        return delegate.main()
    }

    let hInstance: HINSTANCE
    let arguments: String
    let nCmdShow: Int

    init(hInstance: HINSTANCE, lpCmdLine: LPSTR, nCmdShow: Int) {
        self.hInstance = hInstance
        arguments = lpCmdLine
        self.nCmdShow = nCmdShow
    }
}

public protocol ApplicationDelegate: class {
    //func mainWindow() -> Window
    func main() -> Int
}
