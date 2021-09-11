# console_window_control

import ctypes



# Valores del segundo argumento de ShowWindow:
# https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow

def showConsoleWindow():
    """Brings up the Console Window."""
    # Show console
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 4)
    
def hideConsoleWindow():
    """Hides the Console Window."""
    # Hide console
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)
