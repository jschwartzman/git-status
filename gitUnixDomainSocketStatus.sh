#!/bin/bash
##############################################################################
# file: gitUnixDomainSocketStatus.sh
#
#                   grep the output of a git status and determine whether
#                   we need to commit any files or if we need to 
#                   track untracked files (UnixDomainSocket project)
# author: 			John Schwartzman, Forte Systems, Inc.
#
# last revision:	07/16/2018
##############################################################################

set -o nounset			# use strict (no unset variables)

escRed='\e[0;31m'       # define a few color escape sequences
escGreen='\e[0;32m'
escReset='\e[0m'

# define cmd1 and cmd2
cmd1="git status --untracked-files=no | grep -c \"nothing to commit\""
cmd2="git status --untracked-files=normal | grep -c \"Untracked files\""

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
           
numProg=6

# the nProg directories consist of the dirPrefix + prog[index] + dirSuffix
echo

##############################################################################

index=0

# for each project in turn,
#   cd to the project directory
#   evaluate cmd1 and cmd2 and save the count of strings found in
#   COUNT1 and COUNT2
#   print the results to the user based on the contents of COUNT1 and COUNT2

while [ ${index} -lt ${numProg} ] ; do
    cd "${dirPrefix}${prog[${index}]}${dirSuffix}"
    
    COUNT1=`eval ${cmd1}`
    COUNT2=`eval ${cmd2}`

    if [ $COUNT1 -eq 1 ]
    then
        echo -e "${escGreen}${prog} $strNoCommit${escReset}"
    else
        echo -e "${escRed}${prog} $strCommit${escReset}"
    fi

    if [ $COUNT2 -ne 0 ]
    then
        echo -e "${escRed}${prog} $strUntracked${escReset}"
    else
        echo -e "${escGreen}${prog} ${strNoUntracked}${escReset}"
    fi

    echo
    let index=index+1
done

##############################################################################
