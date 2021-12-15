#!/bin/bash

if [ $(whoami) == "root" ]; then
	echo "DONT USE SUDO PLS"
	exit 0
fi

if [ ! -d ~/research ]; then
	mkdir ~/research 2>/dev/null
fi

if [ -f ~/research/sys_info.txt ]; then
	rm -rf ~/research/sys_info.txt
fi

outPath=~/research/sys_info.txt

echo "A Quick System Audit Script" >$outPath
date >>$outPath
echo "" >>$outPath
echo "Machine Type Info:" >>$outPath
echo $MACHTYPE >>$outPath
echo -e "Uname info: $(uname -a) \n" >>$outPath
echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n" >>$outPath
echo -e "Hostname: $(hostname -s) \n" >>$outPath
echo "DNS Servers: " >>$outPath
cat /etc/resolv.conf >>$outPath
echo -e "\nMemory Info:" >>$outPath
free >>$outPath
echo -e "\nCPU Info:" >>$outPath
lscpu | grep CPU >>$outPath
echo -e "\nDisk Usage:" >>$outPath
df -H | head -2 >>$outPath
echo -e "\nWho is logged in: \n $(who -a) \n" >>$outPath
echo -e "\nExec Files:" >>$outPath
find /home -type f -perm 777 >>$outPath
echo -e "\nTop 10 Processes" >>$outPath
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >>$outPath

newVar=$(ip addr | grep inet | tail -2 | head -1)

findVar=$(find /home -type f -perm 777)

# Prints out the permissions for the files in the list "files"
files=("/etc/shadow" "/etc/passwd")
for item in "${files[@]}";
do
	echo "$(ls -l $item)"
done

echo ""

directory=$(ls /home)
for d in ${directory[@]};
do
	if [ -d /home/$d ]; then
		echo "$d: $(sudo -l -U $d | tail -1)"
	fi
done 

echo ""

cmdList=("date" "uname -a" "hostname -s")
for cmd in "${cmdList[@]}";
do
	echo "The Results of the $cmd command are: " 
	echo $($cmd)
done
