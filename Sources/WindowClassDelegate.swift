
public enum MouseButton {
    case `left`
    case `right`
    case middle
}

public enum MouseEvent {
    case buttonUp(MouseButton)
    case buttonDown(MouseButton)
    case doubleClick(MouseButton)
    case move
}

public protocol WindowClassDelegate: class {
    func onPaint(window: Window)
    func onCommand(param: UInt64)
    func onDestroy(window: Window) -> Bool
    func onMouseEvent(_ event: MouseEvent, at point: Point, in window: Window)
}

// Empty default implementations = protocol optional methods
public extension WindowClassDelegate {
    func onPaint(window: Window) {}
    func onCommand(param: UInt64) {}
    func onDestroy(window: Window) -> Bool { return true }
    func onMouseEvent(_ event: MouseEvent, at point: Point, in window: Window) {}
}
