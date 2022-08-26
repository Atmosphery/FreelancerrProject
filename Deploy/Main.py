import DeployAll

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
            DeployAll.full_deploy()
        elif choice == "2":
            DeployAll.rebuild_and_deploy()
        elif choice == "3":
            DeployAll.delete_all()
        elif choice == "4":
            break
        else:
            print("Invalid choice")
            continue
        break

if __name__ == "__main__":
    DeployAll.full_deploy()