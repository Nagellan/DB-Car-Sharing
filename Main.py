import sqlite3
import GUI as ui
import datetime


def fill_db():
    sample_data = open("sample_data.sql", 'r')
    for query in sample_data:
        cursor.execute(query)
    save()


def reset_db():
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    table_names = list(map(lambda x: x[0], cursor.fetchall()))
    for t_name in table_names:
        cursor.execute("DELETE FROM " + t_name)
    save()


def save():
    connection.commit()


def select_1():
    data = []
    for j in range(24):
        format = "%Y-%m-%d %H:%M:%S"
        date_left = datetime.datetime(2018, 11, 1, j, 0, 0)
        if j == 23:
            date_right = datetime.datetime(2018, 11, 1, j, 59, 59)
        else:
            date_right = datetime.datetime(2018, 11, 1, j + 1, 0, 0)
        cursor.execute("SELECT count(*) FROM 'app_charging' WHERE Date >= '" + date_left.strftime(format) + "' AND Date <= '" + date_right.strftime(format) + "'")
        data.append((date_left.strftime(format) + "->" + date_right.strftime(format), cursor.fetchone()))
    return data


def select_2():
    morning = 0
    afternoon = 0
    evening = 0
    for j in range(1, 8):
        format = "%Y-%m-%d %H:%M:%S"
        date_left = datetime.datetime(2018, 11, j, 7, 0, 0)
        date_right = datetime.datetime(2018, 11, j, 10, 0, 0)
        cursor.execute("SELECT count(*) FROM app_vehicle")
        all_vehicles = cursor.fetchone()[0]
        cursor.execute("SELECT count(DISTINCT TripVehicle_id) FROM app_trip WHERE (Arrival >= '" +
                       date_left.strftime(format) + "' AND Departure <= '" +
                       date_right.strftime(format) + "') OR (Arrival <= '" +
                       date_left.strftime(format) + "' AND Departure >= '" +
                       date_left.strftime(format) + "') OR (Arrival >= '" +
                       date_left.strftime(format) + "' AND Arrival <= '" +
                       date_right.strftime(format) + "' AND Departure >= '" +
                       date_right.strftime(format) + "')")
        encountered = cursor.fetchone()[0]
        morning += encountered / all_vehicles * 100.0
        date_left = datetime.datetime(2018, 11, j, 12, 0, 0)
        date_right = datetime.datetime(2018, 11, j, 14, 0, 0)
        cursor.execute(
            "SELECT count(DISTINCT TripVehicle_id) FROM 'app_trip' WHERE (Arrival >= '" + date_left.strftime(
                format) + "' AND Departure <= '" + date_right.strftime(
                format) + "') OR (Arrival <= '" + date_left.strftime(
                format) + "' AND Departure >= '" + date_left.strftime(
                format) + "') OR (Arrival >= '" + date_left.strftime(
                format) + "' AND Arrival <= '" + date_right.strftime(
                format) + "' AND Departure >= '" + date_right.strftime(format) + "')")
        afternoon += cursor.fetchone()[0] / all_vehicles * 100.0
        date_left = datetime.datetime(2018, 11, j, 17, 0, 0)
        date_right = datetime.datetime(2018, 11, j, 19, 0, 0)
        cursor.execute(
            "SELECT count(DISTINCT TripVehicle_id) FROM 'app_trip' WHERE (Arrival >= '" + date_left.strftime(
                format) + "' AND Departure <= '" + date_right.strftime(
                format) + "') OR (Arrival <= '" + date_left.strftime(
                format) + "' AND Departure >= '" + date_left.strftime(
                format) + "') OR (Arrival >= '" + date_left.strftime(
                format) + "' AND Arrival <= '" + date_right.strftime(
                format) + "' AND Departure >= '" + date_right.strftime(format) + "')")
        evening += cursor.fetchone()[0] / all_vehicles * 100.0
    morning /= 7.0
    afternoon /= 7.0
    evening /= 7.0
    data = [(morning, afternoon, evening)]
    return data


def select_4():
    cursor.execute("SELECT count(*) AS value_occurrence FROM app_vehicle INNER JOIN (SELECT TripVehicle_id as tvid FROM app_trip WHERE Departure > '2018-12-01 10:20:30') ON app_vehicle.id = tvid ORDER BY 'value_occurrence' DESC")
    return cursor.fetchall()


def get_selects():
    _selects = [
        select_1(),
        select_2(),
        select_4()
    ]

    return _selects


def get_full_db():
    data = []
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    table_names = list(map(lambda x: x[0], cursor.fetchall()))
    table_names.remove("sqlite_sequence")
    for t_name in table_names:
        cursor.execute("SELECT * FROM "+t_name)
        data.append((t_name, cursor.fetchall()))
    return data


connection = sqlite3.connect('car_sharing.db')
cursor = connection.cursor()

# fill_db()
# reset_db()

selects = get_selects()
tables = get_full_db()

connection.close()

ui.create_window(selects, tables)
