
public enum Errors: Error {
    case unknownError(code: UInt32)
}

public enum SystemError: UInt32, Error {
    case invalidParameter = 87
    case cannotFindWindowClass = 1407
}
