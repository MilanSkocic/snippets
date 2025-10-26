r"""Animate frame with place method."""
import tkinter as tk
from tkinter import ttk


class SlideFrame(ttk.Frame):
    def __init__(self, master, width, right, visible, **kwargs):
        super().__init__(master, **kwargs)
        self.master = master

        self.x0 = 0.0 
        if right:
            self.x0 += 1.0
        
        self.width = width
        self.step = 0.02
        self.right = right
        self.x1 = self.x0 - self.width
        
        self.x_lopen = self.x0
        self.x_ropen = self.x1
        self.x_lclose = self.x1
        self.x_rclose = self.x0
        
        if visible:
            self._is_open = True
            self.x = self.x_lopen
            if right:
                self.x = self.x_ropen
        else:
            self._is_open = False
            self.x = self.x_lclose
            if right:
                self.x = self.x_rclose

        self.place(relx=self.x, rely=0.0, relwidth=self.width, relheight=1)
       
    def animate(self):
        if self._is_open:
            self.slideClose()
        else:
            self.slideOpen()

    def slideOpen(self):
        if self.right:
            diff = self.x1 - self.x
            step = -self.step
        else:
            diff = self.x - self.x0
            step = self.step

        if diff < 0.0:
            self.x += step
            self.place(relx=self.x, rely=0.0, relwidth=self.width, relheight=1)
            self.after(10, self.slideOpen)
            
        self._is_open=True

    def slideClose(self):
        if self.right:
            diff = self.x0 - self.x
            step = self.step
        else:
            diff = self.x - self.x1
            step = -self.step
        if diff > 0.0:
            self.x += step
            self.place(relx=self.x, rely=0.0, relwidth=self.width, relheight=1)
            self.after(10, self.slideClose)

            self._is_open = False

class MainWindow(ttk.Frame):
    def __init__(self, master, **kwargs):
        
        super().__init__(master, **kwargs)
        self.master = master
        self.root = master
        self.pack(side=tk.TOP, expand=tk.TRUE, fill=tk.BOTH)

        self.master.geometry(f"{400}x{300}")

        s = ttk.Style()
        s.configure("SlideFrame.TFrame", background="red")

        self._button_xpos = 10
        self.button = ttk.Button(self, text="OK", command=self._animate)
        self.button.place(relx=0.5, y=100)

        self._frame = SlideFrame(self, 0.3, right=False, visible=False, style="SlideFrame.TFrame")
        ttk.Label(self._frame, text="LABEL").pack()
        
        self._frame2 = SlideFrame(self, width=0.3, right=True, visible=False, style="SlideFrame.TFrame")
        ttk.Label(self._frame2, text="LABEL").pack()


    def _animate(self):
        
        self._frame.animate()
        self._frame2.animate()

    def run(self):

        self.root.mainloop()


if __name__ == "__main__":

    root = tk.Tk()
    app = MainWindow(root)
    app.run()
