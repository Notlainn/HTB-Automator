---

# 🔥 HackTheBox Automation Script 🔥

Esse script Bash facilita a automação de tarefas de pentesting na plataforma HackTheBox (HTB), incluindo varreduras de portas, fuzzing de diretórios e de DNS. Com uma interface interativa, ele cria automaticamente pastas para armazenar os resultados e adiciona entradas ao arquivo `/etc/hosts` conforme necessário. 🔒✨

## ✨ Características
- **Banner Animado**: Exibe uma animação de banner estilizada ao iniciar o script.
- **Modo Portscan**: Executa uma varredura de portas usando o `rustscan`.
- **Fuzzing DNS**: Testa subdomínios com o `ffuf` e adiciona os encontrados ao `/etc/hosts`.
- **Fuzzing de Diretórios**: Permite selecionar entre `ffuf`, `feroxbuster` ou `gobuster` para descoberta de diretórios.
- **Automação com Estilo**: Inclui uma animação de carregamento para indicar progresso nas operações.

## 🚀 Requisitos
- **Ferramentas Necessárias**: Certifique-se de que as seguintes ferramentas estão instaladas:
  - `rustscan`
  - `ffuf`
  - `feroxbuster`
  - `gobuster`
- **Permissões de Superusuário**: Algumas operações, como edição do `/etc/hosts`, requerem privilégios de root.

## 📥 Instalação
Clone o repositório e navegue até o diretório:
```bash
git clone https://github.com/Notlainn/HTB-Automator
cd HTB-Automator
```

## 📝 Uso
O script possui os seguintes modos de operação:
- `all`: Executa todas as operações (varredura de portas, fuzzing DNS e fuzzing de diretórios).
- `portscan`: Realiza apenas a varredura de portas.
- `dns`: Executa o fuzzing de subdomínios.
- `fdir`: Executa o fuzzing de diretórios.

Para iniciar o script, utilize o seguinte comando:
```bash
./bash_automator.sh <modo>
```
**Exemplo**:
```bash
./bash_automator.sh all
```

### Fluxo Interativo
1. **Nome e IP**: O script solicitará que você insira o nome e o IP do alvo.
2. **Criação de Diretório**: Um diretório dedicado ao alvo será criado no Desktop.
3. **Adição ao `/etc/hosts`**: O IP e o nome do alvo serão adicionados ao `/etc/hosts` (se ainda não existirem).
4. **Seleção de Modo**: Dependendo do modo selecionado, o script perguntará se você deseja prosseguir com cada operação, adicionando uma animação de carregamento.

## 🔍 Exemplo de Execução
```bash
./bash_automator.sh all
```
1. Insira o nome e o IP do alvo quando solicitado.
2. O script cria a pasta no Desktop (`/home/kali/Desktop/HTB`).
3. Se o modo `portscan` for selecionado, ele executa o `rustscan` no IP.
4. Se o modo `dns` for selecionado, ele faz o fuzzing de subdomínios com o `ffuf`.
5. Se o modo `fdir` for selecionado, você pode escolher entre `ffuf`, `feroxbuster` ou `gobuster` para o fuzzing de diretórios.

## ⚙️ Exemplo de Configuração
- **Configuração do Host**: O script adiciona automaticamente o domínio `nome.htb` e subdomínios ao `/etc/hosts` quando encontrados.
- **Portas e Padrões**: As ferramentas de fuzzing são configuradas para procurar respostas de status HTTP específicas (como 200, 301 e 403).

## ⚠️ Aviso
Este script é fornecido apenas para fins educacionais e deve ser usado de maneira ética e responsável.

--- 
