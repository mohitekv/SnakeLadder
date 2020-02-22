#!/bin/bash  
#Assiging Values to the Variables
echo "Game begins"
echo "1) Player cannot move 2) Player is found a ladder 2) Player will found a snake"
start=0
player_pos=0
check_option=0
number_disc=0
win_pos=100
dice_count=0
player_turn=1

#Function to roll the disc between 1 to 6
roll()
{
	dice=$((RANDOM%6+1))
	dice_count=$(($dice_count+1))
	checkPosition
	
}

#Function to check Postion of the player
#1) for no play, 2) for ladder move and 3) for Snake move
checkPosition()
{
	check_option=$((RANDOM%3+1))
	case $check_option in
	1)
		player_pos=$player_pos
		;;
	2)
		player_pos=$(($player_pos + $dice))

		#Ensure Winning postion
		#if postion is above hundred, player stay still or postion is win position
		if [[ $player_pos -gt $win_pos ]]
		then
			player_pos=$(($player_pos - $dice))
		elif [[ $player_pos -eq $win_pos ]]
		then
		    echo Postion of Player is: $player_pos
			echo Player Wins
		else
			echo Postion of Player is: $player_pos

		fi
		;;
	3)
		player_pos=$(($player_pos-$dice))
		
		#if postion is less than 0 then set the postion back to start postion or position is win postion
		if [[ $player_pos -lt $start ]]
		then
			player_pos=$start
		elif [[ $player_pos -eq $win_pos ]]
            then
		    echo Postion of Player is: $player_pos
			echo Player win
		else
			echo Postion of Player is: $player_pos

		fi
		;;
	esac
}

#Iterate the game till player reaches win_pos
while [ $player_pos -lt $win_pos ]
do
	roll
done
echo "Total count of dice rolled to win is: $dice_count"
