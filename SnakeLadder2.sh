#!/bin/bash
echo "Game begins"
echo "1) Player cannot move 2) Player is found a ladder 2) Player will found a snake"
start=0
pos1=0
pos2=0

player_turn=1

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
		echo Player is not playing
		 if [[ $player_turn -eq 1 ]]
		then
			pos1=$pos1
		else
			pos2=$pos2
		fi
		;;
	2)
		echo " You got Ladder"
		if [[ $player_turn -eq 1 ]]
		then
	
			pos1=$(($pos1 + $dice))
	
			#Ensure Winning postion
			#if postion is above hundred, player stay still or postion is win position
			if [[ $pos1 -gt $win_pos ]]
			then
				pos1=$(($pos1 - $dice))
			elif [[ $pos1 -eq $win_pos ]]
			then
				echo Player1 Wins
				echo Position of player 2 is: $pos2
				exit
			else
				echo Postion of Player1 is: $pos1

			fi
		else
			pos2=$(($pos2 + $dice))
        
                        #Ensure Winning postion
                        #if postion is above hundred, player stay still or postion is win position
                        if [[ $pos2 -gt $win_pos ]]
                        then
                                pos2=$(($pos2 - $dice))
                        elif [[ $pos2 -eq $win_pos ]]
                        then
                                echo Player2 Wins
				echo player of position 1 is: $pos1
				exit
                        else
                        	echo Postion of Player2 is: $pos2

                        fi

		fi
		;;
	3)
		echo "Its Snake"
		if [[ $player_turn -eq 1 ]]
		then
			pos1=$(($pos1-$dice))
		
			#if postion is less than 0 then set the postion back to start postion or position is win postion
			if [[ $pos1 -lt $start ]]
			then
				pos1=$start
			elif [[ $pos1 -eq $win_pos ]]
		        then
		    		echo Postion of Player2 is: $pos2
				echo Player win
				exit
			else
				echo Postion of Player1 is: $pos1

			fi
		else
			 pos2=$(($pos2-$dice))

                        #if postion is less than 0 then set the postion back to start postion or position is win postion
                        if [[ $pos2 -lt $start ]]
                        then
                                pos2=$start
                        elif [[ $pos2 -eq $win_pos ]]
                        then
                                echo Postion of Player1 is: $pos1
                                echo Player win
				exit
                        else
                                echo Postion of Player2 is: $pos2

                        fi

		fi
		;;
	esac
}

playerturn()
{
	
	if [[ $player_turn -eq 1 ]]
	then
		echo "Player1 turn"
		player_turn=2
	else
		echo "Player2 turn"
		player_turn=1
	fi
}

while [[ $pos1 -lt $win_pos && $pos2 -lt $win_pos ]]
do
	roll
	echo "----------------------------------------------------------------------------------------------------------------------------"
	playerturn
	
done
echo "Total count of dice rolled to win is: $dice_count"
