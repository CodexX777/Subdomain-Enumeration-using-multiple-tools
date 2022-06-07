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
echo "Do you want to use nuclei on the resultant list ? [ 1 - Yes/0 - No ] "
echo
read nuke
echo
echo "Enter 1 for custom settings of each tool (Enter 0 for default settings)"
read settings

if [ $settings == 1 ];
then
	echo ""
	echo "Enter Flags for each tool eg: '-v -a -s' without quotes"
	echo ""
	echo "(!!! Dont enter domain and output flags !!!)"
	echo ""
	declare -a tools=( Findomain subfinder sublist3r amass nuclei )
	declare -a flags
	for i in {0..4}
	do
		echo "Flag for " ${tools[i]} " : "
		read flag
		flags[i]=$flag
	done
	echo ""

	findomain ${flags[0]} -t $Domain --output
	subfinder ${flags[1]} -d $Domain >codexxtmp1.txt
	sublist3r ${flags[2]} -d $Domain -o codexxtmp2.txt
	amass enum ${flags[3]} -d $Domain -o codexxtmp3.txt

else
	findomain -t $Domain --output
	subfinder -d $Domain >codexxtmp1.txt
	sublist3r -d $Domain -o codexxtmp2.txt
	amass enum -d $Domain -o codexxtmp3.txt
fi

cat $Domain.txt codexxtmp1.txt codexxtmp2.txt codexxtmp3.txt >codexxtmp4.txt
rm $Domain.txt codexxtmp1.txt codexxtmp2.txt codexxtmp3.txt
sort -u codexxtmp4.txt > $Domain.txt
rm codexxtmp4.txt
httprobe < $Domain.txt > alive.$Domain.txt
if [ $nuke == 1 ];then
	if [ $settings == 1 ];then
		nuclei ${flags[4]} -l alive.$Domain.txt -o nuclei.$Domain.txt
	else
		nuclei -l alive.$Domain.txt -o nuclei.$Domain.txt
	fi
fi
echo "Results stored in $Domain.txt and alive.$Domain.txt in the current directory."
echo ""
echo "Nuclei results stored in nuclei.$Domain.txt file"
echo 
echo "Enjoy !!!"

