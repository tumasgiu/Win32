
//TODO: Check endianness swift != win32
func makeIntRessource(_ value: UInt16) -> UnsafePointer<UInt16> {
    let p = UnsafeMutableRawPointer.allocate(bytes: 4, alignedTo: 1)
    p.storeBytes(of: value, toByteOffset: 2, as: UInt16.self)
    p.storeBytes(of: 0x0000, toByteOffset: 0, as: UInt16.self)
    return UnsafePointer(p.assumingMemoryBound(to: UInt16.self))
}

extension String {
    public var utf16Pointer: UnsafePointer<UInt16> {
        let ptr = UnsafeMutablePointer<UInt16>.allocate(capacity: utf16.count + 1)
        var i = 0
        for c in utf16 {
            ptr.advanced(by: i).initialize(to: c)
            i += 1
        }
        ptr.advanced(by: utf16.count).initialize(to: 0)
        return UnsafePointer(ptr)
    }
}

extension String {
    public var utf16MPointer: UnsafeMutablePointer<UInt16> {
        let ptr = UnsafeMutablePointer<UInt16>.allocate(capacity: utf16.count + 1)
        var i = 0
        for c in utf16 {
            ptr.advanced(by: i).initialize(to: c)
            i += 1
        }
        ptr.advanced(by: utf16.count).initialize(to: 0)
        return ptr
    }
}

extension String {
    public func withUTF16CString(_ body: (UnsafePointer<UInt16>) -> ()) {
        let ptr = utf16MPointer
        body(ptr)
        ptr.deinitialize(count: utf16.count + 1)
        ptr.deallocate(capacity: utf16.count + 1)
    }
}
