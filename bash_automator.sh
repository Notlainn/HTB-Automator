#!/bin/bash

RED='\e[1;31m'
GREEN='\e[1;32m'
PURPLE='\e[1;35m'
CYAN='\e[1;36m'
NC='\e[0m'

show_banner() {
  LIGHT_PURPLE='\e[1;35m'  # Roxo claro
  DARK_PURPLE='\e[0;35m'   # Roxo escuro

  # Mensagem a ser exibida
  MESSAGE="No matter where you go, everyone is connected."
  MESSAGE_LENGTH=${#MESSAGE}
  
  # Calcular a largura total da borda e o número de espaços para centralização
  BORDER_WIDTH=61
  SPACES=$(( (BORDER_WIDTH - MESSAGE_LENGTH) / 2 ))
  SPACE_STRING=$(printf '%*s' "$SPACES")

  # Exibir o banner
  echo -e "${DARK_PURPLE}╔═════════════════════════════════════════════════════════════╗
${LIGHT_PURPLE}
   ██████╗ ${DARK_PURPLE}██████╗ ${LIGHT_PURPLE}██████╗ ${DARK_PURPLE}██╗      ${LIGHT_PURPLE}█████╗ ${DARK_PURPLE}███╗   ██╗${LIGHT_PURPLE}██████╗ 
  ${DARK_PURPLE}██╔════╝${LIGHT_PURPLE}██╔═══██╗${DARK_PURPLE}██╔══██╗${LIGHT_PURPLE}██║     ${DARK_PURPLE}██╔══██╗${LIGHT_PURPLE}████╗  ██║${DARK_PURPLE}██╔══██╗
  ${LIGHT_PURPLE}██║     ${DARK_PURPLE}██║   ██║${LIGHT_PURPLE}██████╔╝${DARK_PURPLE}██║     ${LIGHT_PURPLE}███████║${DARK_PURPLE}██╔██╗ ██║${LIGHT_PURPLE}██║  ██║
  ${DARK_PURPLE}██║     ${LIGHT_PURPLE}██║   ██║${DARK_PURPLE}██╔═══╝ ${LIGHT_PURPLE}██║     ${DARK_PURPLE}██╔══██║${LIGHT_PURPLE}██║╚██╗██║${DARK_PURPLE}██║  ██║
  ${LIGHT_PURPLE}╚██████╗${DARK_PURPLE}╚██████╔╝${LIGHT_PURPLE}██║     ${DARK_PURPLE}███████╗${LIGHT_PURPLE}██║  ██║${DARK_PURPLE}██║ ╚████║${LIGHT_PURPLE}██████╔╝
   ${DARK_PURPLE}╚═════╝ ${LIGHT_PURPLE}╚═════╝ ${DARK_PURPLE}╚═╝     ${LIGHT_PURPLE}╚══════╝${DARK_PURPLE}╚═╝  ╚═╝${LIGHT_PURPLE}╚═╝  ╚═══╝${DARK_PURPLE}╚═════╝

${DARK_PURPLE}╚═════════════════════════════════════════════════════════════╝"

  # Exibir o banner
  echo -e "$echo" 

  # Escrever a mensagem letra por letra
  for (( i=0; i<MESSAGE_LENGTH; i++ )); do
    echo -ne "\r${DARK_PURPLE}${SPACE_STRING}${LIGHT_PURPLE}${MESSAGE:0:i+1}"
    sleep 0.02
  done

  # Exibir a mensagem finalizada e borda inferior
  echo -ne "\r${DARK_PURPLE}${SPACE_STRING}${LIGHT_PURPLE}${MESSAGE}" # Exibe a mensagem completa
  echo ""
  echo ""
  echo -e "${DARK_PURPLE}╔═════════════════════════════════════════════════════════════╗${NC}"
}
# Função para mostrar a animação de carregamento
show_loading() {
BLA_modern_metro=(
    '█░░░░░░░' 
    '██░░░░░░' 
    '███░░░░░' 
    '████░░░░' 
    '█████░░░' 
    '██████░░' 
    '███████░' 
    '████████' 
)
    # Inicializa a linha
    echo -n -e "${GREEN}[⊙]${NC} Loading "
    for i in "${BLA_modern_metro[@]}"; do
        # Atualiza a barra de carregamento
        echo -ne "\r${GREEN}[⊙]${NC} Loading ${PURPLE}${i}${NC} "
        sleep 0.1
    done
    # Retorna ao início da linha e substitui a mensagem
    echo -ne "\r${PURPLE}[⊙]${NC} Loading complete!${NC}\n"
    sleep 0.3
}

create_directory() {
    local dir="/home/kali/Desktop/HTB/$nome"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}[⊙]${NC} Created directory at: $dir"
    else
        echo -e "${RED}[⌀]${NC} Directory already exists: $dir"
    fi
}

