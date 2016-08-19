import CWin32

public class Application {

    public private(set) static var shared: Application!

    public static weak var delegate: ApplicationDelegate?

    public static func run(hInstance: HINSTANCE, lpCmdLine: LPSTR, nCmdShow: Int) -> Int {
        shared = Application(hInstance: hInstance, lpCmdLine: lpCmdLine, nCmdShow: nCmdShow)
        guard let delegate = delegate else { fatalError("You must assign a delegate first.") }
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
