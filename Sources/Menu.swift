
import CWin32

public class Menu {

    let handle: HMENU
    var attached = false

    var children: [Menu] = []

    public init() {
        handle = CreateMenu()
    }

    deinit {
        // If the menu is attached to a window, it'll be destroyed along with it.
        if !attached {
            DestroyMenu(handle) // Also destroys children
        }
    }
}

public extension Menu {
    public struct CFlag: OptionSet {

        public var rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        /// Uses a bitmap as the menu item. The lpNewItem parameter contains a handle to the bitmap.
        public static let bitmap = CFlag(rawValue: 0x00000004)
        /// Places a check mark next to the menu item.
        ///
        /// If the application provides check-mark bitmaps (see SetMenuItemBitmaps,
        /// this flag displays the check-mark bitmap next to the menu item.
        public static let checked = CFlag(rawValue: 0x00000008)
        /// Disables the menu item so that it cannot be selected, but the flag does not gray it.
        public static let disabled = CFlag(rawValue: 0x00000002)
        /// Enables the menu item so that it can be selected, and restores it from its grayed state.
        public static let enabled = CFlag(rawValue: 0x00000000)
        /// Disables the menu item and grays it so that it cannot be selected.
        public static let grayed = CFlag(rawValue: 0x00000001)
        /// Places the item on a new line (for a menu bar) or in a new column (for a drop-down menu, submenu, or shortcut menu) without separating columns.
        public static let menuBreak = CFlag(rawValue: 0x00000040)
        /// Functions the same as the MF_MENUBREAK flag for a menu bar. For a drop-down menu, submenu, or shortcut menu, the new column is separated from the old column by a vertical line.
        public static let menuBarBreak = CFlag(rawValue: 0x00000020)
        /// Specifies that the item is an owner-drawn item. Before the menu is displayed for the first time, the window that owns the menu receives a WM_MEASUREITEM message to retrieve the width and height of the menu item. The WM_DRAWITEM message is then sent to the window procedure of the owner window whenever the appearance of the menu item must be updated.
        public static let ownerDrawn = CFlag(rawValue: 0x00000100)
        /// Specifies that the menu item opens a drop-down menu or submenu. The uIDNewItem parameter specifies a handle to the drop-down menu or submenu. This flag is used to add a menu name to a menu bar, or a menu item that opens a submenu to a drop-down menu, submenu, or shortcut menu.
        public static let popup = CFlag(rawValue: 0x00000010)
        ///Draws a horizontal dividing line. This flag is used only in a drop-down menu, submenu, or shortcut menu. The line cannot be grayed, disabled, or highlighted. The lpNewItem and uIDNewItem parameters are ignored.
        public static let separator = CFlag(rawValue: 0x00000800)
        /// Specifies that the menu item is a text string; the lpNewItem parameter is a pointer to the string.
        public static let string = CFlag(rawValue: 0x00000000)
        /// Does not place a check mark next to the item (default). If the application supplies check-mark bitmaps (see SetMenuItemBitmaps), this flag displays the clear bitmap next to the menu item.
        public static let unchecked = CFlag(rawValue: 0x00000000)
    }
}
