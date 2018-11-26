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

queries = open("queries.sql", 'r')
selects = []
for line in queries:
    cursor.execute(line[:-1])
    selects.append(cursor.fetchall())

save()
connection.close()

ui.create_window(selects, [])
