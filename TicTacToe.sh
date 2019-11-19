#!/bin/bash -x

declare -A board
BOARD_ROWS=3
BOARD_SIZE=$(($BOARD_ROWS*$BOARD_ROWS))
USER_SIGN="O"
COMP_SIGN="O"
stop=false

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
	else
		echo You play first
   	fi
}

function take_User_Input(){
	valid=false
	while [ $valid==false ]
	do
		read -p "Please enter the number between 1-9 where insert your $USER_SIGN in board" input;
		echo $input;

        	if [  $input -gt 0  -a $input -le 9 ]
		then
			valid=true
		fi
		if [ valid==true -a ${board[$input]} == 0 ]
		then
			board[$input]=$USER_SIGN
		else
			echo Input not accepted please try again
		fi
	done
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
		if [ ${board[$daig_Key]} -eq $1 ]
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
			echo $daig_Key
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
			if [ ${board[$key]}==$1 ]
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
                        if [ ${board[$key]}==$1 ]
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

#initialize_Board
#toss_Assign_Sign
#toss_Plays_First
#show_Board
#take_User_Input
#echo ${board[@]}
#search_Daigonal_Left_Right $((1))
hi=$(send_var $USER_SIGN )
echo $hi
