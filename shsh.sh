#!/bin/sh
#############################################################################
#   SHell SHortcut. Aliases directories.
#   Copyright (C) 2012  Tom Robertson, Hans-Nikolai Viessmann, Leif Gehrmann
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
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
