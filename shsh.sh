#!/bin/sh
shsh(){
	local removeflag=0;
	TEMPALIASES=`mktemp`;
	while getopts r: opt
	do
		if [ "$opt" = "r" ];
		then
			sed -e "/alias $OPTARG/d" ~/.aliases > $TEMPALIASES;
			unalias $OPTARG;
			cat $TEMPALIASES > ~/.aliases;
		fi
		removeflag=1;
	done
	if [ "$removeflag" -eq "0" ];
	then
		touch ~/.aliases;
		sed -e "/alias $1/d" ~/.aliases >$TEMPALIASES;
		cat $TEMPALIASES > ~/.aliases;
		STRING="alias $1='cd `pwd`'";
		eval $STRING;
		echo $STRING >> ~/.aliases;
		rm -f $TEMPALIASES;
	else
		export OPTIND=1;
	fi
}
touch ~/.aliases
