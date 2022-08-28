import os
import subprocess
import Database
#install dependencies
self_dir = os.getcwd()
root_dir = os.path.normpath(self_dir + os.sep + os.pardir)

def deploy_docker():
    script_location = root_dir + os.sep + "Backend"
    os.chdir(script_location)
    subprocess.call([r""+script_location+"\BuildAndDeployAll.bat"])
    os.chdir(self_dir)

def insert_database_data():
    Database.insert_data_mongo()
    Database.insert_data_sql()

def full_deploy():
    deploy_docker()

def delete_all():
    pass

def rebulild_and_deploy():
    pass



if __name__ == "__main__":
    print("This is a module please run Main.py")