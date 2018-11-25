import sqlite3
import GUI as ui


def fill_db():
    sql = ''''''
    cursor.execute(sql)


def reset_db():
    sql = ''''''
    cursor.execute(sql)


def save():
    connection.commit()


connection = sqlite3.connect('car_sharing.db')
cursor = connection.cursor()

connection.close()

ui.create_window()