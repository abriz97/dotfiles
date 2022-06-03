#!/bin/bash
# Run this script to move the contents of this git repository
# to the desired locations

# Uncomment below line to overwrite existing files
OVERWRITE=TRUE 

########################
# Copy personal scripts
########################

SCRIPTS=$HOME/.scripts

if [ ! -d "$SCRIPTS" ];
then
        mkdir $SCRIPTS
fi

for filename in .scripts/* ; do
        if [ ! -f $filename ] || [ ! -z $OVERWRITE ]; then
               cp $filename $HOME/.scripts
        fi
done


############################
# Copy files in .config dir 
############################

if [ ! -d "$HOME/.config" ] ;
then
        mkdir $HOME/.config
fi

for filename in .config/* ; do
        if [ ! -f $filename ] || [ ! -z $OVERWRITE ] ; then
               cp -r $filename $HOME/.config
        fi
done

##########################
# Copy .vim directory
##########################

if [ ! -d "$HOME/.vim" ] ;
then
        mkdir $HOME/.vim
fi

for filename in .vim/* ; do
        if [ ! -f $filename ] || [ ! -z $OVERWRITE ] ; then
               cp -r $filename $HOME/.vim
        fi
done

##########################
# Copy remaining dotfiles 
##########################

for filename in .*; do
        if [ ! -f $filename ] || [ ! -z $OVERWRITE ] ; then
               cp $filename $HOME
        fi
done

