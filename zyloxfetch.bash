#!/bin/bash

# Function to display ASCII art based on OS
get_ascii_art() {
    case "$OS_NAME" in
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
            echo "No ASCII art available for this OS."
            ;;
    esac
}

# Gather system information
get_system_info() {
    OS_NAME=$(cat /etc/os-release | grep -w PRETTY_NAME | cut -d= -f2 | tr -d '"')
    HOSTNAME=$(hostname)
    KERNEL=$(uname -r)
    UPTIME=$(uptime -p | sed 's/up //')
    CPU=$(lscpu | grep "Model name:" | sed 's/Model name: *//g')
    MEMORY=$(free -h --si | awk '/Mem:/ {print $3 " / " $2}')
    DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
    IP=$(hostname -I | awk '{print $1}')
}

# Display information
display_info() {
    get_ascii_art
    echo "--------------------------------------------------"
    echo "HOSTNAME          : $HOSTNAME"
    echo "OPERATING SYSTEM  : $OS_NAME"
    echo "KERNEL            : $KERNEL"
    echo "UPTIME            : $UPTIME"
    echo "CPU               : $CPU"
    echo "MEMORY            : $MEMORY"
    echo "DISK              : $DISK"
    echo "IP ADDRESS        : $IP"
    echo "--------------------------------------------------"
}

# Main Execution
get_system_info
display_info
