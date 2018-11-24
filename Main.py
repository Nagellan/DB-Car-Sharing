import sqlite3


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
