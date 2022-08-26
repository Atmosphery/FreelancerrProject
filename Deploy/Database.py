from pymongo import MongoClient
import pyodbc
import json

sql_string = "DRIVER={ODBC Driver 17 for SQL Server}; SERVER=LAPTOP-6H5NQFS0; Database=testdata; Trusted_Connection=yes;"
mongo_string = "mongodb://localhost:27017/"

sql_connection = pyodbc.connect(sql_string)
sql_cursor = sql_connection.cursor()

mongo_connection = MongoClient(mongo_string)
mongo_db = mongo_connection.testdata
mongo_collection = mongo_db.persons
def insert_data_mongo():
    f = open("Deploy\mongo_data.json", "r")
    data = json.load(f)
    f.close()
    mongo_collection.insert_many(data["dummy_data"])
def insert_data_sql():
    pass


if __name__ == "__main__":
    insert_data_mongo()
    # result = sql_cursor.execute("SELECT * FROM Persons")
    # print(result.fetchall())
    # print(mongo_db.list_collection_names())
    #print("This is a module please run Main.py")
