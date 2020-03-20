#!/usr/local/bin/bash

randOut=$(( RANDOM%2 ))

if [[ $randOut -eq 0 ]]
then
		echo "heads"
else
		echo "tails"
fi
