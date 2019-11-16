#!/bin/bash

declare -A board
board_Size=3
USER_SIGN=0
COMP_SIGN=0

function initialize_Board()
for (( row=1; row<4 ; row++ )) do
      for (( column=1; column<4 ; column++ )) do
#         read var
			board[$row,$column]=0
      done
done

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
	if [ $((RANDOM%2))==1 ]
	then
			USER_SIGN=X
	else
			COMP_SIGN=X
	fi
	echo "Your sign is "$USER_SIGN" and computer sign is "$COMP_SIGN
}

initialize_Board
toss_Assign_Sign
show_Board
