#!/bin/bash

# Detect OS and display the appropriate ASCII logo
ascii_logo() {
    case "$1" in
        *Ubuntu*)
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
        *Arch*)
            cat << "EOF"
                 /\\
                /  \\
               /\\   \\
              /      \\
             /   ,,   \\
            /   |  |  -\\
           /_-''    ''-_\\
EOF
            ;;
        *Debian*)
            cat << "EOF"
       _._     
    _.-"" __ ""-._
   .'    '.'  '::-.       
  /      :     :::
 |       :     :::        
 |       :     :::        
 |       :     :::        
  \      :     :::
   `._   :  .'::'     
      """---"""    
EOF
            ;;
        *Fedora*)
            cat << "EOF"
       ___
     //   \\
    ||     ||
     \\___//
      '-'-'
EOF
            ;;
        *)
            echo "No ASCII logo available for your OS."
            ;;
    esac
}

# Function to display system information
display_system_info() {
    local os_name os_version kernel uptime cpu memory disk gpu resolution shell terminal hostname user
    local theme wm

    # Fetch system information
    os_name=$(lsb_release -si 2>/dev/null || echo "Unknown OS")
    os_version=$(lsb_release -sr 2>/dev/null || echo "Unknown Version")
    kernel=$(uname -r)
    uptime=$(awk '{printf("%d days, %02d:%02d:%02d", $1/86400, ($1%86400)/3600, ($1%3600)/60, $1%60)}' /proc/uptime)
    cpu=$(grep -m1 'model name' /proc/cpuinfo | cut -d':' -f2 | sed 's/^ //g')
    memory=$(free -h --si | awk '/^Mem:/ {print $3 " / " $2}')
    disk=$(df -h --output=used,size --total | tail -1 | awk '{print $1 " / " $2}')
    gpu=$(lspci | grep -i 'vga\|3d' | cut -d':' -f3 | xargs)
    resolution=$(xdpyinfo 2>/dev/null | grep dimensions | awk '{print $2}' || echo "N/A")
    shell=$SHELL
    terminal=$TERM
    hostname=$(hostname)
    user=$USER

    # Display custom info
    echo "--------------------------------------------------"
    echo "OS:                  | $os_name $os_version"
    echo "Kernel:              | $kernel"
    echo "Uptime:              | $uptime"
    echo "CPU:                 | $cpu"
    echo "Memory:              | $memory"
    echo "Disk:                | $disk"
    echo "GPU:                 | $gpu"
    echo "Resolution:          | $resolution"
    echo "Shell:               | $shell"
    echo "Terminal:            | $terminal"
    echo "Hostname:            | $hostname"
    echo "User:                | $user"
    echo "--------------------------------------------------"
}

# Main script execution
os_name=$(lsb_release -si 2>/dev/null || echo "Unknown OS")
ascii_logo "$os_name"
display_system_info
