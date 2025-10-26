r"""Example with mutliple windows."""

import tkinter as tk
from tkinter import ttk

class MainWindow(ttk.Frame):

    def __init__(self, master):

        ttk.Frame.__init__(self, master)
        self.master = master
        self.pack(expand=tk.YES, fill=tk.BOTH)
        self.master.title('Data Digitizer')
        self.master.protocol("WM_DELETE_WINDOW", self.quit)

        # get screen width and height
        ws = self.master.winfo_screenwidth()
        hs = self.master.winfo_screenheight()
        # master.geometry(("%dx%d")%(ws,hs))
        width = int(0.75 * ws)
        height = int(0.75 * hs)
        x = int((ws / 2) - (width / 2))
        y = int((hs / 2) - (height / 2) - 25)
        self.master.geometry(f'{width}x{height}+{x}+{y}')

        self._bt = ttk.Button(self, text="Open Windows", command=self._open_wn)
        self._bt.grid(row=0, column=1, sticky="nswe")

    def _open_wn(self):
        NewWindow(self)

    def run(self):
        self.master.mainloop()

    def quit(self):
        self.master.quit()
        self.master.destroy()

class NewWindow(tk.Toplevel):

    def __init__(self, master):
        
        super().__init__(master)

        # if set window stays above main.
        #self.transient(master)

        self.master = master
        self.title('Data Table')

        # if set cannot interact with main window
        #self.grab_set()

        self.initial_focus = self

        self.protocol("WM_DELETE_WINDOW", self._quit)

        ws = self.master.winfo_screenwidth()
        hs = self.master.winfo_screenheight()
        width = int(0.5*ws)
        height = int(0.7*hs)
        x = int((ws / 2) - (width / 2))
        y = int((hs / 2) - (height / 2) - 25)
        self.geometry(f'{width}x{height}+{x}+{y}')

    def _quit(self):
        self.master.focus_set()
        self.destroy()


if __name__ == "__main__":
    root = tk.Tk()
    app = MainWindow(root)
    app.run()