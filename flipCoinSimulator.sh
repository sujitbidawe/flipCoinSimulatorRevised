#!/usr/local/bin/bash

declare -A singletDict

singletDict=( ["HCount"]=0 ["TCount"]=0 )

read -p "how many times do you want to flip the coin: " repeatitions

# function to flip the coin
function coinFlip() {

		if [[ $(( RANDOM%2 )) -eq 0 ]]
		then
				flipOut=H
		else
				flipOut=T
		fi
echo $flipOut
}

# function for singlet coin flip
function singlet(){
for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOut="$( coinFlip $flipOut )"
		if [[ "$flipOut" == "H" ]]
		then
				singletDict[HCount]=$(( ${singletDict[HCount]}+1 ))
		else
            singletDict[TCount]=$(( ${singletDict[TCount]}+1 ))
		fi
done

HPercent=`echo "scale=2; (${singletDict[HCount]}*100)/$repeatitions" | bc`
TPercent=`echo "scale=2; (${singletDict[TCount]}*100)/$repeatitions" | bc`

}

singlet
echo "percentage of singlet heads: $HPercent%"
echo "percentage of singlet tails: $TPercent%"

