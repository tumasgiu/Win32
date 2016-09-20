
public enum SystemMessage {
    public enum Window: UInt32 {
        case null = 0x0000
        case create = 0x0001
        case destroy = 0x0002
        case move = 0x0003
        case size = 0x0005
        case activate = 0x0006
        case setFocus = 0x0007
        case killFocus = 0x0008
        case enable = 0x000A
        case setRedraw = 0x000B
        case setText = 0x000C
        case getText = 0x000D
        case getTextLength = 0x000E
        case paint = 0x000F
        case close = 0x0010
        case queryEndSession = 0x0011
        case queryOpen = 0x0013
        case endSession = 0x0016
        case quit = 0x0012
        case eraseBackground = 0x0014
        case systemColorChange = 0x0015
        case showWindow = 0x0018
        case settingChange = 0x001A
        case devModeChange = 0x001B
        case activateApp = 0x001C
        case fontChange = 0x001D
        case timeChange = 0x001E
        case cancelMode = 0x001F
        case setCursor = 0x0020
        case mouseActivate = 0x0021
        case childActivate = 0x0022
        case queueSync = 0x0023
        case getMinMaxInfo = 0x0024

        case paintIcon = 0x0026
        case iconEraseBackground = 0x0027
        case nextDLGCTL = 0x0028
        case spoolerStatus = 0x002A
        case drawItem = 0x002B
        case measureItem = 0x002C
        case deleteItem = 0x002D
        case vKeyToItem = 0x002E
        case charToItem = 0x002F
        case setFont = 0x0030
        case getFont = 0x0031
        case setHotKey = 0x0032
        case getHotKey = 0x0033
        case queryDragIcon = 0x0037
        case compareItem = 0x0039

        case getObject = 0x003D

        case compacting = 0x0041
        case commNotify = 0x0044  /* no longer suported */

        case windowPositionChanging = 0x0046
        case windowPositionChanged = 0x0047
        case getIcon = 0x007F
        case nonClientCreate = 0x0081
        case nonClientDestroy = 0x0082
        case nonClientCalculateSize = 0x0083
        case nonClientHitTest = 0x0084
        case nonClientActivate = 0x0086
        case nonClientMouseMove = 0x00A0
        case nonClientButtonDown = 0x00A1
        case initDialog = 0x0110
        case command = 0x0111
        case systemCommand = 0x0112
        case mouseMove = 0x0200
        case captureChanged = 0x0215
        case imeSetContext = 0x0281
        case imeNotify = 0x0282
        case dwmNonClientRenderingChanged = 0x031F
    }
}
