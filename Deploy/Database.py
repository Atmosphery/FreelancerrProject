from traceback import print_tb
from pymongo import MongoClient
import json
import pyodbc
import json
import time
import os

#Change this to TRUE if you want to use localhost databases
#Change this to FALSE if you want to use Docker Databases
UseDEBUG = False

sql_string = ""
mongo_string = ""
jobs_string=""
sql_connection, sql_cursor, mongo_connection, mongo_collection = None,None,None,None
jobs_connection, jobs_cursor = None, None
connection_attempts = 0



def insert_data_mongo():
    f = open("mongo_data.json", "r")
    data = json.load(f)
    f.close()
    mongo_collection.insert_many(data["dummy_data"])
def insert_data_sql():
    f = open("sql_data.json", "r")
    data = json.load(f)
    f.close()
    create_table_if_not_exist("Appointments")
    for item in data["Appointment_data"]:
        print(item)
        sql_cursor.execute("SET IDENTITY_INSERT Appointments ON")
        sql_cursor.execute("""
        INSERT INTO dbo.Appointments (id, status, vendorid, customerid, jobid, appointmentdate)
        VALUES (?, ?, ?, ?, ?, ?)
        """, item["id"], item["status"], item["vendorid"], item["customerid"], item["jobid"], item["appointmentdate"])
    sql_connection.commit()
def insert_data_jobs():
    f = open("sql_data.json", "r")
    data = json.load(f)
    f.close()
    for item in data["jobs_data"]:
        print(item)
        jobs_cursor.execute("SET IDENTITY_INSERT Jobs ON")
        jobs_cursor.execute("""
        INSERT INTO dbo.Jobs (id, title, description, userid, baseprice, imagelink)
        VALUES (?, ?, ?, ?, ?, ?)
        """, item["id"], item["title"], item["description"], item["userid"], item["baseprice"], item["imagelink"])
    jobs_connection.commit()
def debugthings():
    global sql_string, mongo_string, jobs_string
    if(UseDEBUG):
        sql_string = "DRIVER={ODBC Driver 17 for SQL Server}; SERVER=LAPTOP-6H5NQFS0; Database=testdata; Trusted_Connection=yes;"
        mongo_string = "mongodb://localhost:27017/"
    else:
        sql_string = "DRIVER={ODBC Driver 17 for SQL Server}; SERVER=tcp:127.0.0.1,1500; Database=AppointmentDb; UID=SA; PWD=abc123!!@;"
        mongo_string = "mongodb://root:root@localhost:27018/?authMechanism=DEFAULT&authSource=admin"
        jobs_string = "DRIVER={ODBC Driver 17 for SQL Server}; SERVER=tcp:127.0.0.1,1501; Database=JobDb; UID=sa; PWD=abc123!!@; "

def insert_data():
    print("Inserting Data into SQL")
    insert_data_sql()
    print("Inserting Data into Mongo")
    insert_data_mongo()
    print("Closing connections")
    close_database_connections()

def create_table_if_not_exist(tablename):
    if sql_cursor.tables(table=tablename, tableType='TABLE').fetchone():
        print("Table %s already exists" %tablename)
    else:
        print("Table %s does not exist... Creating table" %tablename)
        sql_cursor.execute("""
            CREATE TABLE Appointments (
            id int NOT NULL IDENTITY PRIMARY KEY,
            status varchar(255),
            VendorId int,
            CustomerId int,
            JobId int,
            AppointmentDate Date
            );
                        """)
def setup_database_connections():
    global sql_connection, sql_cursor, mongo_connection, mongo_collection, jobs_connection, jobs_cursor
    debugthings()
    print("Attempting to Connect to SQL Databases...")
    jobs_connection = pyodbc.connect(jobs_string)
    jobs_cursor = jobs_connection.cursor()
    print("Connected to Jobs Database")
    sql_connection = pyodbc.connect(sql_string)
    sql_cursor = sql_connection.cursor()
    print("Connected to Appointment Database")

    print("Connecting to Mongo Database....")
    mongo_connection = MongoClient(mongo_string)
    mongo_db = mongo_connection.users
    mongo_collection = mongo_db.user
    print("Successfully Connected to SQL and Mongo Databases")

def close_database_connections():
    sql_connection.close()
    mongo_connection.close()
    jobs_connection.close()

def setup_databases_with_data():
    setup_database_connections()
    insert_data_sql()
    insert_data_mongo()
    insert_data_jobs()
    print("Successfully setup databases with data")
    print("Please wait 30 seconds for eureka and api gateway to register services")
    close_database_connections()
def wait_for_database():
    global connection_attempts
    while True:
        try:
            setup_database_connections()
            break
        except Exception as e:
            connection_attempts += 1
            if connection_attempts > 10:
                raise Exception("Could not connect to databases")
                break
            time.sleep(5)
if __name__ == "__main__":
    print("This is a module please run Main.py")
