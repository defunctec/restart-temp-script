##!/bin/bash

# 1 hours from 9am to 11pm, converted to minutes
maxdelay=$((12*60))
for ((i=1; i<=1; i++)); do
	# pick an random delay
    delay=$(($RANDOM%maxdelay)) 
    (sleep $((delay*60)); /usr/local/bin/crown-cli restart) & # background a subshell to wait, then run the php script
done