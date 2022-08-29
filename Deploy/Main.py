import Deploy
import os

def menu():
    print("""
    1. Deploy All + Database
    2. Rebuild and Deploy + Database
    3. Delete All
    4. Exit
    """)
    choice = input("Enter your choice: ")
    return choice
def main():
    while True:
        choice = menu()
        if choice == "1":
            Deploy.full_deploy()
        elif choice == "2":
            Deploy.rebuild_and_deploy()
        elif choice == "3":
            Deploy.delete_all()
        elif choice == "4":
            break
        else:
            print("Invalid choice")
            continue
        break
def verifyPath():
    currentpath = os.getcwd()
    if currentpath.find("Deploy") != -1:
        return True
    else:
        return False
if __name__ == "__main__":
    if not verifyPath():
        print("run from deploy directory")
    else:
        main()