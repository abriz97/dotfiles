!/bin/sh
# Run this script to move the contents of this git repository
# to the desired locations

# Uncomment below line to overwrite existing files
# OVERWRITE=TRUE 

########################
# Copy personal scripts
########################

SCRIPTS=$HOME/.scripts

if [ ! -d "$SCRIPTS" ];
then
        mkdir $SCRIPTS
fi

for filename in .scripts/*; do
        if [ ! -f $filename || -z $OVERWRITE ]; then
               cp $filename $SCRIPTS/$filename 
        fi
done


############################
# Copy files in .config dir 
############################

if [ ! -d "$HOME/.config"];
then
        mkdir $HOME/.config
fi

for filename in .config/*; do
        if [ ! -f $filename || -z $OVERWRITE ]; then
               cp $filename $HOME/.config/$filename 
        fi
done


##########################
# Copy remaining dotfiles 
##########################

for filename in .config/.*; do
        if [ ! -f $filename || -z $OVERWRITE ]; then
               cp $filename $HOME/.config/$filename 
        fi
done

