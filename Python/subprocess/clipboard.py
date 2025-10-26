import subprocess
import platform

if platform.system() == "Windows":
    import win32clipboard


def get_clipboard_data():

    if platform.system() == "Linux":
        p = subprocess.Popen(["xclip", "-selection", "clipboard", "-o"], stdout=subprocess.PIPE)
        retcode = p.wait()
        _data = p.stdout.read()

    elif platform.system() == "Darwin":
        p = subprocess.Popen(["pbpaste"], stdout=subprocess.PIPE)
        retcode = p.wait()
        _data = p.stdout.read()

    elif platform.system() == "Windows":
        win32clipboard.OpenClipboard()
        _data = win32clipboard.GetClipboardData(win32clipboard.CF_TEXT)
        win32clipboard.CloseClipboard()

    data = _data.decode("utf-8")

    return data


def set_clipboard_data(data):
    _data = bytes(data, encoding="utf-8")
    
    if platform.system() == "Linux":
        p = subprocess.Popen(["xclip", "-selection", "clipboard"], stdin=subprocess.PIPE)
        p.stdin.write(_data)
        p.stdin.close()
        retcode = p.wait()
    
    elif platform.system() == "Darwin":
        p = subprocess.Popen(["pbcopy"], stdin=subprocess.PIPE)
        p.stdin.write(_data)
        p.stdin.close()
        retcode = p.wait()
    
    elif platform.system() == "Windows":
        win32clipboard.OpenClipboard()
        win32clipboard.EmptyClipboard()
        win32clipboard.SetClipboardData(win32clipboard.CF_TEXT, _data)
        win32clipboard.CloseClipboard()


if __name__ == "__main__":
    data = get_clipboard_data()
    print(data)
    s = "test cb"
    set_clipboard_data(s)