#!/bin/bash

# Function to display ASCII art based on OS
get_ascii_art() {
    case "$OS" in
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
        *Debian*)
            cat << "EOF"
       _,met$$$$$gg.           
    ,g$$$$$$$$$$$$$$$P.        
  ,g$$P"     """Y$$.".         
 ,$$P'              `$$$.      
',$$P       ,ggs.     `$$b:    
`d$$'     ,$P"'   .    $$$     
 $$P      d$'     ,    $$P     
 $$:      $$.   -    ,d$$'     
 $$;      Y$b._   _,d$P'       
 Y$$.    `.`"Y$$$$P"'          
 `$$b      "-.__               
  `Y$$                         
   `Y$$.                       
     `$$b.                     
       `Y$$b.                  
          `"Y$b._              
              `""""            
EOF
            ;;
        *Arch*)
            cat << "EOF"
                 -`                 
                .o+`                
               `ooo/                
              `+oooo:               
             `+oooooo:              
             -+oooooo+:             
           `/:-:++oooo+:            
          `/++++/+++++++:           
         `/++++++++++++++:          
        `/+++ooooooooooooo/`        
       ./ooosssso++osssssso+`       
      .oossssso-````/ossssss+`      
     -osssssso.      :ssssssso.     
    :osssssss/        osssso+++`    
   /ossssssss/        +ssssooo/-    
 /ossssso+/:-        -:/+osssso+-   
`..--                  `-/+osssso+  
                                  ` 
EOF
            ;;
        *Fedora*)
            cat << "EOF"
          /:-------------:/          
       :-------------------::       
     :-----------/shhOHbmp---:\     
   /-----------omMMMNNNMMD  ---\    
  :-----------sMMMMNMNMP.    ---:   
 :-----------:MMMdP-------    ---:  
,------------:MMMd--------    ---:  
:------------:MMMd-------    .---:  
:----    oNMMMMMMMMMNho     .----:  
:--     .+shhhMMMmhhy++   .------/  
:-    -------:MMMd--------------:   
:-   --------/MMMd-------------;    
:-    ------/hMMMy------------:     
:-- :dMNdhhdNMMNo------------;      
:---:sdNMMMMNds:------------:       
:------:://:-------------::         
:---------------------://           
                                  
EOF
            ;;
        *CentOS*)
            cat << "EOF"
                 _               
              _/X               
              /X/               
             /X/               
            /XX/       _       
          _/XXX/     _/X/_     
        _/XXXXXX/_ _/XX/X/     
       /XXXXXXXXXX/XXXX/X/     
      /XXXXX/XXXXX/XXXX/X/     
     /XXXXX/XXXXX/XXXXXX/X/    
    /XXXXX/XXXXX/XXXXXX/X/     
   /XXXXX/XXXXX/XXXXXX/X/      
  /XXXXX/XXXXX/XXXXXX/X/       
 /XXXXX/XXXXX/XXXXXX/X/        
         /XXXXX/XXXXX/X/         
        /XXXXX/XXXXX/X/          
        /XXXXX/XXXXX/X/           
EOF
            ;;
        *)
            echo "ASCII art not available for OS: $OS"
            ;;
    esac
}

# Function to get system information
get_system_info() {
    HOSTNAME=$(hostname)
    OS=$(grep -w PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    KERNEL=$(uname -r)
    UPTIME=$(uptime -p | sed 's/up //')
    CPU=$(lscpu | grep "Model name:" | sed 's/Model name: *//g')
    CORES=$(nproc)
    MEMORY=$(free -h --si | awk '/Mem:/ {print $3 " / " $2}')
    SWAP=$(free -h --si | awk '/Swap:/ {print $3 " / " $2}')
    DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
    IP=$(hostname -I | awk '{print $1}')
    MAC=$(ip link show | grep link/ether | awk '{print $2}')
    GPU=$(lspci | grep -i vga | cut -d: -f3 | sed 's/^ *//')
    BATTERY=$(acpi -b | awk '{print $4}' | tr -d ',' || echo "No battery")
    SHELL=$(basename "$SHELL")
    TERMINAL=${TERM:-Unknown}
    USERS=$(who | awk '{print $1}' | sort | uniq | tr '\n' ', ' | sed 's/, $//')
    PROCESSES=$(ps aux | wc -l)
    LOAD=$(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')
    MOTHERBOARD=$(cat /sys/devices/virtual/dmi/id/board_vendor 2>/dev/null && cat /sys/devices/virtual/dmi/id/board_name 2>/dev/null)
    SERIAL=$(cat /sys/devices/virtual/dmi/id/product_serial 2>/dev/null || echo "Unknown")
}

# Display information
display_info() {
    get_ascii_art
    echo "--------------------------------------------------"
    echo "HOSTNAME          : $HOSTNAME"
    echo "OPERATING SYSTEM  : $OS"
    echo "KERNEL            : $KERNEL"
    echo "UPTIME            : $UPTIME"
    echo "CPU               : $CPU ($CORES cores)"
    echo "GPU               : $GPU"
    echo "MEMORY            : $MEMORY"
    echo "SWAP              : $SWAP"
    echo "DISK USAGE        : $DISK"
    echo "IP ADDRESS        : $IP"
    echo "MAC ADDRESS       : $MAC"
    echo "SHELL             : $SHELL"
    echo "TERMINAL          : $TERMINAL"
    echo "CURRENT USERS     : $USERS"
    echo "TOTAL PROCESSES   : $PROCESSES"
    echo "LOAD AVERAGE      : $LOAD"
    echo "MOTHERBOARD       : $MOTHERBOARD"
    echo "SERIAL NUMBER     : $SERIAL"
    echo "BATTERY           : $BATTERY"
    echo "--------------------------------------------------"
}

# Main execution
get_system_info
display_info
