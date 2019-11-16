#!/bin/bash

declare -A board
board_Size=3

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

initialize_Board
show_Board
