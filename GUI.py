import tkinter as tk


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

        s_panel = tk.Frame(root)
        s_panel.grid(column=1, row=0, sticky='ns')

        canvas = tk.Canvas(s_panel, bg='#F1A2D2', width=round(width/13))
        canvas.pack(side='left', fill='y')

        s_panel_scroll = tk.Frame(canvas, bg='#F1A2D2')

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


class TablePanel:
    def __init__(self, root, width, height):
        t_panel = tk.Frame(root, bg='#E467B3')
        t_panel.grid(column=0, row=0, sticky='nwse')


def create_window():
    m_window = MainWindow()
    root = m_window.item
    w_width = m_window.s_width
    w_height = m_window.s_height

    SelectsPanel(root, w_width)
    TablePanel(root, w_width, w_height)

    root.mainloop()
