#!/usr/local/bin/bash

declare -A singletDict
declare -A doubletDict
declare -A tripletDict

singletDict=( ["H"]=0 ["T"]=0 )
doubletDict=( ["HH"]=0 ["HT"]=0 ["TH"]=0 ["TT"]=0 )
tripletDict=( ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["THH"]=0 ["HTT"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 )

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
for (( flip=1; flip<=repeatitions; flip++ ))
do
		flipOut="$( coinFlip $flipOut )"
		if [[ "$flipOut" == "H" ]]
		then
				singletDict[H]=$(( ${singletDict[H]}+1 ))
		else
            singletDict[T]=$(( ${singletDict[T]}+1 ))
		fi
done

HPercent=`echo "scale=2; (${singletDict[H]}*100)/$repeatitions" | bc`
TPercent=`echo "scale=2; (${singletDict[T]}*100)/$repeatitions" | bc`

}

# function for doublet coin flip
function doublet(){

for (( flip=1; flip<=repeatitions; flip++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" ]]
		then
				doubletDict[HH]=$(( ${doubletDict[HH]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" ]]
		then
				doubletDict[HT]=$(( ${doubletDict[HT]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" ]]
		then
				doubletDict[TH]=$(( ${doubletDict[TH]}+1 ))
		else
				doubletDict[TT]=$(( ${doubletDict[TT]}+1 ))
		fi
done

HHPercent=`echo "scale=2; (${doubletDict[HH]}*100)/$repeatitions" | bc`
HTPercent=`echo "scale=2; (${doubletDict[HT]}*100)/$repeatitions" | bc`
THPercent=`echo "scale=2; (${doubletDict[TH]}*100)/$repeatitions" | bc`
TTPercent=`echo "scale=2; (${doubletDict[TT]}*100)/$repeatitions" | bc`

}

# function for doublet coin flip
function triplet(){

for (( flip=1; flip<=repeatitions; flip++ ))
do
		flipOne="$( coinFlip $flipOut )"
		flipTwo="$( coinFlip $flipOut )"
		flipThree="$( coinFlip $flipOut )"

		if [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[HHH]=$(( ${tripletDict[HHH]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[HHT]=$(( ${tripletDict[HHT]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
 				tripletDict[HTH]=$(( ${tripletDict[HTH]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "H" ]]
		then
				tripletDict[THH]=$(( ${tripletDict[THH]}+1 ))
		elif [[ "$flipOne" == "H" && "$flipTwo" == "T" && "$flipThree" == "T" ]]
		then
				tripletDict[HTT]=$(( ${tripletDict[HTT]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "H" && "$flipThree" == "T" ]]
		then
				tripletDict[THT]=$(( ${tripletDict[THT]}+1 ))
		elif [[ "$flipOne" == "T" && "$flipTwo" == "T" && "$flipThree" == "H" ]]
		then
				tripletDict[TTH]=$(( ${tripletDict[TTH]}+1 ))
		else
				tripletDict[TTT]=$(( ${tripletDict[TTT]}+1 ))
		fi
done

HHHPercent=`echo "scale=2; (${tripletDict[HHH]}*100)/$repeatitions" | bc`
HHTPercent=`echo "scale=2; (${tripletDict[HHT]}*100)/$repeatitions" | bc`
HTHPercent=`echo "scale=2; (${tripletDict[HTH]}*100)/$repeatitions" | bc`
THHPercent=`echo "scale=2; (${tripletDict[THH]}*100)/$repeatitions" | bc`
HTTPercent=`echo "scale=2; (${tripletDict[HTT]}*100)/$repeatitions" | bc`
THTPercent=`echo "scale=2; (${tripletDict[THT]}*100)/$repeatitions" | bc`
TTHPercent=`echo "scale=2; (${tripletDict[TTH]}*100)/$repeatitions" | bc`
TTTPercent=`echo "scale=2; (${tripletDict[TTT]}*100)/$repeatitions" | bc`
				
}


singlet
#loop to display singlet dictionary 
echo "~~~~~displaying singlet~~~~~"

for key in "${!singletDict[@]}"
do
		echo "$key": "${singletDict[$key]}"
done

echo "percentage of singlet heads: $HPercent%"
echo "percentage of singlet tails: $TPercent%"

#winning combinations
echo -n "The winning combination is: "
for i in ${!singletDict[@]}
	do
		echo "$i: ${singletDict[$i]}"
	done | sort -k2 -rn | head -1

doublet
#loop to display doublet dictionary
echo "~~~~~displaying doublet~~~~~"

for key in "${!doubletDict[@]}"
do
		echo "$key": "${doubletDict[$key]}"
done

echo "percentage of doublet HH: $HHPercent%"
echo "percentage of doublet HT: $HTPercent%"
echo "percentage of doublet TH: $THPercent%"
echo "percentage of doublet TT: $TTPercent%"

#winning combinations
echo -n "The winning combination is: "
for i in ${!doubletDict[@]}
	do
		echo "$i: ${doubletDict[$i]}"
	done | sort -k2 -rn | head -1

triplet
#loop to display triplet dictionary
echo "~~~~~displaying triplet~~~~~"
for key in "${!tripletDict[@]}"
do
		echo "$key": "${tripletDict[$key]}"
done

echo "percentage of triplet HHH: $HHHPercent%"
echo "percentage of triplet HHT: $HHTPercent%"
echo "percentage of triplet HTH: $HTHPercent%"
echo "percentage of triplet THH: $THHPercent%"
echo "percentage of triplet HTT: $HTTPercent%"
echo "percentage of triplet THT: $THTPercent%"
echo "percentage of triplet TTH: $TTHPercent%"
echo "percentage of triplet TTT: $TTTPercent%"

#winning combinations
echo -n "The winning combination is: "
for i in ${!tripletDict[@]}
	do
		echo "$i: ${tripletDict[$i]}"
	done | sort -k2 -rn | head -1
