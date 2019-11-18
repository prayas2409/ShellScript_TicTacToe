#!/bin/bash

declare -A board
BOARD_ROWS=3
BOARD_SIZE=$(($BOARD_ROWS*$BOARD_ROWS))

function initialize_Board(){
	for (( key=1; key<=$BOARD_SIZE ; key++ )) do
      		board["$key"]=0
      	done
}
function show_Board(){

	for (( row=1; row<4 ; row++ )) do
	   	for (( column=1; column<4 ; column++ )) do
			if [ ${board[$row,$column]}==0 ]
         		then
				printf  _" "
        		else
				printf ${board[$row,$column]}" "
         		fi
		done
   		echo
	done
}

function toss_Assign_Sign(){
	randomVariable=$((RANDOM%2))
	if [ $randomVariable -eq 0 ]
	then
		USER_SIGN=X
	else
		COMP_SIGN=X
	fi
	echo "Your sign is "$USER_SIGN" and computer sign is "$COMP_SIGN
}

function toss_Plays_First(){
	randomVariable=$((RANDOM%2))
	if [ $randomVariable -eq 0 ]
	then
		echo Computer plays first
	else
		echo You play first
   	fi
}

function take_User_Input(){
	read -p "Please enter the number between 1-9 where insert your $USER_SIGN in board" input;
	echo $input "hi";

        if [  $input -gt 0  -a $input -le 9 ]
	then
		echo valid input
	else
		echo invalid input
	fi
}


initialize_Board
toss_Assign_Sign
toss_Plays_First
show_Board
take_User_Input

