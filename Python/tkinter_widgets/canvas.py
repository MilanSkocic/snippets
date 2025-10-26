r"""Canvas"""
import tkinter as tk
from tkinter import ttk


class CircProgress(ttk.Frame):
    def __init__(self, master, **kwargs):

        self.master = master
        super().__init__(**kwargs)


        self.canvas = tk.Canvas(self)
        self.canvas.pack(fill=tk.BOTH, expand=tk.YES)

        self.o = self.canvas.create_arc(30, 30, 50, 50, fill="gray", outline="gray", width=1, start=90, extent=90)

    def update(self,d):
        self.canvas.delete(self.o)
        self.o = self.canvas.create_arc(30, 30, 90, 90, fill="gray", outline="gray", width=1, start=90, extent=90+d)
        self.canvas.update_idletasks()


class MainApp(ttk.Frame):
    def __init__(self, master, **kwargs):
        self.master = master

        super().__init__(**kwargs)

        self._c = CircProgress(self)
        self._c.pack()

        self.master.bind("<Return>", self._cb_update)

        self.k = 0


    def _cb_update(self, event):
        self.k += 1
        self._c.update(self.k)

    def _update(self):
        self._c.update(d)


    def run(self):
        self.master.mainloop()


if __name__ == "__main__":

    root = tk.Tk()
    app = MainApp(root)
    app.run()
