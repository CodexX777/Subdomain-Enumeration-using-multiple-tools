#! /usr/bin/bash

#You can add other tools by just adding their commands at the respective places

#And dont forget to add it on the tools and flags array and also increasing the for loop iterator

#Written by CodexX github : https://github.com/CodexX777/Bug-hunting-Automation-Scripts/


figlet "CodexX"
echo ""
echo "Hack Wisely !!"
echo ""
echo "Enter the Domain you want to enumerate : "
echo ""
read Domain
echo ""
echo "Enter 1 for custom settings of each tool (Enter 0 for default settings)"
read settings

if [ $settings == 1 ];
then
	echo ""
	echo "Enter Flags for each tool eg: '-v -a -s' without quotes"
	echo ""
	echo "(!!! Dont enter domain and output flags !!!)"
	echo ""
	declare -a tools=( Findomain subfinder sublist3r amass )
	declare -a flags
	for i in {0..3}
	do
		echo "Flag for " ${tools[i]} " : "
		read flag
		flags[i]=$flag
	done
	echo ""

	findomain ${flags[0]} -t $Domain --output
	subfinder ${flags[1]} -d $Domain >sub2.txt
	sublist3r ${flags[2]} -d $Domain -o sub3.txt
	amass enum ${flags[3]} -d $Domain -o sub4.txt

else
	findomain -t $Domain --output
	subfinder -d $Domain >sub2.txt
	sublist3r -d $Domain -o sub3.txt
	amass enum -d $Domain -o sub4.txt
fi

cat $Domain.txt sub2.txt sub3.txt sub4.txt >sub.txt
rm $Domain.txt sub2.txt sub3.txt sub4.txt
sort -u sub.txt > $Domain.txt
rm sub.txt
httprobe < $Domain.txt > alive.$Domain.txt

echo "Results stored in $Domain.txt and alive.$Domain.txt in the current directory."
echo ""
echo "Enjoy !!!"

