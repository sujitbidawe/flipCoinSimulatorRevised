#!/usr/local/bin/bash

declare -A singletDict
declare -A doubletDict

singletDict=( ["HCount"]=0 ["TCount"]=0 )
doubletDict=( ["HHCount"]=0 ["HTCount"]=0 ["THCount"]=0 ["TTCount"]=0 )

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

# function for doublet coin flip
function doublet(){

for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" ]]
		then
				doubletDict[HHCount]=$(( ${doubletDict[HHCount]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" ]]
		then
				doubletDict[HTCount]=$(( ${doubletDict[HTCount]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" ]]
		then
				doubletDict[THCount]=$(( ${doubletDict[THCount]}+1 ))
		else
				doubletDict[TTCount]=$(( ${doubletDict[TTCount]}+1 ))
		fi
done

HHPercent=`echo "scale=2; (${doubletDict[HHCount]}*100)/$repeatitions" | bc`
HTPercent=`echo "scale=2; (${doubletDict[HTCount]}*100)/$repeatitions" | bc`
THPercent=`echo "scale=2; (${doubletDict[THCount]}*100)/$repeatitions" | bc`
TTPercent=`echo "scale=2; (${doubletDict[TTCount]}*100)/$repeatitions" | bc`

}


singlet
echo "percentage of singlet heads: $HPercent%"
echo "percentage of singlet tails: $TPercent%"

doublet
echo "percentage of doublet HH: $HHPercent%"
echo "percentage of doublet HT: $HTPercent%"
echo "percentage of doublet TH: $THPercent%"
echo "percentage of doublet TT: $TTPercent%"

