#!/bin/bash -x

declare -A board
BOARD_ROWS=3
BOARD_SIZE=$(($BOARD_ROWS*$BOARD_ROWS))
USER_SIGN="O"
COMP_SIGN="O"

function initialize_Board(){
	for (( key=1; key<=$BOARD_SIZE ; key++ )) do
      		board[$key]=0
      	done
}

function show_Board(){

	for (( count=1; count<=$BOARD_SIZE ; count++ )) do
		if [ ${board[$count]} -eq 0 ]
         	then
			printf  _" "
        	else
			printf ${board[$count]}" "
         	fi
		if [ $(( $count % $BOARD_ROWS )) -eq 0 ]
		then
			echo
		fi
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

function send_var(){
	wins $(( $1 ))
}

function wins(){
	if [ $1 -eq $USER_SIGN ]
	then
		echo "You won"
	else
		echo "Computer Wins"
	fi
}

function search_Daigonal_Left_Right(){
	local count=0
	local increase_by=$((BOARD_ROWS+1))
	for (( daig_key=1; daig_key <= $BOARD_SIZE; daig_key+=$increase_by )) do
		if [ ${board[$daig_key]} -eq $1 ]
		then
			((count++))
		fi
	done
	if [ $count -eq $BOARD_ROWS ]
	then
		wins $(($1))
		echo 1
	else
		echo 0
	fi
}

function check_Win(){
	for ((column=1; column<=$BOARD_ROWS; column++ )) do
		local count_row=0
		local count_col=0
		local count_daig_left_right=0
		local count_daig_right_left=0
		local row_key=$column
		local daig_L_R_Key=$column
		local daig_R_L_Key=$column
		local collumn_key=$column
		for (( count=1; count<$BOARD_ROWS; count++)) do
			if [ $column -eq 1  -o  $column -eq $BOARD_ROWS ]
			then
				if [ $board[$row_key] -eq $1  ]
				then
				(( count_row++ ))
				fi

			fi

		done
	done
}

initialize_Board
toss_Assign_Sign
toss_Plays_First
show_Board
take_User_Input
echo ${board[@]}
search_Daigonal_Left_Right $((1))
send_var $(($USER_SIGN))
