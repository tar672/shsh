#!/bin/sh
shsh(){
	local removeflag=0;
	while getopts r: opt
	do
		echo "$opt and $OPTARG"
		if [ "$opt" = "r" ];
		then
			sed -e "/alias $OPTARG/d" ~/.aliases > ~/.aliases.tmp;
			unalias $OPTARG;
			echo "in loop";
		fi
		removeflag=1;
	done
	if [ "$removeflag" -eq "0" ];
	then
		echo "out loop";
		TEMPALIASES=`mktemp`
		touch ~/.aliases;
		sed -e "/alias $1/d" ~/.aliases >$TEMPALIASES;
		cat $TEMPALIASES > ~/.aliases;
		STRING="alias $1='cd `pwd`'";
		eval $STRING;
		echo $STRING >> ~/.aliases;
		rm -f $TEMPALIASES;
	else
		shift $OPTIND-1;	
	fi
}
touch ~/.aliases
