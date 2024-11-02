---

# 🔥 HackTheBox Automation Script 🔥

This Bash script streamlines the automation of pentesting tasks on the HackTheBox (HTB) platform, including port scans, directory fuzzing, and DNS fuzzing. With an interactive interface, it automatically creates folders to store results and adds entries to the `/etc/hosts` file as needed. 🔒✨

## ✨ Features
- **Animated Banner**: Displays a stylish banner animation when the script starts.
- **Portscan Mode**: Runs a port scan using `rustscan`.
- **DNS Fuzzing**: Tests subdomains with `ffuf` and adds discovered ones to `/etc/hosts`.
- **Directory Fuzzing**: Allows selection between `ffuf`, `feroxbuster`, or `gobuster` for directory discovery.
- **Stylish Automation**: Includes a loading animation to show progress in operations.

## 🚀 Requirements
- **Required Tools**: Ensure the following tools are installed:
  - `rustscan`
  - `ffuf`
  - `feroxbuster`
  - `gobuster`
- **Superuser Permissions**: Some operations, like editing `/etc/hosts`, require root privileges.

## 📥 Installation
Clone the repository and navigate to the directory:
```bash
git clone https://github.com/Notlainn/HTB-Automator
cd HTB-Automator
```

## 📝 Usage
The script offers the following modes of operation:
- `all`: Runs all operations (port scan, DNS fuzzing, and directory fuzzing).
- `portscan`: Performs only the port scan.
- `dns`: Runs subdomain fuzzing.
- `fdir`: Runs directory fuzzing.

To start the script, use the following command:
```bash
./bash_automator.sh <mode>
```
**Example**:
```bash
./bash_automator.sh all
```

### Interactive Flow
1. **Target Name and IP**: The script will prompt you to enter the target's name and IP.
2. **Directory Creation**: A dedicated directory for the target will be created on the Desktop.
3. **Addition to `/etc/hosts`**: The target IP and name will be added to `/etc/hosts` (if not already present).
4. **Mode Selection**: Based on the selected mode, the script will ask if you want to proceed with each operation, adding a loading animation.

## 🔍 Execution Example
```bash
./bash_automator.sh all
```
1. Enter the target name and IP when prompted.
2. The script creates the folder on the Desktop (`/home/kali/Desktop/HTB`).
3. If `portscan` mode is selected, it runs `rustscan` on the IP.
4. If `dns` mode is selected, it performs subdomain fuzzing with `ffuf`.
5. If `fdir` mode is selected, you can choose between `ffuf`, `feroxbuster`, or `gobuster` for directory fuzzing.

## ⚙️ Configuration Example
- **Host Configuration**: The script automatically adds the `name.htb` domain and any discovered subdomains to `/etc/hosts`.
- **Ports and Patterns**: Fuzzing tools are configured to search for specific HTTP status responses (such as 200, 301, and 403).

## ⚠️ Disclaimer
This script is provided for educational purposes only and should be used ethically and responsibly.

---
