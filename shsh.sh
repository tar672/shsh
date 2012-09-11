#!/bin/sh
shsh(){
        while getopts ":r" opt; do
         if [ "$opt" -eq "r" ]; then
            sed -e "/alias $1/d" ~/.aliases >~/.aliases.tmp;
            return
         fi
        done
        touch ~/.aliases.tmp;
        touch ~/.aliases;
        sed -e "/alias $1/d" ~/.aliases >~/.aliases.tmp;
        cat ~/.aliases.tmp > ~/.aliases;
        pwdstring=`pwd`;
        STRING="alias $1='cd $pwdstring'";
        eval $STRING;
        echo $STRING >> ~/.aliases;
        rm ~/.aliases.tmp;
}
touch ~/.aliases
