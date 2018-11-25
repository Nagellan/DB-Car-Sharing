import tkinter as tk

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


class SelectsPanel:
    def __init__(self, root, width):
        def update_scroll(event):
            canvas.configure(scrollregion=canvas.bbox("all"))

        def on_mousewheel(event):
            canvas.yview_scroll(round(-1 * (event.delta / 70)), "units")

        def bind_tree(widget, event, callback):
            widget.bind(event, callback)

            for child in widget.children.values():
                bind_tree(child, event, callback)

        s_panel = tk.Frame(root)
        s_panel.grid(column=1, row=0, sticky='ns')

        canvas = tk.Canvas(s_panel, bg=LIGHT_PINK, width=round(width/13))
        canvas.pack(side='left', fill='y')

        s_panel_scroll = tk.Frame(canvas, bg=LIGHT_PINK)

        for i in range(1, 11):
            select_1 = tk.Button(s_panel_scroll, text='Select ' + str(i), padx=10, pady=10, bg='white', relief=tk.FLAT,
                                 overrelief=tk.GROOVE, highlightthickness=0)
            select_1.grid(column=0, row=i, sticky='we')
            select_1.grid_configure(padx=10, pady=5)

        scroll = tk.Scrollbar(s_panel, orient='vertical', command=canvas.yview)
        scroll.pack(side='right', fill='y')

        canvas.configure(yscrollcommand=scroll.set)
        canvas.create_window(0, 0, window=s_panel_scroll, anchor=tk.CENTER)

        s_panel_scroll.bind("<Configure>", update_scroll)
        bind_tree(canvas, "<MouseWheel>", on_mousewheel)


class TablePanel:
    def __init__(self, root, width, height):
        def update_scroll(event):
            canvas.configure(scrollregion=canvas.bbox("all"))

        def on_mousewheel(event):
            canvas.yview_scroll(round(-1 * (event.delta / 70)), "units")

        def bind_tree(widget, event, callback):
            widget.bind(event, callback)

            for child in widget.children.values():
                bind_tree(child, event, callback)

        t_panel = tk.Frame(root, bg=PINK)
        t_panel.grid(column=0, row=0, sticky='nwse')

        canvas = tk.Canvas(t_panel, bg=PINK)
        canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=tk.TRUE)

        t_panel_scroll = tk.Frame(canvas, bg='red')

        for i in range(1, 11):
            for j in range(10):
                label = tk.Label(t_panel_scroll, text=str(j)+"kekekke")
                label.grid(column=j, row=i)

        scroll = tk.Scrollbar(t_panel, orient='vertical', command=canvas.yview)
        scroll.pack(side='right', fill='y')

        canvas.configure(yscrollcommand=scroll.set)
        canvas.create_window(0, 0, window=t_panel_scroll, anchor=tk.CENTER)

        t_panel_scroll.bind("<Configure>", update_scroll)
        bind_tree(canvas, "<MouseWheel>", on_mousewheel)


def create_window():
    m_window = MainWindow()
    root = m_window.item
    w_width = m_window.s_width
    w_height = m_window.s_height

    SelectsPanel(root, w_width)
    TablePanel(root, w_width, w_height)

    root.mainloop()
