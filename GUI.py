import tkinter as tk
from tkinter import ttk

LIGHT_PINK = '#F1A2D2'
PINK = '#E467B3'


class MainWindow:
    def __init__(self):
        root = tk.Tk()
        root.title("Car sharing system")
        root.iconbitmap(default="favicon.ico")

        s_width = round(root.winfo_screenwidth()*0.8)  # screen width
        s_height = round(root.winfo_screenheight()*0.8)  # screen width

        root.geometry(str(s_width) + 'x' + str(s_height))

        root.grid_columnconfigure(index=0, weight=1)
        root.grid_rowconfigure(index=0, weight=1)

        self.item = root
        self.s_width = s_width
        self.s_height = s_height


class ScrollBar:
    def __init__(self, panel, canvas):
        scroll = tk.Scrollbar(panel, orient='vertical', command=canvas.yview)
        scroll.pack(side='right', fill='y')
        self.item = scroll

    def update(self, event, canvas):
        canvas.configure(scrollregion=canvas.bbox("all"))

    def on_mousewheel(self, event, canvas):
        canvas.yview_scroll(round(-1 * (event.delta / 70)), "units")

    def bind_tree(self, widget, event, callback):
        widget.bind(event, callback)

        for child in widget.children.values():
            self.bind_tree(child, event, callback)


class SelectsPanel:
    def __init__(self, root, width):
        s_panel = tk.Frame(root)
        s_panel.grid(column=1, row=0, sticky='ns')

        canvas = tk.Canvas(s_panel, bg=LIGHT_PINK, width=round(width/13))
        canvas.pack(side='left', fill='y')

        s_panel_scroll = tk.Frame(canvas, bg=LIGHT_PINK)

        self.fill_buttons(s_panel_scroll)

        scroll = ScrollBar(s_panel, canvas)

        canvas.configure(yscrollcommand=scroll.item.set)
        canvas.create_window(0, 0, window=s_panel_scroll, anchor=tk.CENTER)

        s_panel_scroll.bind("<Configure>", lambda event: scroll.update(event, canvas))
        scroll.bind_tree(canvas, "<MouseWheel>", lambda event: scroll.on_mousewheel(event, canvas))

    def fill_buttons(self, parent):
        for i in range(1, 11):
            select_1 = tk.Button(parent, text='Select ' + str(i), padx=10, pady=10, bg='white', relief=tk.FLAT,
                                 overrelief=tk.GROOVE, highlightthickness=0)
            select_1.grid(column=0, row=i, sticky='we')
            select_1.grid_configure(padx=10, pady=5)


class TablePanel:
    def __init__(self, root):
        t_panel = ttk.Notebook(root)
        t_panel.grid(column=0, row=0, sticky='nwse')

        for i in range(3):
            t_panel_in = tk.Frame(t_panel)

            canvas = tk.Canvas(t_panel_in, bg=PINK)
            canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=tk.TRUE)

            t_panel_scroll = tk.Frame(canvas)

            self.fill_table(t_panel_scroll, i)

            scroll = ScrollBar(t_panel_in, canvas)

            canvas.configure(yscrollcommand=scroll.item.set)
            canvas.create_window(0, 0, window=t_panel_scroll, anchor="nw")

            t_panel_scroll.bind("<Configure>", lambda event: scroll.update(event, canvas))
            scroll.bind_tree(canvas, "<MouseWheel>", lambda event: scroll.on_mousewheel(event, canvas))

            t_panel.add(t_panel_in, text=str(i)+'kek')

    def fill_table(self, parent, lul):
        for i in range(1, 21):
            for j in range(12):
                label = tk.Label(parent, text=str(j)+"kekekk " + str(lul))
                label.grid(column=j, row=i)


def create_window():
    m_window = MainWindow()
    root = m_window.item
    w_width = m_window.s_width
    w_height = m_window.s_height

    SelectsPanel(root, w_width)
    TablePanel(root)

    root.mainloop()
