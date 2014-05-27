#!/bin/bash

##################################################
#
# DEFAULT CONFIGURATION VARIABLES
# also, your mom
#
##################################################

hashcatbin=/opt/hashcat/oclHashcat-1.20/oclHashcat32.bin
rulesfolder=/opt/hashcat/oclHashcat-1.20/rules/
mywordlist=/opt/wordlists/sorted.txt
myhashfile=

mymaxmasklength=7
mymaskcharset="ulds"


##################################################
#
# MISCELLANEOUS FUNCTIONS
# also, your mom
#
##################################################

f_Quit(){
	echo -e "\n\n\e[1;31mHave a nice day\e[0m\n"
	sleep 0
	exit 2> /dev/null
}

##################################################
f_Banner(){

echo "bashcat. oclHashcat for huams."
echo

}

##################################################
f_sethashcatbin(){
	clear
	echo "Current binary set to:"
	echo $hashcatbin

	read -p "New location: " newhashcatbin

	hashcatbin=$newhashcatbin

	clear
	f_prereqs
}

##################################################
f_sethashfile(){
	clear
	echo "Current hash file set to:"
	echo $myhashfile

	read -p "New location: " newmyhashfile

	myhashfile=$newmyhashfile

	clear
	f_prereqs

}


##################################################
# DAT MULTI RULE TAK
##################################################
f_multirulesetup(){
	clear

	echo "Multi Rules Setup"
	echo
	echo "1.  Set rules folder"
	echo "    [$rulesfolder]"
	echo
	echo "2.  Set word list"
	echo "    [$mywordlist]"
	echo 
	echo "3.  GO GO GADGET CRACK-A-LACK"
	echo 
	echo "4.  Previous Menu"
	echo
	read -p "Choice: " multirulesetupchoice

	case $multirulesetupchoice in
	1) f_setrulesfolder ;;
	2) f_setwordlist ;;
	3) f_multiruleattack ;;
	4) f_mainmenu ;;
	*) f_multirulesetup ;;
	esac

}

##################################################
f_setrulesfolder(){
	clear
	echo "Current rules folder set to:"
	echo $rulesfolder

	read -p "New location: " newrulesfolder
	rulesfolder=$newrulesfolder

	clear
	f_prereqs

}

##################################################
f_setwordlist(){
	clear
	echo "Current wordlist set to:"
	echo $mywordlist

	read -p "New wordlist: " newmywordlist
	mywordlist=$newmywordlist

	clear
	f_prereqs
}

f_multiruleattack(){
RULES=$rulesfolder*.rule
for f in $RULES
do
  echo "Running rule $f..."
  $hashcatbin -a0 -m0 -r $f $myhashfile $mywordlist
done
}

##################################################
# DAT MASK TAK
##################################################
f_maskattacksetup(){
	clear

	echo "Mask Attack Setup"
	echo
	echo "1.  Set max password attempt length"
	echo "    [$mymaxmasklength]"
	echo
	echo "2.  Setup characterset"
	echo "    [$mymaskcharset]"
	echo 
	echo "3.  GO GO GADGET CRACK-A-LACK"
	echo 
	echo "4.  Previous Menu"
	echo
	read -p "Choice: " maskattacksetupchoice

	case $maskattacksetupchoice in
	1) f_setmaxmasklength ;;
	2) f_setmaskcharset ;;
	3) f_maskattack ;;
	4) f_mainmenu ;;
	*) f_maskattacksetup ;;
	esac
}

f_setmaxmasklength(){
	clear
	echo "Current password mask length:"
	echo $mymaxmasklength

	read -p "New length(1-55): " newmymaxmasklength
	mymaxmasklength=$newmymaxmasklength

	clear
	f_maskattacksetup
}

f_setmaskcharset(){
	clear
	echo "Current password mask character set:"
	echo $mymaskcharset
	echo "Valid options are"
	echo "(u)pper case"
	echo "(l)ower case"
	echo "(d)igits"
	echo "(s)pecial"
	echo "Options can be combined (lusd) one of each"
	read -p "New character set: " newmymaskcharset
	mymaskcharset=$newmymaskcharset

	clear
	f_maskattacksetup
}

f_maskattack(){
	echo
}

##################################################
f_halp(){
	clear

	echo "<insert muscletwins intro here>"
	read -p "Press enter to return to main menu." lolnull

	clear
	f_mainmenu
}

##################################################
f_prereqs(){
	clear

	echo "CHECK YO CONFIGURATIONS"
	echo
	echo "1.  Set oclHashcat binary"
	echo "    [$hashcatbin]"
	echo 
	echo "2.  Set hash file"
	echo "    [$myhashfile]"
	echo 
	echo "3.  Previous Menu"
	echo
	read -p "Choice: " prereqschoice

	case $prereqschoice in
	1) f_sethashcatbin ;;
	2) f_sethashfile ;;
	3) f_mainmenu ;;
	*) f_prereqs ;;
	esac

}

##################################################
f_mainmenu(){
	clear
	f_Banner

	echo 
	echo "Hashcat binary: $hashcatbin"
	echo "Hashcat rules: $rulesfolder"
	echo "Word list: $mywordlist"
	echo "Hash file: $myhashfile"
	echo 

	echo "1.  Prerequisites & Configurations"
	echo "2.  Multi-Rule attack"
	echo "3.  Simple Mask Attack (bruteforce++)"
	echo "4.  Halp"
	echo "Q.  Quit bashcat session"
	echo
	read -p "Choice: " mainchoice

	case $mainchoice in
	1) f_prereqs ;;
	2) f_multirulesetup ;;
	3) f_maskattacksetup ;;
	4) f_halp ;;
	Q|q) f_Quit ;;
	*) f_mainmenu ;;
	esac
}

f_mainmenu
