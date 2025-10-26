import tkinter as tk
from tkinter import ttk

class App(tk.Frame):
    r"""
    Main app window from which the FigureFrame widget will be used.
    """

    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.master = master
        self.root = master
        self.pack(side=tk.TOP, expand=tk.TRUE, fill=tk.BOTH)

        self.trview = ttk.Treeview(self, columns=("Name", "ID"), show="headings")
        self.trview.pack()

        self.trview.column("Name", width=120)
        self.trview.column("ID", width=120)

        self.trview.heading("Name", text="Name")
        self.trview.heading("ID", text="ID")

        for i in range(10):
            self.trview.insert('', tk.END, values=(f"{str(i):s}", f"{str(i*10):s}"))

        self._popmenu = tk.Menu(self, tearoff=False)
        self._popmenu.add_command(label="Copy", command=self._popup_copy)

        self.master.bind("<Control-d>", self._cb_delete)
        self.master.bind("<Button-2>", self._cb_popup_menu)

    def _cb_popup_menu(self, event):

        try:
            self._popmenu.tk_popup(event.x_root, event.y_root)
        finally:
            self._popmenu.grab_release()

    def _cb_delete(self, event):

        for selected_item in self.trview.selection():
            self.trview.delete(selected_item)

        for i in self.trview.get_children():
            print(self.trview.item(i)["values"])

    def _popup_copy(self):
        item = self.trview.focus()
        values = self.trview.item(item)["values"]
        for i in values:
            print(i, type(i))

    def start(self):
        self.master.mainloop()

    def quit(self):
        self.master.quit()
        self.master.destroy()


if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    app.start()