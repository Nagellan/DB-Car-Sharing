import tkinter as tk
from tkinter import ttk

LIGHT_PINK = '#F1A2D2'
PINK = '#E467B3'


class MainWindow:
    def __init__(self):
        root = tk.Tk()
        root.title("Car sharing system")
        root.iconbitmap(default="favicon.ico")

        s_width = round(root.winfo_screenwidth()*0.8)       # screen width
        s_height = round(root.winfo_screenheight()*0.8)     # screen width

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


def fill_table(parent, table):
    i = 0
    for row in table:
        j = 0
        for cell in row:
            label = tk.Label(parent, text=cell, bd=8, bg='white')
            label.grid(column=j, row=i, padx=2, pady=2)
            j = j + 1
        i = i + 1


class SelectsPanel:
    def __init__(self, root, width, selects):
        s_panel = tk.Frame(root)
        s_panel.grid(column=1, row=0, sticky='ns')

        canvas = tk.Canvas(s_panel, bg=LIGHT_PINK, width=round(width/13))
        canvas.pack(side='left', fill='y')

        s_panel_scroll = tk.Frame(canvas, bg=LIGHT_PINK)

        self.fill_buttons(s_panel_scroll, selects)

        scroll = ScrollBar(s_panel, canvas)

        canvas.configure(yscrollcommand=scroll.item.set)
        canvas.create_window(0, 0, window=s_panel_scroll, anchor=tk.CENTER)

        s_panel_scroll.bind("<Configure>", lambda event: scroll.update(event, canvas))
        scroll.bind_tree(canvas, "<MouseWheel>", lambda event: scroll.on_mousewheel(event, canvas))

        self.s_panel = s_panel

    def fill_buttons(self, parent, selects):
        i = 1
        for select in selects:
            select_1 = tk.Button(parent, text=select[0], padx=10, pady=10, bg='white',
                                 relief=tk.FLAT, overrelief=tk.GROOVE, highlightthickness=0,
                                 command=lambda sel=select[1]: self.open_window(sel))
            select_1.grid(column=0, row=i, sticky='we')
            select_1.grid_configure(padx=10, pady=5)
            i = i + 1

    def open_window(self, table):
        pop_up = tk.Toplevel(self.s_panel)
        fill_table(pop_up, table)


class TablePanel:
    def __init__(self, root, tables):
        def switch_tab(event):
            tab = event.widget.winfo_children()[event.widget.index("current")].winfo_children()[0]
            scroll.bind_tree(tab, "<MouseWheel>", lambda _event: scroll.on_mousewheel(_event, tab))
            tab.bind("<Configure>", lambda _event: scroll.update(_event, tab))
            tab.configure(scrollregion=tab.bbox("all"))

        t_panel = ttk.Notebook(root)
        t_panel.grid(column=0, row=0, sticky='nwse')

        for table in tables:
            t_panel_in = tk.Frame(t_panel)

            canvas = tk.Canvas(t_panel_in, bg=PINK)
            canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=tk.TRUE)

            t_panel_scroll = tk.Frame(canvas)

            fill_table(t_panel_scroll, table[1])

            scroll = ScrollBar(t_panel_in, canvas)

            canvas.configure(yscrollcommand=scroll.item.set)
            canvas.create_window(0, 0, window=t_panel_scroll, anchor="nw")

            t_panel.bind("<<NotebookTabChanged>>", lambda event: switch_tab(event))

            t_panel.add(t_panel_in, text=table[0][4:])


def create_window(selects, tables):
    m_window = MainWindow()
    root = m_window.item
    w_width = m_window.s_width

    SelectsPanel(root, w_width, selects)
    TablePanel(root, tables)

    root.mainloop()