show_banner
echo ""
echo -e "${PURPLE}[⊙]${NC} Enter the name: \c"
read nome
echo -e "${PURPLE}[⊙]${NC} Enter the IP: \c"
read ip

create_directory

verify=$(grep -w "$ip $nome.htb" /etc/hosts)

if [ -n "$verify" ]; then
    echo -e "${RED}[⌀]${NC} Directory already added to /etc/hosts"
else
    echo "$ip $nome.htb" | sudo tee -a /etc/hosts > /dev/null
    echo -e "${GREEN}[⊙]${NC} $ip $nome.htb added to /etc/hosts"
fi

# Mode verify
if [ $# -eq 0 ]; then
    echo -e "${RED}[⌀]${NC} Invalid mode! Use 'all', 'portscan', 'fdir' or 'dns'."
    exit 1
fi

portscan_mode() {	
        # Start Portscan with loading effects
        echo -e "${PURPLE}[⊙]${NC} Start Portscan?(s/n): \c"
        read pscan
        if [ "$pscan" == "s" ]; then
            cd /home/kali/Desktop/HTB/$nome
            show_loading
            rustscan -r 1-65535 --ulimit 5000 -t 2000 -a $ip -- -sV -sC -Pn -oN scan.txt
            echo -e "${GREEN}[⊙]${NC} Portscan finished!"
        else 
            echo -e "${RED}[⌀]${NC} Portscan canceled!"
        fi
        
}
dns_mode() {
        # Ask about fuzzing DNS
        echo -e "${PURPLE}[⊙]${NC} Start DNS fuzzing? (s/n): \c"
        read dns
        if [ "$dns" == "s" ]; then
            show_loading
            ffuf -c -u http://$nome.htb -H "Host: FUZZ.$nome.htb" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -t 100 -ac -o output -of md
            output=$(cat output | cut -d "|" -f4 | tail -n 2 | grep -v "/\/" | tr -d '/' | sed 's/:---------------//' > output)
            check=$(wc -w output | cut -d " " -f1)
            tr -d ' ' < output | grep -v '^$' > output1
            subdomain=$(cat output1)
            if [ "$check" -ge "1" ]; then
            	echo -e "${GREEN}[⊙]${NC} Subdomain founded!" 
                sudo sed -i "s|$ip $nome.htb|$ip $nome.htb $subdomain.$nome.htb|" /etc/hosts
      	        echo -e "${GREEN}[⊙]${NC} Subdomain added to /etc/hosts"
            else
            	echo -e "${RED}[⌀]${NC} No subdomain founded!"
            fi
                rm output
      	        rm output1
        else
            echo -e "${RED}[⌀]${NC} Fuzzing canceled!"
        fi     
}
dir_mode() {
	echo -e "${PURPLE}[⊙]${NC} Start directory fuzzing? (s/n): \c"
	read dir	
	if [ "$dir" == "s" ]; then
	  echo -e "${PURPLE}[⊙]${NC} Insert the port number: \c"
	  read port
	  echo -e "${PURPLE}[1] -➤${NC} ffuf\r\n${PURPLE}[2] -➤${NC} ferox\r\n${PURPLE}[3] -➤${NC} gobuster"
	  echo -e "${PURPLE}[⊙]${NC} Select tool: \c"
	  read tool
	    if [ "$tool" == "1" ];then
	        show_loading
	        ffuf -u http://$nome:$port/FUZZ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -mc 200,301,403
	    elif [ "$tool" == "2" ];then
	    	show_loading
	    	feroxbuster -u http://$nome:$port/ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -A -t 30 --filter-status 404
	    else 
	    	show_loading
	    	gobuster dir -u http://$nome:$port -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
	    fi
    else
    	echo -e "${RED}[⌀]${NC} Directory fuzzing canceled!"
    fi
}
case $1 in
    all)
    
    	portscan_mode
    	dns_mode
    	dir_mode
    	;;
    	
    portscan)

    	portscan_mode
    	;;
    
    dns)
        
    	dns_mode
    	;;
    
    fdir)
    
    	dir_mode
    	;;
    
    *)
        echo -e "${RED}[⌀]${NC} Invalid mode! Use 'all', 'portscan', 'fdir' or 'dns'."
        ;;
esac
