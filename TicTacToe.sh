#!/bin/bash

declare -A board
BOARD_ROWS=3
BOARD_SIZE=$(($BOARD_ROWS*$BOARD_ROWS))

function initialize_Board()
for (( key=1; key<$BOARD_SIZE ; key++ )) do
      board["$key"]=0
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
