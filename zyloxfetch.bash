#!/bin/bash

# Colors
COLOR_RESET="\033[0m"
COLOR_BOLD="\033[1m"
COLOR_CYAN="\033[36m"
COLOR_YELLOW="\033[33m"
COLOR_MAGENTA="\033[35m"
COLOR_BLUE="\033[34m"
COLOR_GREEN="\033[32m"

# ASCII Art (Ubuntu example)
get_ascii_art() {
    case "$(uname -s)" in
        Linux)
            cat << "EOF"
             .-/+oossssoo+/-.              
         `:+ssssssssssssssssss+:`          
       -+ssssssssssssssssssyyssss+-        
     .ossssssssssssssssssdMMMNysssso.    
    /ssssssssssshdmmNNmmyNMMMMhssssss/  
   +ssssssssshmydMMMMMMMNddddyssssssss+ 
   /sssssssshNMMMyhhyyyyhmNMMMNhssssss/ 
  .ssssssssdMMMNhsssssssssshNMMMdssssss. 
 +sssshhhyNMMNyssssssssssssyNMMMysssssss+ 
 ossyNMMMNyMMhsssssssssssssshmmmhssssssso 
 ossyNMMMNyMMhsssssssssssssshmmmhssssssso 
 +sssshhhyNMMNyssssssssssssyNMMMysssssss+ 
  .ssssssssdMMMNhsssssssssshNMMMdssssss. 
   /sssssssshNMMMyhhyyyyhdNMMMNhssssss/ 
   +ssssssssshmydMMMMMMMNddddyssssssss+ 
    /ssssssssssshdmNNNNmyNMMMMhssssss/  
     .ossssssssssssssssssdMMMNysssso.    
       -+sssssssssssssssssyyyssss+-        
        `:+ssssssssssssssssss+:`          
            .-/+oossssoo+/-.              
EOF
            ;;
        Darwin)
            cat << "EOF"
            .            .                
         .o8          .o8                
       .o888oo      .o888oo  .ooooo.     
         888          888   d88' `88b    
         888          888   888   888    
         888 .        888 . 888   888    
         "888"        "888" `Y8bod8P'    
EOF
            ;;
        *)
            echo "OS ASCII Art not available."
            ;;
    esac
}

# System Information
get_system_info() {
    HOSTNAME=$(hostname)
    OS=$(uname -o 2>/dev/null || echo "Unknown")
    KERNEL=$(uname -r)
    CPU=$(lscpu | grep "Model name:" | sed 's/Model name: *//g')
    MEMORY=$(free -h --si | awk '/Mem:/ {print $3 "/" $2}')
    DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
    SWAP=$(free -h --si | awk '/Swap:/ {print $3 "/" $2}')
    UPTIME=$(uptime -p | sed 's/up //')
    GPU=$(lspci | grep -i vga | awk -F: '{print $3}' | sed 's/^ *//')
    BATTERY=$(acpi -b | awk '{print $4}' | tr -d ',' || echo "No battery")
    IP=$(hostname -I | awk '{print $1}')
}

# Display Information
display_info() {
    echo -e "${COLOR_CYAN}"
    get_ascii_art
    echo -e "${COLOR_RESET}"

    echo -e "${COLOR_BOLD}System Information:${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Hostname:       ${COLOR_YELLOW}${HOSTNAME}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}OS:             ${COLOR_YELLOW}${OS}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Kernel:         ${COLOR_YELLOW}${KERNEL}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Uptime:         ${COLOR_YELLOW}${UPTIME}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}CPU:            ${COLOR_YELLOW}${CPU}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}GPU:            ${COLOR_YELLOW}${GPU}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Memory:         ${COLOR_YELLOW}${MEMORY}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Swap:           ${COLOR_YELLOW}${SWAP}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Disk:           ${COLOR_YELLOW}${DISK}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}Battery:        ${COLOR_YELLOW}${BATTERY}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}IP Address:     ${COLOR_YELLOW}${IP}${COLOR_RESET}"
    echo
}

# Main Execution
get_system_info
display_info
