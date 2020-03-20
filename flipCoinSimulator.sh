#!/usr/local/bin/bash

declare -A singletDict
declare -A doubletDict
declare -A tripletDict

singletDict=( ["HCount"]=0 ["TCount"]=0 )
doubletDict=( ["HHCount"]=0 ["HTCount"]=0 ["THCount"]=0 ["TTCount"]=0 )
tripletDict=( ["HHHCount"]=0 ["HHTCount"]=0 ["HTHCount"]=0 ["THHCount"]=0 ["HTTCount"]=0 ["THTCount"]=0 ["TTHCount"]=0 ["TTTCount"]=0 )

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

# function for doublet coin flip
function triplet(){

for (( flipCount=1; flipCount<=repeatitions; flipCount++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"
		flipThree="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[HHHCount]=$(( ${tripletDict[HHHCount]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[HHTCount]=$(( ${tripletDict[HHTCount]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
 				tripletDict[HTHCount]=$(( ${tripletDict[HTHCount]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[THHCount]=$(( ${tripletDict[THHCount]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "T" ]]
		then
				tripletDict[HTTCount]=$(( ${tripletDict[HTTCount]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[THTCount]=$(( ${tripletDict[THTCount]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
				tripletDict[TTHCount]=$(( ${tripletDict[TTHCount]}+1 ))
		else
				tripletDict[TTTCount]=$(( ${tripletDict[TTTCount]}+1 ))
		fi
done

HHHPercent=`echo "scale=2; (${tripletDict[HHHCount]}*100)/$repeatitions" | bc`
HHTPercent=`echo "scale=2; (${tripletDict[HHTCount]}*100)/$repeatitions" | bc`
HTHPercent=`echo "scale=2; (${tripletDict[HTHCount]}*100)/$repeatitions" | bc`
THHPercent=`echo "scale=2; (${tripletDict[THHCount]}*100)/$repeatitions" | bc`
HTTPercent=`echo "scale=2; (${tripletDict[HTTCount]}*100)/$repeatitions" | bc`
THTPercent=`echo "scale=2; (${tripletDict[THTCount]}*100)/$repeatitions" | bc`
TTHPercent=`echo "scale=2; (${tripletDict[TTHCount]}*100)/$repeatitions" | bc`
TTTPercent=`echo "scale=2; (${tripletDict[TTTCount]}*100)/$repeatitions" | bc`
				
}


singlet
echo "percentage of singlet heads: $HPercent%"
echo "percentage of singlet tails: $TPercent%"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
doublet

echo "percentage of doublet HH: $HHPercent%"
echo "percentage of doublet HT: $HTPercent%"
echo "percentage of doublet TH: $THPercent%"
echo "percentage of doublet TT: $TTPercent%"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

triplet
echo "percentage of triplet HHH: $HHHPercent%"
echo "percentage of triplet HHT: $HHTPercent%"
echo "percentage of triplet HTH: $HTHPercent%"
echo "percentage of triplet THH: $THHPercent%"
echo "percentage of triplet HTT: $HTTPercent%"
echo "percentage of triplet THT: $THTPercent%"
echo "percentage of triplet TTH: $TTHPercent%"
echo "percentage of triplet TTT: $TTTPercent%"
