#!/bin/bash
##############################################################################
# file: gitUnixDomainSocketStatus.sh
#
#                   grep the output of a git status and determine whether
#                   we need to commit any files or if we need to 
#                   track untracked files (UnixDomainSocket project)
# author: 			John Schwartzman, Forte Systems, Inc.
#
# last revision:	08/14/2018
##############################################################################

set -o nounset			# use strict (no unset variables)

escRed='\e[1;31m'       # define a few color escape sequences
escGreen='\e[0;32m'
escReset='\e[0m'

# define cmd1 and cmd2
cmd1="git status --untracked-files=no . | grep -c \"nothing to commit\""
cmd2="git status --untracked-files=normal . | grep -c \"Untracked files\""

# define the output strings
strNoCommit="has no files to commit."
strCommit="has 1 or more files that need to be committed."
strNoUntracked="has no untracked files."
strUntracked="has 1 or more untracked files."

dirPrefix="/home/js/Development/UnixDomainSocket/"
dirSuffix="/src/"

# declare an array of the 6 project names
declare -a prog[0]="utility" prog[1]="transport" prog[2]="serverTest" \
           prog[3]="clientTest" prog[4]="simpleClientTest" \
           prog[5]="utilityTest" prog[6]=""
           
numProgects=6

# the numProg directories consist of the dirPrefix + prog[index] + dirSuffix
echo

##############################################################################

index=0

# for each project in turn,
#   cd to the project directory
#   evaluate cmd1 and cmd2 and save the count of strings found in
#   count1 and count2
#   print the results to the user based on the contents of count1 and count2

while [ ${index} -lt ${numProgects} ] ; do
    cd "${dirPrefix}${prog[${index}]}${dirSuffix}"
    
    count1=`eval ${cmd1}`
    count2=`eval ${cmd2}`

    if [ $count1 -eq 1 ]
    then
        echo -e "${escGreen}${prog[${index}]} $strNoCommit"
    else
        echo -e "${escRed}${prog[${index}]} $strCommit"
    fi

    if [ $count2 -ne 0 ]
    then
        echo -e "${escRed}${prog[${index}]} $strUntracked"
    else
        echo -e "${escGreen}${prog[${index}]} ${strNoUntracked}"
    fi

    echo -e ${escReset}
    let index+=1
done

##############################################################################
