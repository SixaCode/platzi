# !/bin/bash

# TO-DO LIST MANAGER - By Brian Gutierrez
# GitHub: @SixaCode

# This project demonstrates my skills in Bash programming. It was made due to an alternative to present a project in Platzi course "Programación en Bash Shell"

tasksFile=tasks.txt

# Function to list all tasks in the file.
list_tasks () {
    if [[ -s $tasksFile ]]; then
        echo "Your Tasks:"
        nl -w2 -s '. ' $tasksFile
    else
        echo "No tasks found."
    fi
}


while :
do
    # Clear the screen to show the menu
    clear
    # Show options menu
    echo "======================================="
    echo "TO DO LIST MANAGER - by Brian Gutierrez"
    echo "======================================="
    echo "              MAIN MENU                "
    echo "1. List all tasks"
    echo "2. Add a task"
    echo "3. Remove a task"
    echo "4. Mark a task as completed"
    echo "5. Exit"

    # Read option entered by user
    read -n1 -p "Enter an option (1-5): " option

    # Check entered option
    case $option in
        1)
            clear
            list_tasks
            read -n1 -s -r -p "Press any key to continue..."
            ;;
        2)
            echo ""
            read -p "Enter a new task: " task
            echo -e "[ ] $task" >> "$tasksFile"
            echo -e "\nTask added."
            read -n1 -s -r -p "Press any key to continue..."
            ;;
        3) 
            clear
            list_tasks
            read -p "Enter the task number to delete: " taskNum
            sed -i "${taskNum}d" "$tasksFile"
            echo -e "\nTask deleted."
            read -n1 -s -r -p "Press any key to continue..."
            ;;
        4)
            clear
            list_tasks
            while :
            do
                echo ""
                read -p  "Enter the task number to mark as completed: " taskNum
                if ! [[ $taskNum =~ ^[0-9]+$ ]] || (($taskNum < 1)) || (($taskNum > $(wc -l < "$tasksFile"))); then
                    echo "Invalid task number. Try again."
                else
                    sed -i "${taskNum}s/^\[ \]/[X]/" "$tasksFile"
                    echo "Task #${taskNum} marked as completed."
                    break
                fi
            done
            read -n1 -s -r -p "Press any key to continue..."
            ;;
        5)
            echo -e "\nHave a good day :)"
            exit
            ;;
        *)
            echo -e "\nInvalid option. Please try again."
            continue
            ;;
    esac
done
