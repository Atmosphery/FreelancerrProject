from glob import glob
import os
import subprocess
import Database
#install dependencies
self_dir = os.getcwd()
root_dir = os.path.normpath(self_dir + os.sep + os.pardir)
clearConsole = lambda: os.system('cls' if os.name in ('nt', 'dos') else 'clear')
script_location = root_dir + os.sep + "Backend"
def deploy_docker():
    os.chdir(script_location)
    subprocess.call([r""+script_location+"\BuildAndDeployAll.bat"])
    os.chdir(self_dir)
    clearConsole()
    print("""
    Waiting for Databases to be ready...
    Usually takes around 20 seconds
    """)
    Database.wait_for_database()
    Database.setup_databases_with_data()

def full_deploy():
    deploy_docker()

def delete_all():
    global script_location
    os.chdir(script_location)
    subprocess.call([r""+script_location+"\DELETEswarm.bat"])
    os.chdir(self_dir)
    clearConsole()
    print("""
    Deleted all containers
    """)

def rebuild_and_deploy():
    delete_all()
    full_deploy()



if __name__ == "__main__":
    
    print("This is a module please run Main.py")