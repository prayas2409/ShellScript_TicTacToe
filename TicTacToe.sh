#!/bin/bash -x

declare -A board
BOARD_ROWS=3
BOARD_SIZE=$(($BOARD_ROWS*$BOARD_ROWS))
USER_SIGN="O"
COMP_SIGN="O"
stop=false
valid=false

function initialize_Board(){
	local key=0
	for (( key=1; key<=$BOARD_SIZE ; key++ )) do
      		board[$key]=0
      	done
}

function show_Board(){
	local count=0
	for (( count=1; count<=$BOARD_SIZE ; count++ )) do
		if [ "${board[$count]}" == "0" ]
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
		USER_SIGN="X"
	else
		COMP_SIGN="X"
	fi
	echo "Your sign is "$USER_SIGN" and computer sign is "$COMP_SIGN
}

function toss_Plays_First(){
	randomVariable=$((RANDOM%2))
	if [ $randomVariable -eq 0 ]
	then
		echo Computer plays first
		first=user
	else
		echo You play first
		first=comp
   	fi
}

function check_Valid(){
	if [ $1 -gt 0  -a $1 -le 9 ]
	then
		valid=true
	fi
	if [ "$valid" == "true" -a "${board[$1]}" == "0" ]
        then
        	board[$1]=$2
	else
		valid=false
        fi

}

function comuter_Plays(){
	while [ "$valid" == "false" ]
        do
		number=$((RANDOM%9+1))
		check_Valid $number $COMP_SIGN
	done
	valid=false
}

function take_User_Input(){
	while [ "$valid" == "false" ]
	do
		read -p "Please enter the number between 1-9 where insert your $USER_SIGN in board " input;
		check_Valid $input $USER_SIGN
		if [ "$valid" == "false" ]
		then
			echo Input not accepted please try again
		fi
	done
	valid=false
}

function send_var(){
	echo $1
	wins $1
}

function wins(){
	if [ $1 == $USER_SIGN ]
	then
		echo "You won"
	else
		echo "Computer Wins"
	fi
}

function search_Daigonal_Left_Right(){
	local count=0
	local increase_by=$((BOARD_ROWS+1))
	for (( daig_Key=1; daig_Key <= $BOARD_SIZE; daig_Key+=$increase_by )) do
		if [ ${board[$daig_Key]} == $1 ]
		then
			((count++))
		fi
	done
	if [ $count -eq $BOARD_ROWS ]
	then
		wins $1
		stop=true
	fi
}

function search_Daigonal_Right_Left(){
        local count=0
        local increase_by=$((BOARD_ROWS-1))
	local left_Bottom_Limit=$((BOARD_SIZE-BOARD_ROWS+1))
        for (( daig_Key=$BOARD_ROWS; daig_Key <= $left_Bottom_Limit; daig_Key+=$increase_by )) do
                if [ ${board[$daig_Key]} == $1 ]
                then
                        ((count++))
                fi
        done
        if [ $count == $BOARD_ROWS ]
        then
                wins $1
		stop=true
        fi
}

function search_Rows(){
	local count=0
	key=0
	for (( row=0;row<$BOARD_ROWS;row++ )) do
		count=0
		for (( col=1; col<=$BOARD_ROWS; col++ )) do
			key=$(($BOARD_ROWS*row+col ))
			if [ ${board[$key]} == $1 ]
			then
				(( count++ ))
			fi
		done
		if [ $count -eq $BOARD_ROWS ]
		then
			wins $1
			break
		fi
	done
	if [ $count -eq $BOARD_ROWS ]
	then
		stop=true
	fi
}

function search_Columns(){
        local count=0
        key=0
        for (( col=1;col<=$BOARD_ROWS;col++ )) do
                count=0
                for (( row=0; row<=$BOARD_ROWS; row++ )) do
                        key=$(($BOARD_ROWS*row+col ))
                        if [ "${board[$key]}" == "$1" ]
                        then
                                (( count++ ))
                        fi
                done
                if [ $count -eq $BOARD_ROWS ]
                then
                        wins $1
                        break

		fi
        done
        if [ $count -eq $BOARD_ROWS ]
        then
                stop=true
	fi
}

function check_Win(){
	search_Daigonal_Left_Right $1
	search_Daigonal_Right_Left $1
	search_Rows $1
	search_Columns $1
}

function play(){
	initialize_Board
	toss_Assign_Sign
	toss_Plays_First
	while [ $stop == false ]
	do
		valid=false
		show_Board
		take_User_Input
		valid=false
#		echo ${board[@]}
		check_Win $USER_SIGN
		comuter_Plays
		check_Win $COMP_SIGN
	done
	show_Board
}

play
