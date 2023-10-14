#!/bin/bash


###############
## NOTE !!! ###
###############

# PASSWORDS CANNOT CONTAIN COMMAS!

# create a temporary users.txt file to change passwords.
sed 's/,/:/g' users.csv > users.txt

# Read recursively add users according to the $USER name from our csv
while IFS=',' read USER PASSWD; do useradd -m $USER; done < users.csv

# Once the user accounts are created, we can change the passwords
chpasswd < users.txt
