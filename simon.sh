#!/bin/bash                                                                                                             
                                                                                                                        
#TODO Make difficulties wherein you have a descending amount of time viewing the colors.                                
#TODO Use arrays to handle multiple high scores, max of 10, sorted.                                                     
#TODO Convert printf statements to use varibles properly.                                                               
red=$(tput setaf 1)                                                                                                     
green=$(tput setaf 2)                                                                                                   
yellow=$(tput setaf 3)                                                                                                  
blue=$(tput setaf 6)                                                                                                    
norm=$(tput sgr0)                                                                                                       
totalG=""                                                                                                               
totalInp=""                                                                                                             
score=""                                                                                                                
pass="yes"                                                                                                              
printf "Welcome to Simon. I wil be flashing colors on the screen and you'll have to memorize it and repeat it back to me
. Write the answers with either the first letter of the color or the full color name, with either no spaces or just one.
\n"                                                                                                                     
read -n 1 -s -p "Press any key to continue."; printf "\n"                                                               
#Establish while loop that breaks on wrong answer.                                                                      
while [[ "$pass" == "yes" ]]; do rand=$(shuf -i 1-4 -n 1)                                                               
    #Choose what the next color.                                                                                        
    if [[ rand -eq 1 ]]; then                                                                                           
        totalG="$totalG$rand"                                                                                           
        rand="${red}red${norm}"                                                                                         
        curr="$curr""red"                                                                                               
        currFirst="$currFirst""r"                                                                                       
        if [ -z "$totalGVisual" ]; then #These are so there isn't a space infront of the first color.                   
            totalGVisual="$rand"                                                                                        
            else                                                                                                        
                totalGVisual="$totalGVisual $rand"                                                                      
        fi                                                                                                              
        elif [[ rand -eq 2 ]]; then                                                                                     
            totalG="$totalG$rand"                                                                                       
            rand="${blue}blue${norm}"                                                                                   
            curr="$curr""blue"                                                                                          
            currFirst="$currFirst""b"                                                                                   
            if [ -z "$totalGVisual" ]; then                                                                             
                totalGVisual="$rand"                                                                                    
                else                                                                                                    
                    totalGVisual="$totalGVisual $rand"                                                                  
            fi                                                                                                          
        elif [[ rand -eq 3 ]]; then                                                                                     
            totalG="$totalG$rand"                                                                                       
            rand="${green}green${norm}"                                                                                 
            curr="$curr""green"                                                                                         
            currFirst="$currFirst""g"                                                                                   
            if [ -z "$totalGVisual" ]; then                                                                             
                totalGVisual="$rand"                                                                                    
                else                                                                                                    
                    totalGVisual="$totalGVisual $rand"                                                                  
            fi                                                                                                          
        elif [[ rand -eq 4 ]]; then                                                                                     
            totalG="$totalG$rand"                                                                                       
            rand="${yellow}yellow${norm}"                                                                               
            curr="$curr""yellow"                                                                                        
            currFirst="$currFirst""y"                                                                                   
            if [ -z "$totalGVisual" ]; then                                                                             
                totalGVisual="$rand"                                                                                    
                else                                                                                                    
                    totalGVisual="$totalGVisual $rand"                                                                  
            fi                                                                                                          
        else                                                                                                            
            printf "Broken rand elif somehow"                                                                           
            exit                                                                                                        
    fi                                                                                                                  
    #Now that we've established the next random color, show it to the player and get their inputs                       
    printf "$totalGVisual\n"                                                                                            
    sleep 1                                                                                                             
    clear                                                                                                               
ly for >1 comparisions from now on.                                                                                     
    #Wrap the case in a while loop so I can retry user prompt if their input is invalid.                                
    while [[ "$pass" == "yes" ]]; do                                                                                    
        read -e -r -p "What are the colors? " inp; inp=$( echo -e "$inp" | tr -d '[:space:]')                           
        inp=${inp//blue/b}; inp=${inp//red/r}; inp=${inp//yellow/y}; inp=${inp//green/g}                
        case $inp in                                                                                                    
            "$curr"|"$currFirst")                                                                                       
                totalInp="$totalInp$inp"                                                                                
                printf "Correct, you typed $inp.\n"                                                                     
                score=$((score+1))                                                                                      
                break                                                                                                   
                ;;                                                                                                      
            *) printf "You lose! The correct answer was $totalGVisual\n"                                                
                pass="no"                                                                                               
                break                                                                                                   
                ;;                                                                                                      
        esac                                                                                                            
    done                                                                                                                
done                                                                                                                    
#if the above while loop breaks it's because the player got something wrong. Therefore print score and correct answers  
if [ -f ~/.simonHS ]; then #if file ~/.simonHS exists already, catalogue high scores.                                   
    . ~/.simonHS                                                                                                        
    if [[ "$highscore" -gt $score ]]; then                                                                              
        printf "Sorry, your score wasn't as high as the current high score, which is: $highscore\n"                     
        else                                                                                                            
            printf "Congrats, you got a high score of $score!\n"                                                        
            rm ~/.simonHS #temporary until can code multiple high scores                                                
            echo "highscore='$score'" >> ~/.simonHS                                                                     
    fi                                                                                                                  
    else                                                                                                                
        read -e -r -p "Would you like to keep track of your high scores? " hsyn                                         
        case $hsyn in                                                                                                   
            [Yy]* )                                                                                                     
                echo "highscore='$score'" >> ~/.simonHS                                                                 
                ;;                                                                                                      
            [Nn]* )                                                                                                     
                printf "Okay, thanks for playing!"                                                                      
                exit                                                                                                    
                ;;                                                                                                      
        esac                                                                                                            
fi                                                                                                                      
exit                                                                                                                    
