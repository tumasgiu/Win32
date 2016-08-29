import CWin32

/// https://msdn.microsoft.com/en-us/library/ms724371(v=vs.85).aspx#
enum SystemBrush: Int32 {

    /// Dark shadow for three-dimensional display elements.
    case darkShardow3D = 21

    /// Face color for three-dimensional display elements and for dialog box backgrounds.
    case face3D = 15

    /// Highlight color for three-dimensional display elements (for edges facing the light source.)
    case highlight3D = 20

    /// Light color for three-dimensional display elements (for edges facing the light source.)
    case light3D = 22

    /// Shadow color for three-dimensional display elements (for edges facing away from the light source).
    case shadow3D = 16

    /// Active window border.
    case activeBorder = 10

    /// Active window title bar.
    ///
    /// Specifies the left side color in the color gradient of an active window's title bar if the gradient effect is enabled.
    case activeCaption = 2

    /// Background color of multiple document interface (MDI) applications.
    case appWorkspace = 12

    /// Desktop.
    case background = 1

    /// Face color for three-dimensional display elements and for dialog box backgrounds.
    var buttonFace: SystemBrush {
        return .face3D
    }

    /// Highlight color for three-dimensional display elements (for edges facing the light source.)
    var buttonHighlight: SystemBrush {
        return .highlight3D
    }

    /// Shadow color for three-dimensional display elements (for edges facing away from the light source).
    var buttonShadow: SystemBrush {
        return .shadow3D
    }

    /// Text on push buttons.
    case buttonText = 18

    /// Text in caption, size box, and scroll bar arrow box.
    case captionText = 9

    /// Desktop.
    var desktop: SystemBrush {
        return .background
    }
    ///     Right side color in the color gradient of an active window's title bar. `activeCaption` specifies the left side color. Use SPI_GETGRADIENTCAPTIONS with the SystemParametersInfo function to determine whether the gradient effect is enabled.
    case gradientActiveCaption = 27

    /// Right side color in the color gradient of an inactive window's title bar. `inactiveCaption` specifies the left side color.
    case gradientInactiveCaption = 28

    /// Grayed (disabled) text. This color is set to 0 if the current display driver does not support a solid gray color.
    case grayText = 17

    /// Item(s) selected in a control.
    case highlight = 13

    /// Text of item(s) selected in a control.
    case highlightText = 14

    /// Color for a hyperlink or hot-tracked item.
    case hotLight = 26

    /// Inactive window border.
    case inactiveBorder = 11

    /// Inactive window caption.
    ///
    /// Specifies the left side color in the color gradient of an inactive window's title bar if the gradient effect is enabled.
    case inactiveCaption = 3

    /// Color of text in an inactive caption.
    case inactiveCaptionText = 19

    /// Background color for tooltip controls.
    case infoBackground = 24

    /// Text color for tooltip controls.
    case infoText = 23

    /// Menu background.
    case menu = 4

    /// The color used to highlight menu items when the menu appears as a flat menu (see SystemParametersInfo). The highlighted menu item is outlined with COLOR_HIGHLIGHT.
    /// Windows 2000:  This value is not supported.
    case menuHighlight = 29

    /// The background color for the menu bar when menus appear as flat menus (see SystemParametersInfo). However, COLOR_MENU continues to specify the background color of the menu popup.
    /// Windows 2000:  This value is not supported.
    case menuBar = 30

    /// Text in menus.
    case menuText = 7

    /// Scroll bar gray area.
    case scrollbar = 0

    /// Window background.
    case window = 5

    /// Window frame.
    case windowFrame = 6

    /// Text in windows.
    case windowText = 8

    var handle: HBRUSH {
        return GetSysColorBrush(rawValue)
    }
}
